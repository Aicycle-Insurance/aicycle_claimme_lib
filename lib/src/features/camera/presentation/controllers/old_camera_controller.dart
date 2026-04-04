import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/extension/car_angle_ext.dart';
import '../../../../core/extension/xx_file.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/utils/internal_cache.dart';
import '../../../home/domain/entities/directional_image.dart';
import '../../domain/entities/car_part_has_damage.dart';
import '../../domain/entities/upload_vehicle_inspection.dart';
import '../../domain/usecases/get_list_car_part_has_damage_use_case.dart';
import '../../domain/usecases/upload_image_use_case.dart';

enum OldCameraStatus { initial, initializing, ready, error }

class OldXCameraController extends ChangeNotifier {
  OldXCameraController({required this.angle});

  final AicycleCarAngle angle;
  CameraController? _controller;
  OldCameraStatus _status = OldCameraStatus.initial;
  String _errorMessage = '';
  FlashMode _flashMode = FlashMode.off;
  XXFile? _capturedImage;
  bool _isUploading = false;

  int _currentTabIndex = 0;
  UploadVehicleInspection? _uploadResultCached;
  final List<CarPartHasDamage> _carPartHasDamages = [];
  bool _isPartLoading = false;
  CarPartHasDamage? _selectedPart;

  final Map<int, String> positionIds = {
    0: 'toan-canh-afh4l5',
    1: 'trung-canh-0s8mnb',
    2: 'can-canh-czu5jp',
  };

  CameraController? get controller => _controller;
  OldCameraStatus get status => _status;
  String get errorMessage => _errorMessage;
  FlashMode get flashMode => _flashMode;
  XXFile? get capturedImage => _capturedImage;
  bool get isUploading => _isUploading;
  int get currentTabIndex => _currentTabIndex;
  UploadVehicleInspection? get uploadResult => _uploadResultCached;
  bool get isPartLoading => _isPartLoading;
  List<CarPartHasDamage> get carPartHasDamages => _carPartHasDamages;
  CarPartHasDamage? get selectedPart => _selectedPart;

