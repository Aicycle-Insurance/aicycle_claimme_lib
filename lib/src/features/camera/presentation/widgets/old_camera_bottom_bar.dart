import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_utils.dart';
import '../controllers/old_camera_controller.dart';

class OldCameraBottomBar extends StatelessWidget {
  const OldCameraBottomBar({
    super.key,
    required this.controller,
    required this.orientation,
    required this.turns,
  });

  final OldXCameraController controller;
  final NativeDeviceOrientation orientation;
  final double turns;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => controller.pickImageFromGallery(),
            child: Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGray, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.photo_library_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.takePicture(orientation),
            child: Container(
              width: 58.r,
              height: 58.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 300),
                child: Icon(Icons.camera_alt, color: Colors.black, size: 24.r),
              ),
            ),
          ),

          InkWell(
            onTap: () {},
            child: AnimatedRotation(
              turns: turns,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.borderGray, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: ListenableBuilder(
                    listenable: sl.vehicleImageVault,
                    builder: (context, _) {
                      final images = sl.vehicleImageVault.exteriorImages;
                      return Stack(
                        children: [
                          if (images.isNotEmpty) ...[
                            CachedNetworkImage(
                              imageUrl: images.last.imageUrl ?? '',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ] else ...[
                            Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                                size: 24.r,
                              ),
                            ),
                          ],
                          Center(
                            child: Container(
                              width: 24.r,
                              height: 24.r,
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  images.length.toString(),
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
