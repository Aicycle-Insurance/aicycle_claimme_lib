import 'package:aicycle_claimme_plus/src/core/theme/app_colors.dart';
import 'package:aicycle_claimme_plus/src/core/theme/app_strings.dart';
import 'package:aicycle_claimme_plus/src/core/theme/app_text_styles.dart';
import 'package:aicycle_claimme_plus/src/core/utils/screen_utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/ocr_info.dart';

class OcrDetail extends StatelessWidget {
  const OcrDetail({super.key, required this.ocrInfo});
  final OCRInfo ocrInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundGray,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          SizedBox(height: 16.h),
          Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: _buildSummaryBox(
                  AppStrings.licensePlateOcr,
                  ocrInfo.licensePlate ?? '',
                ),
              ),
              Expanded(
                child: _buildSummaryBox(
                  AppStrings.manufacturedYearOcr,
                  ocrInfo.manufacturedYear ?? '',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                spacing: 8.h,
                children: [
                  _buildDetailRow(
                    Icons.badge_outlined,
                    AppStrings.serialNumberOcr,
                    ocrInfo.serialNumber ?? '',
                  ),
                  _buildDetailRow(
                    Icons.directions_car_outlined,
                    AppStrings.vehicleTypeOcr,
                    ocrInfo.vehicleType ?? '',
                  ),
                  _buildDetailRow(
                    Icons.branding_watermark_outlined,
                    AppStrings.vehicleMarkOcr,
                    ocrInfo.vehicleMark ?? '',
                  ),
                  _buildDetailRow(
                    Icons.category_outlined,
                    AppStrings.modelCodeOcr,
                    ocrInfo.modelCode ?? '',
                  ),
                  _buildDetailRow(
                    Icons.settings_input_component_outlined,
                    AppStrings.engineNumberOcr,
                    ocrInfo.engineNumber ?? '',
                  ),
                  _buildDetailRow(
                    Icons.crop_square_outlined,
                    AppStrings.chassisNumberOcr,
                    ocrInfo.chassisNumber ?? '',
                  ),
                  _buildDetailRow(
                    Icons.public,
                    AppStrings.countryOcr,
                    ocrInfo.country ?? '',
                  ),
                  _buildDetailRow(
                    Icons.grid_4x4_outlined,
                    AppStrings.wheelFormulaOcr,
                    ocrInfo.wheelFormula ?? '',
                  ),
                  _buildDetailRow(
                    Icons.water_drop_outlined,
                    AppStrings.fuelTypeOcr,
                    ocrInfo.typeOfFuel ?? '',
                  ),
                  _buildDetailRow(
                    Icons.speed,
                    AppStrings.engineDisplacementOcr,
                    ocrInfo.engineDisplacement ?? '',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          _buildConfirmButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: AppColors.backgroundPurple,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.qr_code_scanner,
            color: AppColors.primary,
            size: 24.r,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            AppStrings.ocrResultTitle,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSummaryBox(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundPurple,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.borderPurple.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.body12Medium.copyWith(
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.r, color: AppColors.iconGray),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySemibold.copyWith(
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, ocrInfo);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.confirmInfo,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.check_circle_outline, color: Colors.white, size: 20.r),
          ],
        ),
      ),
    );
  }
}
