// ignore_for_file: invalid_use_of_protected_member

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../common/extension/translation_ext.dart';
import '../../../common/base_controller.dart';
import '../../../common/contants/direction_constant.dart';
import '../../../common/utils.dart';
import '../../../enum/app_state.dart';
import '../../../generated/locales.g.dart';
import '../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import '../../direction_detail.dart/domain/usecase/delete_image_by_id_usecase.dart';
import '../../direction_detail.dart/domain/usecase/get_car_part_has_damage_usecase.dart';
import '../../direction_detail.dart/presentation/direction_detail_controller.dart';
import '../../folder_detail/presentation/folder_detail_controller.dart';
import '../data/models/car_part_has_damage_model.dart';
import '../data/models/damage_assessment_response.dart';
import '../domain/usecase/call_engine_usecase.dart';
import '../domain/usecase/upload_image_usecase.dart';
import 'camera_page.dart';

class CameraPageController extends BaseController
    with GetTickerProviderStateMixin {
  final UploadImageUsecase uploadImageToS3Server = Get.find();
  final CallEngineUsecase callEngineUsecase = Get.find();
  final DeleteImageByIdUsecase deleteImageByIdUsecase = Get.find();
  final GetCarPartHasDamageUsecase getCarPartHasDamageUsecase = Get.find();

  CameraController? cameraController;
  var isInActive = false.obs;
  var isCameraLoading = false.obs;
  ClaimMeCameraArgument? argument;
  late final TabController tabController;
  var flashMode = Rx<FlashMode>(FlashMode.off);
  var previewFile = Rx<XFile?>(null);
  var isResizing = false.obs;

  late Stream<DeviceOrientation> sensorStream;
  var currentOrientation = Rx<DeviceOrientation>(DeviceOrientation.portraitUp);

  var showRetake = false.obs;
  var showErrorDialog = false.obs;
  var currentTabIndex = 0.obs;
  var carPartOnSelected = Rx<CarPartHasDamageModel?>(null);
  var isConfidentLevelWarning = false.obs;
  var damageAssessmentResponse = Rx<DamageAssessmentResponse?>(null);
  var isPortraitUpWhileTakePhoto = false.obs;

  ///
  DamageAssessmentResponse? cacheDamageResponse;
  Map<String, dynamic> cacheValidationModel = {};

  ///
  final Map<int, Map<String, String>> imageRangeIds = {
    0: {"name": LocaleKeys.longShot.trans, "id": 'toan-canh-afh4l5'},
    1: {'name': LocaleKeys.middleShot.trans, 'id': 'trung-canh-0s8mnb'},
    2: {'name': LocaleKeys.closeUpShot.trans, 'id': 'can-canh-czu5jp'},
  };
  Map<String, String>? get currentAnggle =>
      imageRangeIds[currentTabIndex.value];

  ///
  var carPartsForCloseUpShot = <CarPartHasDamageModel>[].obs;

  ///
  var longShotImages = <String>[].obs;
  var middleShotImages = <String>[].obs;
  var closeUpShotImages = <String>[].obs;

  List<String> get currentImageList {
    switch (currentTabIndex.value) {
      case 0:
        return longShotImages.value;
      case 1:
        return middleShotImages.value;
      case 2:
        return closeUpShotImages.value;
      default:
        return longShotImages.value;
    }
  }

  ///
  var currentReplacedImageId = ''.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 3, vsync: this);
    if (cameras.isNotEmpty) {
      onNewCameraSelected(cameras[0]);
    }
    sensorStream = accelerometerEventStream()
        .map<DeviceOrientation>(Utils.getOrientation)
        .distinct();
    sensorStream.listen((event) {
      currentOrientation.value = event;
    });
    super.onInit();
  }

  @override
  void onReady() {
    if (cameras.isEmpty) {
      status.value = BaseStatus(
        message: 'No camera found',
        state: AppState.pop,
      );
    }
    super.onReady();
    if (argument?.longShotImages != null) {
      longShotImages.assignAll(argument!.longShotImages!
          .map((e) => e.imageUrl ?? e.url ?? '')
          .toList());
    }
    if (argument?.middleShotImages != null) {
      middleShotImages.assignAll(argument!.middleShotImages!
          .map((e) => e.imageUrl ?? e.url ?? '')
          .toList());
    }
    if (argument?.closeUpShotImages != null) {
      closeUpShotImages.assignAll(argument!.closeUpShotImages!
          .map((e) => e.imageUrl ?? e.url ?? '')
          .toList());
    }
    if (argument?.carPartHasDamage != null &&
        argument!.carPartHasDamage!.isNotEmpty) {
      carPartsForCloseUpShot.value.assignAll(argument!.carPartHasDamage!);
      carPartOnSelected.value = carPartsForCloseUpShot.value.first;
    }
    if (argument?.oldImageId != null) {
      currentReplacedImageId.value = argument!.oldImageId ?? '';
    }
    if (argument?.initPositionIndex != null) {
      onTabChanged(argument!.initPositionIndex!);
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    isCameraLoading(true);
    final CameraController? oldController = cameraController;
    if (oldController != null) {
      cameraController = null;
      await oldController.dispose();
    }
    final CameraController cameraCtrl = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    cameraController = cameraCtrl;
    // If the controller is updated then update the UI.
    cameraCtrl.addListener(() {
      if (cameraCtrl.value.hasError) {
        status.value = BaseStatus(
          message: 'Camera error',
          state: AppState.failed,
        );
      }
    });
    try {
      await cameraCtrl.initialize();
      // if (Platform.isIOS) {
      //   cameraCtrl.lockCaptureOrientation(DeviceOrientation.landscapeLeft);
      // }
      isCameraLoading(false);
    } on CameraException catch (_) {
      isCameraLoading(false);
      status.value = BaseStatus(
        message: 'No camera found',
        state: AppState.pop,
      );
    }
    update(['camera']);
  }

  void switchFlashMode() async {
    if (flashMode() == FlashMode.off) {
      await cameraController?.setFlashMode(FlashMode.torch);
      flashMode.value = FlashMode.torch;
    } else {
      await cameraController?.setFlashMode(FlashMode.off);
      flashMode.value = FlashMode.off;
    }
  }

  Future<void> onTakePhoto() async {
    late int rotate;
    if (currentOrientation.value == DeviceOrientation.landscapeLeft) {
      isPortraitUpWhileTakePhoto(false);
      rotate = -90;
    } else if (currentOrientation.value == DeviceOrientation.landscapeRight) {
      isPortraitUpWhileTakePhoto(false);
      rotate = 90;
    } else {
      isPortraitUpWhileTakePhoto(true);
      rotate = 0;
    }

    ///
    if (previewFile.value == null) {
      previewFile.value = await cameraController?.takePicture();
      await cameraController?.pausePreview();
      if (previewFile.value != null) {
        isResizing.value = true;
        final resizeFile = await Utils.compressImageV2(
          previewFile.value!,
          100,
          rotate: rotate,
          imageSizeCallBack: (p0) {
            // localImageSize.value = p0;
          },
        );
        previewFile.value = resizeFile;
        isResizing.value = false;
        callEngine(resizeFile);
      }
    } else {
      await cameraController?.resumePreview();
    }
  }

  Future<void> onGalleryPick() async {
    if (previewFile.value == null) {
      isPortraitUpWhileTakePhoto(false);
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        previewFile.value = pickedFile;
        isResizing.value = true;
        var resizeFile = await Utils.compressImageV2(
          pickedFile,
          100,
          imageSizeCallBack: (p0) {},
        );
        previewFile.value = resizeFile;
        isResizing.value = false;
        await callEngine(resizeFile);
      }
    }
  }

  Future<void> callEngine(XFile file) async {
    if (argument != null) {
      /// Tính thời gian upload
      isLoading.value = true;
      final Stopwatch timer = Stopwatch();
      timer.start();
      var uploadRes = await uploadImageToS3Server(localFilePath: file.path);
      timer.stop();
      // Kết thúc
      uploadRes.fold(
        (l) {
          isLoading(false);
          status(
            BaseStatus(
              message: l.message.toString(),
              state: AppState.customError,
            ),
          );
          showErrorDialog(true);
          showRetake(true);
        },
        (r) async {
          if (r.level == 'info' && r.filePath != null) {
            await callEngineImpl(
              localFilePath: file.path,
              serverFilePath: r.filePath!,
              timeAppUpload: timer.elapsedMilliseconds / 1000,
            );
          }

          /// warning
          else if (r.level == 'warning') {
            cacheValidationModel['localFilePath'] = file.path;
            cacheValidationModel['serverFilePath'] = r.filePath;
            cacheValidationModel['timeAppUpload'] =
                timer.elapsedMilliseconds / 1000;
            isLoading(false);
            showRetake(false);
            status(BaseStatus(
              message: r.message ?? 'Warning',
              state: AppState.warning,
            ));
          }

          /// error
          else {
            isLoading(false);
            status(BaseStatus(
              message: null,
              state: AppState.idle,
            ));
            showRetake(true);
          }
        },
      );
    }
  }

  Future<void> callEngineImpl({
    required String localFilePath,
    required String serverFilePath,
    double? timeAppUpload,
  }) async {
    var callEngineRes = await callEngineUsecase(
      claimId: argument!.claimId,
      imageName: basename(localFilePath),
      filePath: serverFilePath,
      position: positionIds[currentTabIndex.value],
      direction: argument!.carPartDirectionEnum.excelId,
      vehiclePartExcelId: currentTabIndex.value == 2
          ? carPartOnSelected.value?.vehiclePartExcelId ?? ''
          : '',
      timeAppUpload: timeAppUpload,
      utcTimeCreated: DateTime.now().toUtc().toIso8601String(),
      oldImageId: currentReplacedImageId.value.isNotEmpty
          ? currentReplacedImageId.value
          : null,
    );

    callEngineRes.fold((l) {
      isLoading(false);

      /// Code from engine
      if (l.errorCodeFromEngine != null) {
        status(
          BaseStatus(
            message: l.message.toString(),
            state: AppState.customError,
          ),
        );
        showErrorDialog(true);
        status(
          BaseStatus(
            message: l.message.toString(),
            state: AppState.customError,
          ),
        );
        showRetake(false);
        showErrorDialog(true);
      } else {
        status(
          BaseStatus(
            message: l.message.toString(),
            state: AppState.customError,
          ),
        );
        showErrorDialog(true);
        showRetake(true);
      }
    }, (r) async {
      await getCarPartsForCloseUpShot();
      isLoading(false);
      if (currentTabIndex.value == 2) {
        updateDirection(r);
        previewFile.value = null;
        cameraController?.resumePreview();
      } else if (r.errorCodeFromEngine == null || r.errorCodeFromEngine == 0) {
        updateDirection(r);
        status(
          BaseStatus(
            message: null,
            state: AppState.success,
          ),
        );
        damageAssessmentResponse.value = r;
        showRetake(false);
      } else {
        cacheDamageResponse = r;

        /// confident level thấp
        if (r.errorCodeFromEngine == 66616) {
          status(
            BaseStatus(
              message: r.message,
              state: AppState.warning,
            ),
          );
          showRetake(false);
          isConfidentLevelWarning(true);
        } else {
          status(
            BaseStatus(
              message: r.message,
              state: AppState.customError,
            ),
          );
          showRetake(false);
          showErrorDialog(true);
        }
      }
    });
  }

  updateDirection(DamageAssessmentResponse response) async {
    switch (currentTabIndex.value) {
      case 0:
        longShotImages.assignAll([response.result?.imgUrl ?? '']);

        ///
        if (Get.isRegistered<DirectionDetailController>()) {
          Get.find<DirectionDetailController>().getDirectionImage(1);
          Get.find<DirectionDetailController>().getCarPartsForCloseUpShot();
        }
        break;
      case 1:
        middleShotImages.add(response.result?.imgUrl ?? '');
        if (currentReplacedImageId.value.isNotEmpty) {
          middleShotImages.removeAt(0);
        }

        ///
        if (Get.isRegistered<DirectionDetailController>()) {
          Get.find<DirectionDetailController>().getDirectionImage(2);
          Get.find<DirectionDetailController>().getCarPartsForCloseUpShot();
        }
        break;
      case 2:
        closeUpShotImages.add(response.result?.imgUrl ?? '');
        if (currentReplacedImageId.value.isNotEmpty) {
          closeUpShotImages.removeAt(0);
        }

        ///
        if (Get.isRegistered<DirectionDetailController>()) {
          Get.find<DirectionDetailController>().getDirectionImage(3);
        }
        break;
    }
    currentReplacedImageId.value = '';

    ///
    if (Get.isRegistered<FolderDetailController>()) {
      await Get.find<FolderDetailController>().getImageDirection();
    }
  }

  void engineWarningHandle(String action) async {
    switch (action) {
      case 'next':
        if (cacheValidationModel['localFilePath'] != null &&
            cacheValidationModel['serverFilePath'] != null) {
          await callEngineImpl(
            localFilePath: cacheValidationModel['localFilePath'],
            serverFilePath: cacheValidationModel['serverFilePath'],
            timeAppUpload: cacheValidationModel['timeAppUpload'],
          );
        } else {
          status(
              BaseStatus(message: 'Hệ thống lỗi', state: AppState.customError));
          showErrorDialog(true);
          damageAssessmentResponse.value = null;
          previewFile.value = null;
        }
        break;
      case 'save':
        if (cacheDamageResponse != null) {
          updateDirection(cacheDamageResponse!);
        }
        status(BaseStatus(message: null, state: AppState.pop));
        damageAssessmentResponse.value = cacheDamageResponse;
        break;
      case 'retake':
        cameraController?.resumePreview();
        if (status.value.state == AppState.warning &&
            cacheDamageResponse != null) {
          await deleteImageByIdUsecase(
                  imageId: cacheDamageResponse!.imageId.toString())
              .then((value) => cacheDamageResponse = null);
        }
        previewFile.value = null;
        cacheValidationModel = {};
        status(BaseStatus(message: null, state: AppState.idle));
        damageAssessmentResponse.value = null;
        showErrorDialog(false);
        cacheDamageResponse = null;
        break;
    }
  }

  void onNextTapped() {
    if (currentTabIndex.value == 0) {
      onTabChanged(1);
    } else if (currentTabIndex.value == 1 &&
        carPartsForCloseUpShot.isNotEmpty) {
      onTabChanged(2);
    }
  }

  void onTabChanged(int index) {
    damageAssessmentResponse.value = null;
    currentReplacedImageId.value = '';
    cacheValidationModel = {};
    damageAssessmentResponse.value = null;
    showErrorDialog(false);
    cacheDamageResponse = null;
    previewFile.value = null;
    if (index == 2 && carPartsForCloseUpShot.isEmpty) {
      status(
        BaseStatus(
          message: LocaleKeys.needValidImage.trans,
          state: AppState.failed,
        ),
      );
      onTabChanged(1);
    } else {
      status(
        BaseStatus(
          message: '',
          state: AppState.idle,
        ),
      );
      previewFile.value = null;
      currentTabIndex(index);
      tabController.animateTo(index);
    }
  }

  var partLoading = false.obs;
  Future<void> getCarPartsForCloseUpShot() async {
    if (argument?.claimId == null) {
      return;
    }
    partLoading(true);
    processUsecaseResult(
      result: await getCarPartHasDamageUsecase(
        claimId: argument!.claimId,
        partDirectionId: argument!.carPartDirectionEnum.id,
      ),
      onFail: (p0) => partLoading(false),
      onSuccess: (value) {
        partLoading(false);
        carPartsForCloseUpShot.assignAll(value);
        if (value.isNotEmpty) {
          carPartOnSelected.value = value.first;
        }
      },
    );
  }
}
