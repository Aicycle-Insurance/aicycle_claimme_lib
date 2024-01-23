import 'package:flutter/widgets.dart';

import '../../../aicycle.dart';

class FolderDetailPage extends StatelessWidget {
  const FolderDetailPage({
    super.key,
    this.hasAppBar,
    required this.argument,
  });

  final bool? hasAppBar;
  // final Function(List<BuyMeImage>? images)? onViewResultCallBack;
  // final Function(DamageAssessmentResponse?)? onCallEngineSuccessfully;
  final AiCycleClaimMeArgument argument;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
