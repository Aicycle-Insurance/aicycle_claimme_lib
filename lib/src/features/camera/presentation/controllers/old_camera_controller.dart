import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
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
// import '../../domain/usecases/get_list_car_part_has_damage_use_case.dart';
import '../../domain/usecases/upload_image_use_case.dart';

/// Các trạng thái của camera cũ
enum OldCameraStatus {
  /// Trạng thái ban đầu
  initial,

  /// Đang khởi tạo camera
  initializing,

  /// Camera đã sẵn sàng sử dụng
  ready,

  /// Gặp lỗi trong quá trình khởi tạo hoặc sử dụng
  error,
}

class OldXCameraController extends ChangeNotifier {
  OldXCameraController({required this.angle});

  /// Góc chụp của xe hiện tại (ví dụ: đầu xe, đuôi xe,...)
  final AicycleCarAngle angle;

  /// Bộ điều khiển camera từ thư viện `camera`
  CameraController? _controller;

  /// Trạng thái hiện tại của camera
  OldCameraStatus _status = OldCameraStatus.initial;

  /// Thông báo lỗi khi xảy ra sự cố với camera
  String _errorMessage = '';

  /// Chế độ flash hiện tại của camera (mặc định là tắt)
  FlashMode _flashMode = FlashMode.off;

  /// Ảnh đã chụp được lưu trữ tạm thời dưới định dạng XXFile
  XXFile? _capturedImage;

  /// Trạng thái đang tải ảnh lên máy chủ (server)
  bool _isUploading = false;

  /// Trạng thái hiển thị khung hướng dẫn chụp ảnh trên màn hình
  bool _showFrame = true;

  /// Chỉ số tab hiện tại (0: Toàn cảnh, 1: Trung cảnh, 2: Cận cảnh,...)
  int _currentTabIndex = 0;

  /// Kết quả upload ảnh được lưu tạm thời (cache) để xử lý các bước tiếp theo khi có cảnh báo từ Engine
  UploadVehicleInspection? _uploadResultCached;

  /// Bộ phận xe bị hư hại đang được người dùng chọn
  CarPartHasDamage? _selectedPart;

  /// Bản đồ (Map) lưu trữ ID vị trí (position ID) tương ứng với từng chỉ số tab
  final Map<int, String> positionIds = {
    0: 'toan-canh-afh4l5',
    1: 'trung-canh-0s8mnb',
    // 2: 'can-canh-czu5jp',
  };

  /// Getter lấy bộ điều khiển camera
  CameraController? get controller => _controller;

  /// Getter lấy trạng thái hiện tại của camera
  OldCameraStatus get status => _status;

  /// Getter lấy thông báo lỗi của camera nếu có
  String get errorMessage => _errorMessage;

  /// Getter lấy chế độ flash hiện tại
  FlashMode get flashMode => _flashMode;

  /// Getter lấy file ảnh đã chụp gần nhất
  XXFile? get capturedImage => _capturedImage;

  /// Getter kiểm tra xem ảnh có đang được upload hay không
  bool get isUploading => _isUploading;

  /// Getter kiểm tra xem có hiển thị khung hướng dẫn hay không
  bool get showFrame => _showFrame;

  /// Getter lấy chỉ số tab hiện tại
  int get currentTabIndex => _currentTabIndex;

  /// Getter lấy kết quả upload ảnh từ bộ nhớ cache
  UploadVehicleInspection? get uploadResult => _uploadResultCached;

  /// Getter lấy bộ phận xe có hư hại được chọn hiện tại
  CarPartHasDamage? get selectedPart => _selectedPart;

  /// Xác định xem ảnh hiện tại có phải được chọn từ thư viện (gallery) hay không.
  bool _isPickedFromGallery = false;

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
    // if (index == 2 && _carPartHasDamages.isEmpty) {
    //   getCarPartHasDamage();
    // }
    notifyListeners();
  }

  /// Thiết lập bộ phận xe có hư hại được chọn
  void setSelectedPart(CarPartHasDamage? part) {
    _selectedPart = part;
    notifyListeners();
  }

  /// Chuyển đổi hiển thị khung hướng dẫn
  void toggleFrame() {
    _showFrame = !_showFrame;
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

      _isPickedFromGallery = false;
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
      _isPickedFromGallery = true;
      _capturedImage = XXFile.fromXFile(
        file,
        orientation: NativeDeviceOrientation.landscapeLeft,
      );
      notifyListeners();
    }
  }

  Future<void> _savePictureToGallery() async {
    // Lưu ảnh vào thư viện ảnh nếu được cấu hình và ảnh chụp từ camera
    if (AicycleClaimMe.config.generalConfig.saveToGalleryAfterCapture &&
        !_isPickedFromGallery) {
      try {
        await GallerySaver.saveImage(_capturedImage!.path);
      } catch (e) {
        debugPrint('Failed to save to gallery: $e');
      }
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

      // await getCarPartHasDamage();

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
          [DirectionalImage(imageId: result.imageId, imageUrl: result.imgUrl)],
        );
        await _savePictureToGallery();
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
      _savePictureToGallery();
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
    // await getCarPartHasDamage();
    _isUploading = false;
    _capturedImage = null;
    _uploadResultCached = null;
    notifyListeners();
  }

  /// Lấy danh sách các bộ phận có hư hỏng
  // Future<void> getCarPartHasDamage() async {
  //   _isPartLoading = true;
  //   _carPartHasDamages.clear();
  //   notifyListeners();
  //   for (final numberID in AicycleCarAngle.exterior.numberId) {
  //     final result = await sl.getListCarPartHasDamageUseCase(
  //       GetListCarPartHasDamageParams(
  //         claimId: InternalCache.claimId,
  //         directionId: numberID.toString(),
  //       ),
  //     );
  //     _carPartHasDamages.addAll(result);
  //   }
  //   if (_selectedPart == null && _carPartHasDamages.isNotEmpty) {
  //     _selectedPart = _carPartHasDamages.first;
  //   }
  //   _isPartLoading = false;
  //   notifyListeners();
  // }

  /// Giải phóng tài nguyên camera
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
