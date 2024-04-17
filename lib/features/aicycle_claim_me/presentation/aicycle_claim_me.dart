import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../aicycle_claimme_lib.dart';
import '../../../common/base_widget.dart';
import '../../../common/themes/c_colors.dart';
import '../../../common/extension/translation_ext.dart';
import '../../../common/themes/c_textstyle.dart';
import '../../../enum/app_state.dart';
import '../../../generated/assets.gen.dart';
import '../../../generated/locales.g.dart';
import '../../folder_detail/presentation/folder_detail_page.dart';
import 'aicycle_claim_me_controller.dart';

enum Evn {
  dev,
  stage,
  production,
}

bool? enableVersion2 = true;
bool? isAICycle = true;
bool? savePhotoAfterShot = false;
String? apiToken;
String? xApplication;
Evn environment = Evn.production;
Locale? locale;
List<CameraDescription> cameras = <CameraDescription>[];

class AiCycleClaimMeArgument {
  final String externalClaimId;
  final String apiToken;
  final String? xApplication;
  final Evn? environtment;
  final bool? enableVersion2;
  final bool? savePhotoAfterShot;
  final Locale? locale;
  final String? aicycleClaimId;
  final bool? isAICycle;

  AiCycleClaimMeArgument({
    required this.externalClaimId,
    required this.apiToken,
    this.environtment,
    this.enableVersion2,
    this.savePhotoAfterShot,
    this.locale,
    this.aicycleClaimId,
    this.isAICycle,
    this.xApplication,
  });
}

class AiCycleClaimMe extends StatefulWidget {
  const AiCycleClaimMe({
    super.key,
    required this.argument,
    required this.onViewResultCallBack,
  });
  final AiCycleClaimMeArgument argument;
  final Function(dynamic result)? onViewResultCallBack;

  @override
  State<AiCycleClaimMe> createState() => _AiCycleClaimMeState();
}

class _AiCycleClaimMeState
    extends BaseState<AiCycleClaimMe, AiCycleClaimMeController> {
  @override
  AiCycleClaimMeController provideController() {
    if (Get.isRegistered<AiCycleClaimMeController>()) {
      return Get.find<AiCycleClaimMeController>();
    }
    return Get.put(AiCycleClaimMeController());
  }

  @override
  void initState() {
    super.initState();
    controller.argument = widget.argument;
    apiToken = widget.argument.apiToken;
    xApplication = widget.argument.xApplication;
    savePhotoAfterShot = widget.argument.savePhotoAfterShot;
    environment = widget.argument.environtment ?? Evn.production;
    enableVersion2 = widget.argument.enableVersion2 ?? true;
    locale = widget.argument.locale;
    isAICycle = widget.argument.isAICycle ?? true;

    controller.status.listen((state) {
      if (state.state == AppState.redirect) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => FolderDetailPage(
              argument: controller.argument,
              onViewResultCallBack: widget.onViewResultCallBack,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CColors.primaryA400,
              CColors.primaryA500,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.logo.image(
              package: packageName,
              width: 300,
            ),
            const Gap(24),
            Text(
              LocaleKeys.pleaseWait.trans,
              style: CTextStyles.base.s16.whiteColor,
            ),
            const Gap(12),
            SizedBox(
              width: 240,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(2),
                color: CColors.active,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
