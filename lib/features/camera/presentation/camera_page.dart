import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/extension/translation_ext.dart';
import '../../../common/base_widget.dart';
import '../../../common/c_loading_view.dart';
import '../../../common/themes/c_colors.dart';
import '../../../enum/car_model.dart';
import '../../../enum/car_part_direction.dart';
import '../../../generated/locales.g.dart';
import 'camera_page_controller.dart';
import 'widgets/camera_appbar_title.dart';
import 'widgets/camera_bottom_bar.dart';

class ClaimMeCameraArgument {
  final CarPartDirectionEnum carPartDirectionEnum;
  final CarModelEnum carModelEnum;
  final String claimId;

  ClaimMeCameraArgument({
    required this.carPartDirectionEnum,
    required this.carModelEnum,
    required this.claimId,
  });
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.argument});
  final ClaimMeCameraArgument argument;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends BaseState<CameraPage, CameraPageController> {
  @override
  void initState() {
    super.initState();
    controller.argument = widget.argument;
  }

  @override
  CameraPageController provideController() {
    if (Get.isRegistered<CameraPageController>()) {
      return Get.find<CameraPageController>();
    } else {
      return Get.put(CameraPageController());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          leadingWidth: 0,
          bottom: _tabs(),
          title: Obx(
            () => CameraAppBarTitle(
              orientation: controller.currentOrientation.value,
              onPop: () {},
              onGalleryPicker: () {},
              carPartDirectionEnum: widget.argument.carPartDirectionEnum,
            ),
          ),
        ),
        backgroundColor: CColors.black,
        body: LoadingView<CameraPageController>(
          isCustomLoading: true,
          quarterTurns: 1,
          child: GetBuilder<CameraPageController>(
            id: 'camera',
            builder: (ctrl) {
              if (controller.isCameraLoading.isTrue ||
                  controller.isInActive.isTrue ||
                  controller.cameraController == null ||
                  controller.cameraController?.value.isInitialized != true) {
                return const SizedBox.expand(
                  child: Center(
                    child: CupertinoActivityIndicator(color: CColors.white),
                  ),
                );
              }
              final frameAspectRatio = MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height - kToolbarHeight);
              final scale = 1 /
                  (controller.cameraController!.value.aspectRatio *
                      frameAspectRatio);

              return Stack(
                children: [
                  /// camera view
                  Center(
                    child: Transform.scale(
                      scale: scale,
                      child: CameraPreview(
                        controller.cameraController!,
                      ),
                    ),
                  ),

                  /// bottom bar
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Obx(
                        () => AiCameraBottomBar(
                          orientation: controller.currentOrientation.value,
                          takePhoto: () {},
                          toggleFlashMode: () {},
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  PreferredSizeWidget _tabs() {
    return TabBar(
      padding: EdgeInsets.zero,
      controller: controller.tabController,
      onTap: (index) {},
      tabs: [
        Tab(text: LocaleKeys.longShot.trans),
        Tab(text: LocaleKeys.middleShot.trans),
        Tab(text: LocaleKeys.closeUpShot.trans),
      ],
    );
  }
}
