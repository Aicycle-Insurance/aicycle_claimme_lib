import 'package:aicycle_claimme_plus/gen/assets.gen.dart';
import 'package:aicycle_claimme_plus/src/core/utils/screen_utils.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';

class OCRSection extends StatelessWidget {
  const OCRSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 2.r,
          color: AppColors.borderPurple.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(0, 0),
            color: AppColors.shadowPurple.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Assets.images.icStarts.image(
                      width: 14.w,
                      height: 14.w,
                      package: AppStrings.package,
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.borderPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Text(
                        AppStrings.aiAnalyze.toUpperCase(),
                        style: AppTextStyles.body12Medium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 48.h,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4.h,
                        children: [
                          Text(
                            AppStrings.carBrand.toUpperCase(),
                            style: AppTextStyles.body12Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'Vinfast VF8',
                            style: AppTextStyles.body12Medium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: AppColors.border,
                        thickness: 1,
                        width: 32.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4.h,
                          children: [
                            Text(
                              '${AppStrings.carModel.toUpperCase()} - ${AppStrings.carVersion.toUpperCase()}',
                              style: AppTextStyles.body12Medium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              'Vinfast VF8',
                              style: AppTextStyles.body12Medium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.border, thickness: 1, height: 1),
          InkWell(
            onTap: () {
              // TODO: show orc result
            },
            child: SizedBox(
              height: 52.h,
              width: double.maxFinite,
              child: Center(
                child: Text(
                  AppStrings.viewDetailOCR,
                  style: AppTextStyles.body12Light.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
