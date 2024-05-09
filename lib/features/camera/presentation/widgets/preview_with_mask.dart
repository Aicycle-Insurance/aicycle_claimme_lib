// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common/cache_image_widget.dart';
import '../../../../common/color_utils.dart';
import '../../../../common/contants/damge_type_constant.dart';
import '../../../../common/themes/c_colors.dart';
import '../../data/models/damage_assessment_response.dart';
import '../../../../common/extension/translation_ext.dart';
import '../../../../generated/locales.g.dart';

class PreviewWithMask extends StatelessWidget {
  const PreviewWithMask({
    super.key,
    required this.file,
    this.damageAssessmentModel,
    required this.onYesTapped,
    required this.onNoTapped,
    this.retake,
    this.maskSplitted = false,
  });

  final XFile file;
  final DamageAssessmentModel? damageAssessmentModel;
  final Function() onYesTapped;
  final Function() onNoTapped;
  final Function()? retake;
  final bool? maskSplitted;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var masks = <Widget>[];
    var cachedDamageType = <String>[];
    // var listInitDamageModel = <DamageModel>[];

    if (damageAssessmentModel != null &&
        damageAssessmentModel!.carDamages != null) {
      var imWidth = damageAssessmentModel!.imgSize?[0]?.toDouble() ?? 1920.0;
      var imHeight = damageAssessmentModel!.imgSize?[1]?.toDouble() ?? 1080.0;
      for (var mask in damageAssessmentModel!.carDamages!) {
        if (!cachedDamageType.contains(mask.maskPath)) {
          cachedDamageType.add(mask.maskPath ?? '0');
          var currentDamageType = damageTypes.firstWhereOrNull((element) =>
              element.damageTypeGuid == mask.classUuid ||
              element.damageTypeSlugId == mask.damageKey);
          var color =
              ColorUtils.colorFromHex(currentDamageType?.damageTypeColor)
                  .withOpacity(0.3);
          var box = mask.box ?? [0, 0, 1, 1];

          masks.add(
            Positioned(
              left: (box[0]?.toDouble() ?? 0) * imWidth,
              top: (box[1]?.toDouble() ?? 0) * imHeight,
              child: SizedBox(
                height: ((box[1]?.toDouble() ?? 0) - (box[3]?.toDouble() ?? 0))
                        .abs() *
                    imHeight,
                width: ((box[0]?.toDouble() ?? 0) - (box[2]?.toDouble() ?? 0))
                        .abs() *
                    imWidth,
                child: CachedImageWidget(
                  url: mask.maskUrl ?? '',
                  fit: BoxFit.fill,
                  color: color,
                ),
              ),
            ),
          );
        }
      }
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: screenWidth,
          color: Colors.black,
          child: InteractiveViewer(
            maxScale: 3,
            minScale: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Stack(
                children: [
                  Image.file(
                    File(file.path),
                    fit: BoxFit.contain,
                  ),
                  ...masks,
                ],
              ),
            ),
          ),
        ),
        if (damageAssessmentModel != null) _missingDamageConfirmation(),
        if (retake != null) _retake(context),
      ],
    );
  }

  Widget _retake(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 16,
            right: 16 + MediaQuery.of(context).padding.bottom,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: retake,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                LocaleKeys.retake.trans,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _missingDamageConfirmation() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   'missingDamage'.tr(),
                //   style: const TextStyle(color: Colors.white),
                // ),
                // SizedBox(width: 8.h),
                // CupertinoButton(
                //   padding: EdgeInsets.zero,
                //   minSize: 0,
                //   onPressed: onNoTapped,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 16.h,
                //       vertical: 6.w,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(4.r),
                //       border: Border.all(color: Colors.white),
                //     ),
                //     child: Text(
                //       'no'.tr(),
                //       style: const TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 8.h),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: onNoTapped,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.next.trans,
                          style: const TextStyle(
                            color: CColors.primaryA500,
                          ),
                        ),
                        const Gap(8),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: CColors.primaryA500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
