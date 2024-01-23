import 'package:camera/camera.dart';

import 'features/aicycle_claim_me/presentation/aicycle_claim_me.dart';
import 'injection_container.dart';
export 'features/aicycle_claim_me/presentation/aicycle_claim_me.dart'
    hide apiToken, locale, environtment, cameras;

class AICycle {
  static Future<void> initial({String? token}) async {
    apiToken = token;
    InjectionContainer.initial();
    cameras = await availableCameras();
  }
}
