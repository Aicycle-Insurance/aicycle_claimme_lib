import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../aicycle_claimme_plus_impl.dart';
import '../../../../config/aicycle_config.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/extension/car_angle_ext.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_utils.dart';

class ExteriorSection extends StatelessWidget {
  const ExteriorSection({super.key});

  static const _supportedAngles = [
    AicycleCarAngle.front,
    AicycleCarAngle.frontLeft,
    AicycleCarAngle.frontRight,
    AicycleCarAngle.rear,
    AicycleCarAngle.rearLeft,
    AicycleCarAngle.rearRight,
  ];

  static double getLeftPosition(AicycleCarAngle angle, BuildContext context) {
    switch (angle) {
      case AicycleCarAngle.front:
      case AicycleCarAngle.rear:
        return (MediaQuery.of(context).size.width - 64.h - 64.h) /
            2; // Center (width - padding - button_width) / 2
      case AicycleCarAngle.frontLeft:
      case AicycleCarAngle.rearLeft:
        return 0;
      case AicycleCarAngle.frontRight:
      case AicycleCarAngle.rearRight:
        return MediaQuery.of(context).size.width - 64.h - 64.h;
      default:
        return 0;
    }
  }

  static double getTopPosition(AicycleCarAngle corner, BuildContext context) {
    switch (corner) {
      case AicycleCarAngle.front:
        return 0;
      case AicycleCarAngle.frontLeft:
      case AicycleCarAngle.frontRight:
        return 64;
      case AicycleCarAngle.rear:
        return 400.h - 92.h;
      case AicycleCarAngle.rearLeft:
      case AicycleCarAngle.rearRight:
        return 400.h - 92.h - 92.h;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = AicycleClaimMe.config;
    final carAnglesWithDisplayName = config
        .displayConfig
        .carAnglesWithDisplayName
        .keys
        .toList();
    final angles = carAnglesWithDisplayName
        .where((angle) => _supportedAngles.contains(angle))
        .toList();
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.photo} ${AicycleCarAngle.exterior.title.toLowerCase()}',
          style: AppTextStyles.bodyMedium,
        ),
        SizedBox(
          height: 400.h,
          width: double.maxFinite,
          child: Stack(
            children: [
              Center(
                child: Assets.images.imgCar.image(
                  package: AppStrings.package,
                  width: 120.w,
                ),
              ),
              ...angles.map((angle) {
                switch (angle) {
                  case AicycleCarAngle.front:
                    return Align(
                      alignment: Alignment.topCenter,
                      child: CornerButton(angle: angle),
                    );
                  case AicycleCarAngle.frontLeft:
                    return Positioned(
                      left: 16.w,
                      top: 92.h,
                      child: CornerButton(angle: angle),
                    );
                  case AicycleCarAngle.frontRight:
                    return Positioned(
                      right: 16.w,
                      top: 92.h,
                      child: CornerButton(angle: angle),
                    );
                  case AicycleCarAngle.rear:
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: CornerButton(angle: angle),
                    );
                  case AicycleCarAngle.rearLeft:
                    return Positioned(
                      left: 16.w,
                      bottom: 92.h,
                      child: CornerButton(angle: angle),
                    );
                  case AicycleCarAngle.rearRight:
                    return Positioned(
                      right: 16.w,
                      bottom: 92.h,
                      child: CornerButton(angle: angle),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class CornerButton extends StatelessWidget {
  const CornerButton({super.key, required this.angle});
  final AicycleCarAngle angle;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: sl.vehicleImageVault,
      builder: (context, child) {
        final images = sl.vehicleImageVault.getImagesForAngle(angle);
        final hasImage = images.isNotEmpty;
        return InkWell(
          onTap: hasImage
              ? null
              : () {
                  // TODO: go to camera screen
                },
          child: SizedBox(
            height: 92.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 64.h,
                  width: 64.h,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                        color: const Color(0xFF666985).withValues(alpha: 0.2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: hasImage
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: images.first.imageUrl ?? '',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// Images count
                                  InkWell(
                                    onTap: () {
                                      // TODO: go to camera screen
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons
                                                .photo_size_select_actual_rounded,
                                            color: Colors.white,
                                            size: 12.h,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${images.length}',
                                            style: AppTextStyles.body12Medium
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),

                                  /// Take more images button
                                  InkWell(
                                    onTap: () {
                                      // TODO: go to camera screen
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add_rounded,
                                            color: AppColors.primary,
                                            size: 12.h,
                                          ),
                                          SizedBox(width: 2.w),
                                          Icon(
                                            Icons.camera_alt_rounded,
                                            color: AppColors.primary,
                                            size: 12.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.primary,
                              size: 32.h,
                            ),
                          ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(angle.title, style: AppTextStyles.body12Regular),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
