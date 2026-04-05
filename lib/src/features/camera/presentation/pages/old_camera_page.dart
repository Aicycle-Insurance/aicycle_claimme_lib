import 'package:aicycle_claimme_plus/src/core/extension/car_angle_ext.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/error/exceptions.dart';
// import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_strings.dart';
// import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/orientation_utils.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/validation_dialog.dart';
import '../widgets/old_camera_bottom_bar.dart';
import '../widgets/old_camera_part_selector.dart';
import '../widgets/photo_preview.dart';
import '../controllers/old_camera_controller.dart';

class OldCameraPage extends StatefulWidget {
  const OldCameraPage({super.key, required this.angle});

  final AicycleCarAngle angle;

  @override
  State<OldCameraPage> createState() => _OldCameraPageState();
}

class _OldCameraPageState extends State<OldCameraPage>
    with TickerProviderStateMixin {
  late final OldXCameraController _controller;
  late final TabController _tabController;
  bool _showPartSelector = false;
  // double _snackBarRightOffset = -350.0; // Hidden by default

  @override
  void initState() {
    super.initState();
    _controller = OldXCameraController(angle: widget.angle);
    _controller.initialize();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     if (_tabController.index == 2) {
    //       if (_controller.isPartLoading) {
    //         _tabController.index = _tabController.previousIndex;
    //         return;
    //       }
    //       if (_controller.carPartHasDamages.isEmpty) {
    //         _tabController.index = _tabController.previousIndex;
    //         _showSnackBarFromRight();
    //         return;
    //       }
    //     }
    //   }
    //   _controller.setTabIndex(_tabController.index);
    // });
    // _controller.getCarPartHasDamage();
  }

  // void _showSnackBarFromRight() {
  //   setState(() {
  //     _snackBarRightOffset = 16.0;
  //   });
  //   Future.delayed(const Duration(seconds: 3), () {
  //     if (mounted) {
  //       setState(() {
  //         _snackBarRightOffset = -350.0;
  //       });
  //     }
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onWarning(EngineException warning) {
    if (mounted) {
      CommonValidationDialog.show(
        context: context,
        title: AppStrings.warning,
        quarterTurns: 1,
        message: warning.message ?? 'Something went wrong.',
        primaryButtonLabel: AppStrings.btnRetake,
        secondaryButtonLabel: AppStrings.btnContinue,
        onPrimaryTapped: () {
          Navigator.pop(context);
          _controller.onWarningRetake();
        },
        onSecondaryTapped: () {
          Navigator.pop(context);
          _controller.onWarningContinue();
        },
      );
    }
  }

  void _onError(String message) {
    if (mounted) {
      CommonValidationDialog.show(
        context: context,
        title: AppStrings.error,
        quarterTurns: 1,
        message: message,
        primaryButtonLabel: AppStrings.btnRetake,
        onPrimaryTapped: () {
          Navigator.pop(context);
          _controller.retake();
        },
      );
    }
  }

  IconData _getFlashIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.torch:
        return Icons.highlight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NativeDeviceOrientationReader(
      useSensor: true,
      builder: (context) {
        final orientation = NativeDeviceOrientationReader.orientation(context);
        final turns = OrientationUtils.getTurns(orientation);

        return ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            if (_controller.status == OldCameraStatus.initializing ||
                _controller.status == OldCameraStatus.initial) {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (_controller.status == OldCameraStatus.ready &&
                _controller.controller != null) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _showPartSelector = false;
                  });
                },
                child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    // toolbarHeight: kToolbarHeight,
                    leading: Visibility(
                      visible: _controller.capturedImage == null,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      ),
                    ),
                    actions: [
                      Visibility(
                        visible: _controller.capturedImage == null,
                        child: InkWell(
                          onTap: _controller.toggleFlash,
                          child: AnimatedRotation(
                            turns: turns,
                            duration: const Duration(milliseconds: 300),
                            child: Icon(
                              _getFlashIcon(_controller.flashMode),
                              color: Colors.white,
                              size: 24.r,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                    ],
                    title: Text(widget.angle.title),
                    bottom: _tabs(),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Center(
                          child: ClipRect(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width *
                                    _controller.controller!.value.aspectRatio,
                                child: CameraPreview(
                                  _controller.controller!,
                                  child: Stack(
                                    children: [
                                      /// Part Selector Button (Top Left)
                                      if (_tabController.index == 2 &&
                                          _controller.capturedImage == null)
                                        Positioned(
                                          top: 16.h,
                                          right: 16.w,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child: OldCameraPartSelector(
                                              controller: _controller,
                                              showSelector: _showPartSelector,
                                              onToggle: () {
                                                setState(() {
                                                  _showPartSelector =
                                                      !_showPartSelector;
                                                });
                                              },
                                              onPartSelected: (part) {
                                                _controller.setSelectedPart(
                                                  part,
                                                );
                                                setState(() {
                                                  _showPartSelector = false;
                                                });
                                              },
                                            ),
                                          ),
                                        ),

                                      /// Bottom Controls
                                      Visibility(
                                        visible:
                                            _controller.capturedImage == null,
                                        child: OldCameraBottomBar(
                                          controller: _controller,
                                          orientation: orientation,
                                          turns: turns,
                                        ),
                                      ),

                                      /// Sliding SnackBar (Custom)
                                      // AnimatedPositioned(
                                      //   duration: const Duration(
                                      //     milliseconds: 500,
                                      //   ),
                                      //   curve: Curves.easeOutCubic,
                                      //   right: _snackBarRightOffset,
                                      //   top: 0,
                                      //   bottom: 0,
                                      //   child: Center(
                                      //     child: Material(
                                      //       color: Colors.transparent,
                                      //       child: RotatedBox(
                                      //         quarterTurns: 1,
                                      //         child: Container(
                                      //           padding: EdgeInsets.symmetric(
                                      //             horizontal: 16.w,
                                      //             vertical: 12.h,
                                      //           ),
                                      //           decoration: BoxDecoration(
                                      //             color: AppColors.info,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                   8.r,
                                      //                 ),
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                 color: Colors.black26,
                                      //                 blurRadius: 10.r,
                                      //                 offset: const Offset(
                                      //                   0,
                                      //                   4,
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           child: AnimatedRotation(
                                      //             turns: turns,
                                      //             duration: const Duration(
                                      //               milliseconds: 300,
                                      //             ),
                                      //             child: Text(
                                      //               AppStrings.noDamageParts,
                                      //               style: AppTextStyles
                                      //                   .bodyMedium
                                      //                   .copyWith(
                                      //                     color: Colors.white,
                                      //                   ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),

                                      /// Photo preview
                                      if (_controller.capturedImage != null)
                                        PhotoPreview(
                                          image: _controller.capturedImage!,
                                          isUploading: _controller.isUploading,
                                          onRetake: _controller.retake,
                                          onSave: () async {
                                            await _controller.upload(
                                              onSuccess: _controller.retake,
                                              onWarning: _onWarning,
                                              onError: _onError,
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Scaffold(
              backgroundColor: Colors.black,
              body: SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _tabs() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: IgnorePointer(
        ignoring: _controller.capturedImage != null,
        child: Opacity(
          opacity: _controller.capturedImage != null ? 0.5 : 1,
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _showPartSelector = false;
              });
            },
            tabs: [
              const Tab(text: AppStrings.captureRangeOverview),
              const Tab(text: AppStrings.captureRangeMiddle),
              // Tab(
              //   child: _controller.isPartLoading
              //       ? SizedBox(
              //           width: 16.r,
              //           height: 16.r,
              //           child: const CircularProgressIndicator(
              //             strokeWidth: 2,
              //             color: Colors.white,
              //           ),
              //         )
              //       : const Text(AppStrings.captureRangeDetail),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
