import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../common/base_controller.dart';
import '../../../common/utils.dart';
import '../../../enum/app_state.dart';
import '../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import 'camera_page.dart';

class CameraPageController extends BaseController
    with GetTickerProviderStateMixin {
  CameraController? cameraController;
  var isInActive = false.obs;
  var isCameraLoading = false.obs;
  ClaimMeCameraArgument? argument;
  late final TabController tabController;

  late Stream<DeviceOrientation> sensorStream;
  var currentOrientation = Rx<DeviceOrientation>(DeviceOrientation.portraitUp);

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
}