  /// Khởi tạo camera
  Future<void> initialize() async {
    try {
      _status = OldCameraStatus.initializing;
      notifyListeners();

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _status = OldCameraStatus.error;
        _errorMessage = 'No cameras found';
        notifyListeners();
        return;
      }

      final firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );

      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);

      _status = OldCameraStatus.ready;
      notifyListeners();
    } catch (e) {
      _status = OldCameraStatus.error;
      _errorMessage = 'Camera initialization failed: $e';
      notifyListeners();
    }
  }

  /// Thiết lập tab hiện tại (Toàn cảnh/Trung cảnh/Cận cảnh)
  void setTabIndex(int index) {
    _currentTabIndex = index;
    _capturedImage = null;
    _uploadResultCached = null;
    if (index == 2 && _carPartHasDamages.isEmpty) {
      getCarPartHasDamage();
    }
    notifyListeners();
  }

  void setSelectedPart(CarPartHasDamage? part) {
    _selectedPart = part;
    notifyListeners();
  }

  /// Chụp ảnh
  Future<void> takePicture(NativeDeviceOrientation orientation) async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_controller!.value.isTakingPicture) return;

    try {
      final XFile rawImage = await _controller!.takePicture();

      final rotatedImage = await ImageUtils.rotateImageIfNecessary(
        rawImage,
        orientation,
      );

      _capturedImage = XXFile.fromXFile(rotatedImage, orientation: orientation);
      notifyListeners();
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  /// Chụp lại (reset ảnh đã chụp)
  void retake() {
    _capturedImage = null;
    _uploadResultCached = null;
    notifyListeners();
  }

  /// Chuyển đổi chế độ flash
  Future<void> toggleFlash() async {
    if (_controller == null) return;

    final modes = [FlashMode.off, FlashMode.always];
    final currentIndex = modes.indexOf(_flashMode);
    final nextIndex = (currentIndex + 1) % modes.length;
    _flashMode = modes[nextIndex];

    await _controller!.setFlashMode(_flashMode);
    notifyListeners();
  }

  /// Chọn ảnh từ thư viện
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _capturedImage = XXFile.fromXFile(
        file,
        orientation: NativeDeviceOrientation.landscapeLeft,
      );
      notifyListeners();
    }
  }

  /// Upload ảnh với thông tin angle và position (cho bản cũ)
  Future<void> upload({
    required VoidCallback onSuccess,
    required void Function(EngineException warning) onWarning,
    required void Function(String message) onError,
  }) async {
    if (_capturedImage == null) return;

    try {
      _isUploading = true;
      notifyListeners();
      _uploadResultCached = null;
      final compressedImage = await ImageUtils.compressedImage(_capturedImage!);
      final claimId = InternalCache.claimId;

      final result = await sl.uploadImageUseCase(
        UploadImageParams(
          imagePath: compressedImage.path,
          claimId: claimId,
          angleId: angle.id,
          positionId: positionIds[_currentTabIndex],
          vehiclePartExcelId: _currentTabIndex == 2
              ? _selectedPart?.vehiclePartExcelId
              : null,
        ),
      );

      await getCarPartHasDamage();

      if (result.errorLevel == ErrorLevel.warning) {
        _uploadResultCached = result;
        onWarning(
          EngineException(result.errorMessage, result.errorCodeFromEngine),
        );
      } else if (result.errorLevel == ErrorLevel.error) {
        onError(result.errorMessage ?? 'Something went wrong.');
      } else {
        sl.vehicleImageVault.addImagesFromServer(
          result.angleFromEngine ?? angle,
          [
            DirectionalImage(
              imageId: result.imageId,
              imageUrl: result.imgUrl,
            ),
          ],
        );
        onSuccess();
      }
    } on EngineException catch (e) {
      onError(e.message ?? 'Something went wrong.');
    } catch (e) {
      onError(e.toString());
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  /// Tiếp tục sau khi nhận cảnh báo từ engine
  void onWarningContinue() {
    if (_uploadResultCached != null) {
      sl.vehicleImageVault
          .addImagesFromServer(_uploadResultCached!.angleFromEngine ?? angle, [
            DirectionalImage(
              imageId: _uploadResultCached!.imageId,
              imageUrl: _uploadResultCached!.imgUrl,
            ),
          ]);
    }

    _uploadResultCached = null;
    _capturedImage = null;
    notifyListeners();
  }

  /// Chụp lại sau khi nhận cảnh báo từ engine
  void onWarningRetake() async {
    if (_uploadResultCached?.imageId == null) {
      _capturedImage = null;
      _uploadResultCached = null;
      notifyListeners();
      return;
    }
    _isUploading = true;
    notifyListeners();
    await sl.vehicleImageVault.deleteImageById(_uploadResultCached!.imageId!);
    await getCarPartHasDamage();
    _isUploading = false;
    _capturedImage = null;
    _uploadResultCached = null;
    notifyListeners();
  }

  /// Lấy danh sách các bộ phận có hư hỏng
  Future<void> getCarPartHasDamage() async {
    _isPartLoading = true;
    _carPartHasDamages.clear();
    notifyListeners();
    for (final numberID in AicycleCarAngle.exterior.numberId) {
      final result = await sl.getListCarPartHasDamageUseCase(
        GetListCarPartHasDamageParams(
          claimId: InternalCache.claimId,
          directionId: numberID.toString(),
        ),
      );
      _carPartHasDamages.addAll(result);
    }
    if (_selectedPart == null && _carPartHasDamages.isNotEmpty) {
      _selectedPart = _carPartHasDamages.first;
    }
    _isPartLoading = false;
    notifyListeners();
  }

  /// Giải phóng tài nguyên camera
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
