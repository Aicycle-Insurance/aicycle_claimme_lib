import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_utils.dart';
import '../../domain/entities/car_part_has_damage.dart';
import '../controllers/old_camera_controller.dart';

class OldCameraPartSelector extends StatelessWidget {
  const OldCameraPartSelector({
    super.key,
    required this.controller,
    required this.showSelector,
    required this.onToggle,
    required this.onPartSelected,
  });

  final OldXCameraController controller;
  final bool showSelector;
  final VoidCallback onToggle;
  final Function(CarPartHasDamage) onPartSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${controller.selectedPart?.vehiclePartName ?? ''} (${controller.selectedPart?.totalCloseImages ?? 0})',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                ),
                SizedBox(width: 8.w),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showSelector)
          Container(
            margin: EdgeInsets.only(top: 4.h),
            width: 250.w,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300.h),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.carPartHasDamages.length,
                itemBuilder: (context, index) {
                  final part = controller.carPartHasDamages[index];
                  final isSelected = controller.selectedPart == part;
                  return InkWell(
                    onTap: () => onPartSelected(part),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        border: index != controller.carPartHasDamages.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${part.vehiclePartName ?? ''} (${part.totalCloseImages ?? 0})',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected ? Colors.blue : Colors.white,
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                              size: 16,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
