import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../../enum/app_state.dart';
import '../data/model/claim_folder_model.dart';
import '../domain/usecase/create_folder_usecase.dart';
import '../domain/usecase/get_duplicate_folder_usecase.dart';
import 'aicycle_claim_me.dart';

class AiCycleClaimMeController extends ClaimMeBaseController {
  final ClaimMeCreateFolderUsecase createFolderUsecase = Get.find();
  final ClaimMeGetDuplicateFolderUsecase getDuplicateFolderUsecase = Get.find();
  late AiCycleClaimMeArgument argument;
  var claimFolder = Rx<ClaimFolderModel?>(null);

  @override
  void onReady() {
    super.onReady();
    createFolder();
  }

  void createFolder() async {
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
}
