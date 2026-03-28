import 'package:flutter/material.dart';

import '../aicycle_claimme_plus.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
