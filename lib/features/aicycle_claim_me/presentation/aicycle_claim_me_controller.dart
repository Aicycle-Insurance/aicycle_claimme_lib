import 'package:aicycle_claimme_lib/features/aicycle_claim_me/data/model/setting_model.dart';
import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../../enum/app_state.dart';
import '../data/model/claim_folder_model.dart';
import '../data/model/user_info_model.dart';
import '../domain/usecase/create_folder_usecase.dart';
import '../domain/usecase/get_duplicate_folder_usecase.dart';
import '../domain/usecase/get_user_info_usecase.dart';
import 'aicycle_claim_me.dart';

class AiCycleClaimMeController extends ClaimMeBaseController {
  final ClaimMeCreateFolderUsecase createFolderUsecase = Get.find();
  final ClaimMeGetDuplicateFolderUsecase getDuplicateFolderUsecase = Get.find();
  final GetUserInfoUsecase getUserInfoUsecase = Get.find();

  late AiCycleClaimMeArgument argument;
  late AICycleClaimMeSetting? uiSettings;
  var claimFolder = Rx<ClaimFolderModel?>(null);

  static const organizations = {
    61: "Bảo Long",
    68: "Fuse",
    16: "VIC",
    6: "CMC",
    8: "DoVenture",
    12: "Nextrans",
    7: "MIC",
    62: "AAA",
    182: "VNI",
    65: "Cathay",
    230: "MK Vision",
    238: "AICycleTrial",
    2: "VBI",
    3: "AICycle",
    14: "PJICO",
    113: "Xuân Thành",
    1: "PTI",
    9: "Anonymous",
    21: "SETA",
    5: "OPES",
    15: "PVI",
    4: "ESCS",
  };

  @override
  void onReady() async {
    super.onReady();
    await getUserInfo();
    await createFolder();
  }

  Future createFolder() async {
    isLoading(true);
    final res = await createFolderUsecase(
      externalClaimId: argument.externalClaimId,
      folderName: argument.externalClaimId,
      appUser: null,
      carColor: null,
      hasLicensePlate: true,
      parentId: null,
      vehicleBrandId: '5',
      vehicleLicensePlates: '',
    );

    res.fold(
      (l) {
        if (l.details.toString().toLowerCase().contains('duplicate')) {
          getDuplicateFolder();
        } else {
          isLoading(false);
          status.value = BaseStatus(
            message: '${l.code.toString()}: ${l.details.toString()}',
            state: AppState.pop,
          );
        }
      },
      (r) {
        argument = AiCycleClaimMeArgument(
          externalClaimId: argument.externalClaimId,
          apiToken: argument.apiToken,
          aicycleClaimId: r.claimId,
          environtment: argument.environtment,
          locale: argument.locale,
        );
        isLoading(false);
        status.value = BaseStatus(
          message: null,
          state: AppState.redirect,
        );
        // claimFolder.value = r;
      },
    );
  }

  void getDuplicateFolder() async {
    var res = await getDuplicateFolderUsecase(
        externalClaimId: argument.externalClaimId);
    res.fold(
      (l) {
        isLoading(false);
        status.value = BaseStatus(
          message: '${l.code.toString()}: ${l.details.toString()}',
          state: AppState.pop,
        );
      },
      (r) {
        argument = AiCycleClaimMeArgument(
          externalClaimId: argument.externalClaimId,
          apiToken: argument.apiToken,
          aicycleClaimId: r.claimId,
          environtment: argument.environtment,
          locale: argument.locale,
        );
        isLoading(false);
        status.value = BaseStatus(
          message: null,
          state: AppState.redirect,
        );
        claimFolder.value = r;
      },
    );
  }

  Future getUserInfo() async {
    isLoading(true);
    processUsecaseResult<UserInfo>(
      result: await getUserInfoUsecase(),
      onSuccess: (p0) {
        if (p0.data?.organizations != null &&
            p0.data!.organizations!.isNotEmpty) {
          uiSettings = p0.data!.organizations!.first.kvp?.sdk;
        }
      },
    );
  }
}
