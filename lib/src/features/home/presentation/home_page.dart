import 'package:aicycle_claimme_plus/src/core/theme/app_colors.dart';
import 'package:aicycle_claimme_plus/src/core/utils/screen_utils.dart';
import 'package:aicycle_claimme_plus/src/features/home/presentation/widgets/reg_cert_section.dart';
import 'package:flutter/material.dart';

import '../../../config/aicycle_config.dart';
import '../../../core/di/injection.dart';
import '../../../core/parse_output.dart';
import '../../../core/theme/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import 'controller/home_controller.dart';
import 'widgets/exterior_section.dart';
import 'widgets/ocr_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.controller,
    required this.config,
    this.onComplete,
  });

  final HomeController controller;
  final AiCycleConfig config;
  final Function(dynamic data)? onComplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: RefreshIndicator(
        onRefresh: sl.vehicleImageVault.loadAllDirectionalImages,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.h),
          child: ListenableBuilder(
            listenable: sl.vehicleImageVault,
            builder: (context, _) {
              final images = sl.vehicleImageVault.getImagesForAngle(
                AicycleCarAngle.regCert,
              );
              return Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegCertSection(images: images),
                  if (images.isNotEmpty)
                    ListenableBuilder(
                      listenable: controller,
                      builder: (context, _) {
                        return OCRSection(
                          ocrInfo: controller.ocrInfo,
                          isFetching: controller.isFetchingOCR,
                        );
                      },
                    ),
                  ExteriorSection(),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: Listenable.merge([controller, sl.vehicleImageVault]),
        builder: (context, _) {
          final bool hasImages = sl.vehicleImageVault.hasAnyImage;
          final bool isLoading = controller.isGettingDamageStatistics;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: (hasImages && !isLoading)
                    ? () async {
                        await controller.getDamageStatistics();
                        final data = ParseOutput.parseDamageStatistics(
                          controller.damageStatistics,
                        );
                        onComplete?.call(data);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(AppStrings.btnViewResult, style: AppTextStyles.button),
              ),
            ),
          );
        },
      ),
    );
  }
}
