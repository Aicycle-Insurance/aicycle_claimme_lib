import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/themes/c_textstyle.dart';
import '../../../common/extension/translation_ext.dart';
import '../../../common/base_widget.dart';
import '../../../common/c_loading_view.dart';
import '../../../common/themes/c_colors.dart';
import '../../../enum/app_state.dart';
import '../../../enum/car_model.dart';
import '../../../enum/car_part_direction.dart';
import '../../../generated/locales.g.dart';
import 'camera_page_controller.dart';
import 'widgets/camera_appbar_title.dart';
import 'widgets/camera_bottom_bar.dart';
import 'widgets/error_dialog.dart';
import 'widgets/guide_frame.dart';
import 'widgets/preview_with_mask.dart';
import 'widgets/warning_dialog.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: WillPopScope(
        onWillPop: () => onWillPop(context),
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
                onPop: () => onWillPop(context),
                onGalleryPicker: controller.onGalleryPick,
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

                    /// image with mask
                    Obx(() {
                      if (controller.previewFile.value != null) {
                        return Positioned.fill(
                          child: RotatedBox(
                            quarterTurns:
                                controller.isPortraitUpWhileTakePhoto() ? 0 : 1,
                            child: Stack(
                              children: [
                                PreviewWithMask(
                                  file: controller.previewFile.value!,
                                  damageAssessmentModel: controller
                                      .damageAssessmentResponse.value?.result,
                                  onYesTapped: controller.onNextTapped,
                                  onNoTapped: () {},
                                ),

                                /// compressing widget
                                if (controller.isResizing())
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      width: screenHeight / 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            LocaleKeys.compressing.trans,
                                            style: CTextStyles
                                                .base.whiteColor.s14
                                                .w500(),
                                          ),
                                          const LinearProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        /// Guide frame
                        return Positioned.fill(
                          bottom: 100,
                          top: 24,
                          child: Obx(
                            () => GuideFrame(
                              carPartDirectionEnum:
                                  widget.argument.carPartDirectionEnum,
                              rangeShot:
                                  controller.currentAnggle?['name'] ?? '',
                            ),
                          ),
                        );
                      }
                    }),

                    /// warning
                    Obx(
                      () {
                        if (controller.status().state == AppState.warning &&
                            controller.status().message != null) {
                          String message = controller.status().message ?? '';
                          if (controller.isConfidentLevelWarning.isTrue) {
                            message = message.split('.').join('\n');
                          }
                          return Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: WarningDialog(
                                description: message,
                                leftButtonText: controller
                                            .cacheDamageResponse !=
                                        null
                                    ? controller.isConfidentLevelWarning.isTrue
                                        ? LocaleKeys.next.trans
                                        : LocaleKeys.save.trans
                                    : LocaleKeys.next.trans,
                                leftPressed: () =>
                                    controller.cacheDamageResponse != null
                                        ? controller.engineWarningHandle('save')
                                        : controller
                                            .engineWarningHandle('next'),
                                rightPressed: () =>
                                    controller.engineWarningHandle('retake'),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    /// error
                    Obx(
                      () {
                        if (controller.status().state == AppState.customError &&
                            controller.showErrorDialog.isTrue &&
                            controller.status().message != null) {
                          final message = controller.status().message;
                          return Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: ErrorDialog(
                                retake: () =>
                                    controller.engineWarningHandle('retake'),
                                description: LocaleKeys.error.trans,
                                subDescription: LocaleKeys.reason.trans
                                    .replaceAll('@message', message ?? '...'),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    /// bottom bar
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Obx(
                          () => AiCameraBottomBar(
                            orientation: controller.currentOrientation.value,
                            takePhoto: controller.onTakePhoto,
                            toggleFlashMode: controller.switchFlashMode,
                            flashMode: controller.flashMode.value,
                            previewFile: controller.previewFile.value,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  PreferredSizeWidget _tabs() {
    return TabBar(
      padding: EdgeInsets.zero,
      controller: controller.tabController,
      onTap: controller.onTabChanged,
      tabs: [
        Tab(text: LocaleKeys.longShot.trans),
        Tab(text: LocaleKeys.middleShot.trans),
        Tab(text: LocaleKeys.closeUpShot.trans),
      ],
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    Navigator.pop(
      context,
      '',
    );
    return false;
  }
}
