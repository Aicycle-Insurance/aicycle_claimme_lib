import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/aicycle_config.dart';
import 'core/theme/app_colors.dart';
import 'core/utils/screen_utils.dart';
import 'features/home/presentation/controller/home_controller.dart';
import 'features/home/presentation/home_page.dart';

/// The main entry point for the SDK as a Widget.
///
/// This widget handles SDK initialization and shows a loading state.
/// Once initialized, it navigates to the main flow or calls [onSuccess].
class AicycleClaimMe extends StatefulWidget {
  const AicycleClaimMe({
    super.key,
    required this.aiCycleConfig,
    this.onError,
    this.onComplete,
  });

  /// Cấu hình SDK
  final AiCycleConfig aiCycleConfig;

  /// Callback when initialization fails
  final Function(String error)? onError;

  /// Callback when initialization succeeds.
  /// If provided, the widget will not automatically navigate to the default flow.
  final Function(dynamic data)? onComplete;

  static AiCycleConfig? configInternal;

  /// Get the current configuration. Throws if not initialized.
  static AiCycleConfig get config {
    if (configInternal == null) {
      throw StateError(
        'AiCycleClaimMe has not been initialized. Ensure AiCycleClaimMe widget is in the tree.',
      );
    }
    return configInternal!;
  }

  @override
  State<AicycleClaimMe> createState() => _AicycleClaimMeState();
}

class _AicycleClaimMeState extends State<AicycleClaimMe> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait when using the package
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller = HomeController();
    _controller.init(widget.aiCycleConfig);
  }

  @override
  void dispose() {
    // Restore orientation when the widget is disposed
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.status == ClaimMeStatus.loading ||
              _controller.status == ClaimMeStatus.initial) {
            return widget.aiCycleConfig.displayConfig.loadingWidget ??
                const Center(child: CircularProgressIndicator());
          }

          if (_controller.status == ClaimMeStatus.success) {
            return HomePage(
              controller: _controller,
              config: widget.aiCycleConfig,
              onComplete: widget.onComplete,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
