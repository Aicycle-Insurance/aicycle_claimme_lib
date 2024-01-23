import 'package:get/get.dart';

import 'features/aicycle_claim_me/data/repository/aicycle_claim_me_repository_impl.dart';
import 'features/aicycle_claim_me/domain/usecase/create_folder_usecase.dart';
import 'features/aicycle_claim_me/domain/usecase/get_duplicate_folder_usecase.dart';

class InjectionContainer {
  InjectionContainer._();

  static initial() {
    _folder();
  }

  static void _folder() {
    Get.lazyPut(
      () => AicycleClaimMeRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () => CreateFolderUsecase(Get.find<AicycleClaimMeRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetDuplicateFolderUsecase(Get.find<AicycleClaimMeRepositoryImpl>()),
      fenix: true,
    );
  }
}
