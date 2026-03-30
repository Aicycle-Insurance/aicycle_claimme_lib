import 'package:aicycle_claimme_plus/aicycle_claimme_plus.dart';
import 'package:aicycle_claimme_plus/src/features/home/domain/entities/directional_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/car_angle_ext.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/dashed_container.dart';

class RegCertSection extends StatelessWidget {
  const RegCertSection({super.key, this.images = const []});
  final List<DirectionalImage> images;

  Widget _buildRegCertContainer({int index = 0}) {
    final hasImage = images.length > index && images[index].imageUrl != null;
    return InkWell(
      onTap: () {
        if (index == 0 && images.length > 1) {
          return;
        }
        if (images.isEmpty) {
          // TODO: go to camera screen
        } else {
          // TODO: go to edit image screen
        }
      },
      child: DashedContainer(
        padding: EdgeInsets.all(16.h),
        borderRadius: 8.r,
        color: AppColors.borderGray,
        strokeWidth: 2.r,
        dashPattern: const [6, 4],
        backgroundColor: AppColors.surface,
        height: double.maxFinite,
        child: hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: images[index].imageUrl!,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                  if (index == 1 && images.length > 1)
                    Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.black54,
                      child: Center(
                        child: Text(
                          '+${images.length}',
                          style: AppTextStyles.body12Medium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : Center(
                child: Container(
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundPurple,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColors.primary,
                    size: 20.h,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.photo} ${AicycleCarAngle.regCert.title.toLowerCase()}',
          style: AppTextStyles.bodyMedium,
        ),
        SizedBox(
          height: 132.h,
          width: double.maxFinite,
          child: Row(
            spacing: 16.h,
            children: [
              Expanded(child: _buildRegCertContainer(index: 0)),
              Expanded(child: _buildRegCertContainer(index: 1)),
            ],
          ),
        ),
      ],
    );
  }
}
