import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../aicycle.dart';
import '../../../aicycle_claimme_lib.dart';
import '../../../common/base_widget.dart';
// import '../../../common/c_button.dart';
import '../../../common/c_loading_view.dart';
// import '../../../common/extension/translation_ext.dart';
import '../../../common/themes/c_colors.dart';
import '../../../enum/car_part_direction.dart';
import '../../../generated/assets.gen.dart';
// import '../../../generated/locales.g.dart';
import 'folder_detail_controller.dart';
import 'widgets/car_position.dart';

class FolderDetailPage extends StatefulWidget {
  const FolderDetailPage({
    super.key,
    this.hasAppBar,
    required this.argument,
  });

  final bool? hasAppBar;
  // final Function(List<BuyMeImage>? images)? onViewResultCallBack;
  // final Function(DamageAssessmentResponse?)? onCallEngineSuccessfully;
  final AiCycleClaimMeArgument argument;

  @override
  State<FolderDetailPage> createState() => _FolderDetailPageState();
}

class _FolderDetailPageState
    extends BaseState<FolderDetailPage, FolderDetailController> {
  @override
  FolderDetailController provideController() {
    if (Get.isRegistered<FolderDetailController>()) {
      return Get.find<FolderDetailController>();
    } else {
      return Get.put(FolderDetailController());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: (widget.hasAppBar ?? true)
          ? AppBar(
              backgroundColor: CColors.white,
              elevation: 0.7,
            )
          : null,
      body: LoadingView<FolderDetailController>(
        isCustomLoading: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Container(
                  height: 400,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Assets.images.car.image(
                          package: packageName,
                          height: 167,
                          width: 113,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: CarPosition(
                          direction: CarPartDirectionEnum.front,
                          claimFolderId: widget.argument.externalClaimId,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: CarPosition(
                            direction: CarPartDirectionEnum.rightFront,
                            claimFolderId: widget.argument.externalClaimId,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: CarPosition(
                            direction: CarPartDirectionEnum.leftFront,
                            claimFolderId: widget.argument.externalClaimId,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 64),
                          child: CarPosition(
                            direction: CarPartDirectionEnum.leftBack,
                            claimFolderId: widget.argument.externalClaimId,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 64),
                          child: CarPosition(
                            direction: CarPartDirectionEnum.rightBack,
                            claimFolderId: widget.argument.externalClaimId,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CarPosition(
                          direction: CarPartDirectionEnum.back,
                          claimFolderId: widget.argument.externalClaimId,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// button
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 32,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              // child: Obx(
              //   () => CButton(
              //     isDisable: false,
              //     onPressed: () {
              //       // widget.onViewResultCallBack
              //       //     ?.call(controller.imageInfo.value?.images);
              //       // Navigator.pop(context);
              //     },
              //     title: LocaleKeys.viewResult.trans,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
