import 'package:aicycle_claimme_plus/src/core/theme/app_colors.dart';
import 'package:aicycle_claimme_plus/src/core/theme/app_strings.dart';
import 'package:aicycle_claimme_plus/src/core/theme/app_text_styles.dart';
import 'package:aicycle_claimme_plus/src/core/utils/screen_utils.dart';
import 'package:aicycle_claimme_plus/src/core/widgets/dashed_container.dart';
import 'package:aicycle_claimme_plus/src/features/home/presentation/widgets/reg_cert_section.dart';
import 'package:flutter/material.dart';

import '../../../config/aicycle_config.dart';
import 'controller/home_controller.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [RegCertSection()],
        ),
      ),
    );
  }
}
