import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/extension/car_angle_ext.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../../../core/widgets/dashed_container.dart';
import '../../../camera/presentation/pages/camera_page.dart';
import '../../../images_list/presentation/image_list_page.dart';
import '../../domain/entities/directional_image.dart';

class RegCertSection extends StatelessWidget {
  const RegCertSection({super.key, this.images = const []});
  final List<DirectionalImage> images;

  void _gotoCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(
          args: CameraArgs(
            vehicleAngle: AicycleCarAngle.regCert,
            isFramedPhoto: false,
          ),
        ),
      ),
    );
  }

  void _gotoImageList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ImageListPage(vehicleAngle: AicycleCarAngle.regCert),
      ),
    );
  }

  Widget _buildRegCertContainer(BuildContext context, {int index = 0}) {
    final hasImage = images.length > index && images[index].imageUrl != null;
    return InkWell(
      onTap: () {
        if (index == 0 && images.length > 1) {
          return;
        }
        if (images.isEmpty) {
          _gotoCamera(context);
        } else {
          _gotoImageList(context);
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
                  if (index == 1 && images.length > 2)
                    Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.black54,
                      child: Center(
                        child: Text(
                          '+${images.length - 2}',
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
              Expanded(child: _buildRegCertContainer(context, index: 0)),
              Expanded(child: _buildRegCertContainer(context, index: 1)),
            ],
          ),
        ),
      ],
    );
  }
}
