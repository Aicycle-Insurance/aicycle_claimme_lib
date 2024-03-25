// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../aicycle_claimme_lib.dart';
import '../../../common/base_widget.dart';
import '../../../common/c_button.dart';
import '../../../common/c_loading_view.dart';
import '../../../common/themes/c_colors.dart';
import '../../../enum/car_part_direction.dart';
import '../../../generated/assets.gen.dart';
import '../../../common/extension/translation_ext.dart';
import '../../../generated/locales.g.dart';
import '../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import '../../camera/data/models/damage_assessment_response.dart';
import 'folder_detail_controller.dart';
import 'widgets/car_position.dart';

class FolderDetailPage extends StatefulWidget {
  const FolderDetailPage({
    super.key,
    this.hasAppBar,
    required this.argument,
    this.onViewResultCallBack,
    this.onCallEngineSuccessfully,
  });

  final bool? hasAppBar;
  final Function(dynamic result)? onViewResultCallBack;
  final Function(DamageAssessmentResponse?)? onCallEngineSuccessfully;
  final AiCycleClaimMeArgument argument;

  @override
  State<FolderDetailPage> createState() => _FolderDetailPageState();
}

class _FolderDetailPageState
    extends BaseState<FolderDetailPage, ClaimMeFolderDetailController> {
  late final StreamSubscription callEngineSub;
  @override
  ClaimMeFolderDetailController provideController() {
    if (Get.isRegistered<ClaimMeFolderDetailController>()) {
      return Get.find<ClaimMeFolderDetailController>();
    } else {
      return Get.put(ClaimMeFolderDetailController());
    }
  }

  @override
  void initState() {
    super.initState();
    apiToken = widget.argument.apiToken;
    environment = widget.argument.environtment ?? Evn.production;
    locale = widget.argument.locale;
    enableVersion2 = widget.argument.enableVersion2 ?? true;
    isAICycle = widget.argument.isAICycle ?? true;
    controller.argument = widget.argument;

    callEngineSub = controller.damageResponseStream.stream.listen((p0) {
      if (p0 != null) {
        widget.onCallEngineSuccessfully?.call(p0);
      }
    });
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
      body: LoadingView<ClaimMeFolderDetailController>(
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
                        child: Obx(
                          () => CarPosition(
                            direction: CarPartDirectionEnum.front,
                            claimFolderId: widget.argument.aicycleClaimId ??
                                widget.argument.externalClaimId,
                            imageDirectionModel: controller.front.value,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: Obx(
                            () => CarPosition(
                              direction: CarPartDirectionEnum.rightFront,
                              claimFolderId: widget.argument.aicycleClaimId ??
                                  widget.argument.externalClaimId,
                              imageDirectionModel: controller.rightFront.value,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: Obx(
                            () => CarPosition(
                              direction: CarPartDirectionEnum.leftFront,
                              claimFolderId: widget.argument.aicycleClaimId ??
                                  widget.argument.externalClaimId,
                              imageDirectionModel: controller.leftFront.value,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 64),
                          child: Obx(
                            () => CarPosition(
                              direction: CarPartDirectionEnum.leftBack,
                              claimFolderId: widget.argument.aicycleClaimId ??
                                  widget.argument.externalClaimId,
                              imageDirectionModel: controller.leftBack.value,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 64),
                          child: Obx(
                            () => CarPosition(
                              direction: CarPartDirectionEnum.rightBack,
                              claimFolderId: widget.argument.aicycleClaimId ??
                                  widget.argument.externalClaimId,
                              imageDirectionModel: controller.rightBack.value,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Obx(
                          () => CarPosition(
                            direction: CarPartDirectionEnum.back,
                            claimFolderId: widget.argument.aicycleClaimId ??
                                widget.argument.externalClaimId,
                            imageDirectionModel: controller.back.value,
                          ),
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
              child: CButton(
                isDisable: false,
                onPressed: () =>
                    controller.getResult(widget.onViewResultCallBack),
                title: LocaleKeys.viewResult.trans,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
