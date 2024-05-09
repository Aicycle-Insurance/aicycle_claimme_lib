// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:aicycle_claimme_lib/common/color_utils.dart';
import 'package:aicycle_claimme_lib/features/aicycle_claim_me/data/model/setting_model.dart';
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
import 'folder_detail_controller.dart';
import 'widgets/car_position.dart';

class FolderDetailPage extends StatefulWidget {
  const FolderDetailPage({
    super.key,
    this.hasAppBar,
    required this.argument,
    this.onViewResultCallBack,
    this.onResultChanged,
    this.uiSettings,
  });

  final bool? hasAppBar;
  final Function(dynamic result)? onViewResultCallBack;
  final Function()? onResultChanged;
  final AiCycleClaimMeArgument argument;
  final Map<String, dynamic>? uiSettings;

  @override
  State<FolderDetailPage> createState() => _FolderDetailPageState();
}

class _FolderDetailPageState
    extends BaseState<FolderDetailPage, ClaimMeFolderDetailController> {
  late final StreamSubscription callEngineSub;
  late final StreamSubscription deleteImageSub;

  ///
  late final AICycleClaimMeSetting? settings;
  late final CarDirectionSetting? frontSetting;
  late final CarDirectionSetting? rightFrontSetting;
  late final CarDirectionSetting? leftFrontSetting;
  late final CarDirectionSetting? backSetting;
  late final CarDirectionSetting? rightBackSetting;
  late final CarDirectionSetting? leftBackSetting;

  ///
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
    xApplication = widget.argument.xApplication;

    environment = widget.argument.environtment ?? Evn.production;
    locale = widget.argument.locale;
    enableVersion2 = widget.argument.enableVersion2 ?? true;
    isAICycle = widget.argument.isAICycle ?? true;
    controller.argument = widget.argument;

    callEngineSub = controller.damageResponseStream.stream.listen((p0) {
      if (p0 != null) {
        widget.onResultChanged?.call();
      }
    });

    ///
    deleteImageSub = controller.deleteImageResponseStream.stream.listen((p0) {
      if (p0 == true) {
        widget.onResultChanged?.call();
      }
    });

    /// get settings
    if (widget.uiSettings != null) {
      try {
        settings = AICycleClaimMeSetting.fromJson(widget.uiSettings!);

        ///
        frontSetting = settings?.carDirections?.firstWhere((element) =>
            element.directionSlug == CarPartDirectionEnum.front.excelId);

        ///
        rightFrontSetting = settings?.carDirections?.firstWhere((element) =>
            element.directionSlug == CarPartDirectionEnum.rightFront.excelId);

        ///
        leftFrontSetting = settings?.carDirections?.firstWhere((element) =>
            element.directionSlug == CarPartDirectionEnum.leftFront.excelId);

        ///
        backSetting = settings?.carDirections?.firstWhere((element) =>
            element.directionSlug == CarPartDirectionEnum.back.excelId);

        ///
        rightBackSetting = settings?.carDirections?.firstWhere((element) =>
            element.directionSlug == CarPartDirectionEnum.rightBack.excelId);

        ///
        leftBackSetting = settings?.carDirections?.firstWhere((element) =>
            element.directionSlug == CarPartDirectionEnum.leftBack.excelId);
      } catch (e) {
        settings = null;
        frontSetting = null;
        rightFrontSetting = null;
        leftFrontSetting = null;
        backSetting = null;
        rightBackSetting = null;
        leftBackSetting = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    savePhotoAfterShot = widget.argument.savePhotoAfterShot;
    super.build(context);

    return Stack(
      children: [
        if (settings?.bgImage != null)
          Image.network(
            settings!.bgImage!,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        Scaffold(
          backgroundColor: settings?.bgImage != null
              ? Colors.transparent
              : ColorUtils.colorFromHex(settings?.bgColor ?? '#FFFFFF'),
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
                            child: settings?.customCarImage != null
                                ? Image.network(
                                    settings!.customCarImage!,
                                    height: 167,
                                    width: 113,
                                  )
                                : Assets.images.car.image(
                                    package: packageName,
                                    height: 167,
                                    width: 113,
                                  ),
                          ),
                          if (frontSetting != null)
                            Align(
                              alignment: Alignment.topCenter,
                              child: Obx(
                                () => CarPosition(
                                  direction: CarPartDirectionEnum.front,
                                  claimFolderId:
                                      widget.argument.aicycleClaimId ??
                                          widget.argument.externalClaimId,
                                  imageDirectionModel: controller.front.value,
                                  customDirectionName:
                                      frontSetting!.directionName,
                                  borderRadius:
                                      frontSetting!.borderRadius?.toDouble(),
                                  height: frontSetting!.height?.toDouble(),
                                  width: frontSetting!.width?.toDouble(),
                                ),
                              ),
                            ),
                          if (rightFrontSetting != null)
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 64),
                                child: Obx(
                                  () => CarPosition(
                                    direction: CarPartDirectionEnum.rightFront,
                                    claimFolderId:
                                        widget.argument.aicycleClaimId ??
                                            widget.argument.externalClaimId,
                                    imageDirectionModel:
                                        controller.rightFront.value,
                                    customDirectionName:
                                        rightFrontSetting!.directionName,
                                    borderRadius: rightFrontSetting!
                                        .borderRadius
                                        ?.toDouble(),
                                    height:
                                        rightFrontSetting!.height?.toDouble(),
                                    width: rightFrontSetting!.width?.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          if (leftFrontSetting != null)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(top: 64),
                                child: Obx(
                                  () => CarPosition(
                                    direction: CarPartDirectionEnum.leftFront,
                                    claimFolderId:
                                        widget.argument.aicycleClaimId ??
                                            widget.argument.externalClaimId,
                                    imageDirectionModel:
                                        controller.leftFront.value,
                                    customDirectionName:
                                        leftFrontSetting!.directionName,
                                    borderRadius: leftFrontSetting!.borderRadius
                                        ?.toDouble(),
                                    height:
                                        leftFrontSetting!.height?.toDouble(),
                                    width: leftFrontSetting!.width?.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          if (leftBackSetting != null)
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 64),
                                child: Obx(
                                  () => CarPosition(
                                    direction: CarPartDirectionEnum.leftBack,
                                    claimFolderId:
                                        widget.argument.aicycleClaimId ??
                                            widget.argument.externalClaimId,
                                    imageDirectionModel:
                                        controller.leftBack.value,
                                    customDirectionName:
                                        leftBackSetting!.directionName,
                                    borderRadius: leftBackSetting!.borderRadius
                                        ?.toDouble(),
                                    height: leftBackSetting!.height?.toDouble(),
                                    width: leftBackSetting!.width?.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          if (rightBackSetting != null)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 64),
                                child: Obx(
                                  () => CarPosition(
                                    direction: CarPartDirectionEnum.rightBack,
                                    claimFolderId:
                                        widget.argument.aicycleClaimId ??
                                            widget.argument.externalClaimId,
                                    imageDirectionModel:
                                        controller.rightBack.value,
                                    customDirectionName:
                                        rightBackSetting!.directionName,
                                    borderRadius: rightBackSetting!.borderRadius
                                        ?.toDouble(),
                                    height:
                                        rightBackSetting!.height?.toDouble(),
                                    width: rightBackSetting!.width?.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                          if (backSetting != null)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Obx(
                                () => CarPosition(
                                  direction: CarPartDirectionEnum.back,
                                  claimFolderId:
                                      widget.argument.aicycleClaimId ??
                                          widget.argument.externalClaimId,
                                  imageDirectionModel: controller.back.value,
                                  customDirectionName:
                                      backSetting!.directionName,
                                  borderRadius:
                                      backSetting!.borderRadius?.toDouble(),
                                  height: backSetting!.height?.toDouble(),
                                  width: backSetting!.width?.toDouble(),
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
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: MediaQuery.of(context).padding.bottom + 16,
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
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
