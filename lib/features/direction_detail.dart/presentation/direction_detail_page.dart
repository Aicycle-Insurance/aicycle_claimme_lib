// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../common/extension/translation_ext.dart';
import '../../../common/base_widget.dart';
import '../../../common/c_loading_view.dart';
import '../../../common/dialog_service.dart';
import '../../../common/themes/c_textstyle.dart';
import '../../../enum/car_part_direction.dart';
import '../../../common/themes/c_colors.dart';
import '../../../generated/locales.g.dart';
import '../../camera/presentation/camera_page.dart';
import 'direction_detail_controller.dart';
import 'widgets/range_image_section.dart';

class DirectionDetailPage extends StatefulWidget {
  const DirectionDetailPage({
    super.key,
    required this.argument,
  });
  final ClaimMeCameraArgument argument;

  @override
  State<DirectionDetailPage> createState() => _DirectionDetailPageState();
}

class _DirectionDetailPageState
    extends BaseState<DirectionDetailPage, DirectionDetailController> {
  @override
  DirectionDetailController provideController() {
    if (Get.isRegistered<DirectionDetailController>()) {
      return Get.find<DirectionDetailController>();
    } else {
      return Get.put(DirectionDetailController());
    }
  }

  @override
  void initState() {
    super.initState();
    controller.argument = widget.argument;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.white,
        elevation: 0.7,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          widget.argument.carPartDirectionEnum.title,
          style: CTextStyles.base.ink500Color.s16.w500(),
        ),
        actions: [
          CupertinoButton(
            child: const Icon(
              Icons.delete_outline_rounded,
              color: CColors.redA500,
            ),
            onPressed: () async {
              bool result = false;
              await DialogService.showActionDialog(
                context,
                leftButtonText: LocaleKeys.cancel.trans,
                rightButtonText: LocaleKeys.delete.trans,
                rightButtonTextStyle: CTextStyles.baseWhite.s14,
                description: LocaleKeys.deleteAllImageConfirm.trans,
                descriptionTextStyle: CTextStyles.base.s14,
                leftButtonTextStyle: CTextStyles.base.s14.primaryColor,
                onPressedLeftButton: () => result = false,
                onPressedRightButton: () => result = true,
              );
              if (result == true) {
                await controller.onDeleteAllImage();
              }
            },
          ),
        ],
      ),
      body: LoadingView<DirectionDetailController>(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => RangeImageSection(
                  rangeId: 1,
                  images: controller.longShotImages.value,
                  isLoading: controller.longLoading.value,
                  onDeleteImage: controller.onDeleteImage,
                  deletingList: controller.deletingList.value,
                  onTakePhoto: (oldImageId) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CameraPage(
                          argument: ClaimMeCameraArgument(
                            carPartDirectionEnum:
                                widget.argument.carPartDirectionEnum,
                            carModelEnum: widget.argument.carModelEnum,
                            claimId: widget.argument.claimId,
                            closeUpShotImages: controller.closeUpShotImages,
                            longShotImages: controller.longShotImages,
                            middleShotImages: controller.middleShotImages,
                            initPositionIndex: 0,
                            oldImageId: oldImageId,
                            carPartHasDamage: controller.carPartsForCloseUpShot,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
              Obx(
                () => RangeImageSection(
                  rangeId: 2,
                  images: controller.middleShotImages.value,
                  isLoading: controller.middleLoading.value,
                  onDeleteImage: controller.onDeleteImage,
                  deletingList: controller.deletingList.value,
                  onTakePhoto: (oldImageId) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CameraPage(
                          argument: ClaimMeCameraArgument(
                            carPartDirectionEnum:
                                widget.argument.carPartDirectionEnum,
                            carModelEnum: widget.argument.carModelEnum,
                            claimId: widget.argument.claimId,
                            closeUpShotImages: controller.closeUpShotImages,
                            longShotImages: controller.longShotImages,
                            middleShotImages: controller.middleShotImages,
                            initPositionIndex: 1,
                            oldImageId: oldImageId,
                            carPartHasDamage: controller.carPartsForCloseUpShot,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
              Obx(
                () => RangeImageSection(
                  rangeId: 3,
                  images: controller.closeUpShotImages.value,
                  isLoading: controller.closeUpLoading.value,
                  onDeleteImage: controller.onDeleteImage,
                  deletingList: controller.deletingList.value,
                  onTakePhoto: (oldImageId) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CameraPage(
                          argument: ClaimMeCameraArgument(
                            carPartDirectionEnum:
                                widget.argument.carPartDirectionEnum,
                            carModelEnum: widget.argument.carModelEnum,
                            claimId: widget.argument.claimId,
                            closeUpShotImages: controller.closeUpShotImages,
                            longShotImages: controller.longShotImages,
                            middleShotImages: controller.middleShotImages,
                            initPositionIndex: 2,
                            oldImageId: oldImageId,
                            carPartHasDamage: controller.carPartsForCloseUpShot,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
