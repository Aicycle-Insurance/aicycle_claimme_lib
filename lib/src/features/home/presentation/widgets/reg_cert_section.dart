import 'package:flutter/material.dart';

import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/dashed_container.dart';

class RegCertSection extends StatelessWidget {
  const RegCertSection({super.key});

  Widget _buildRegCertContainer(AicycleCarAngle angle) {
    return DashedContainer(
      padding: EdgeInsets.all(16.h),
      borderRadius: 8.r,
      color: AppColors.surface,
      child: Column(
        spacing: 16.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
          // Text(angle.title, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.photoRegCert, style: AppTextStyles.bodyMedium),
        SizedBox(
          height: 132.h,
          width: double.infinity,
          child: Row(
            spacing: 16.h,
            children: [
              Expanded(
                child: _buildRegCertContainer(AicycleCarAngle.regCertFront),
              ),
              Expanded(
                child: _buildRegCertContainer(AicycleCarAngle.regCertBack),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
