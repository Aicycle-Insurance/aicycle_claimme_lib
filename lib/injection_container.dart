import 'package:get/get.dart';

import 'features/aicycle_claim_me/data/repository/aicycle_claim_me_repository_impl.dart';
import 'features/aicycle_claim_me/domain/usecase/create_folder_usecase.dart';
import 'features/aicycle_claim_me/domain/usecase/get_duplicate_folder_usecase.dart';
import 'features/aicycle_claim_me/domain/usecase/get_user_info_usecase.dart';
import 'features/camera/data/repository/camera_repository_impl.dart';
import 'features/camera/domain/usecase/call_engine_usecase.dart';
import 'features/camera/domain/usecase/upload_image_usecase.dart';
import 'features/direction_detail.dart/data/repository/direction_detail_repository_impl.dart';
import 'features/direction_detail.dart/domain/usecase/delete_all_image_usecase.dart';
import 'features/direction_detail.dart/domain/usecase/delete_image_by_id_usecase.dart';
import 'features/direction_detail.dart/domain/usecase/get_car_part_has_damage_usecase.dart';
import 'features/direction_detail.dart/domain/usecase/get_direction_image_usecase.dart';
import 'features/folder_detail/data/repository/folder_detail_repository_impl.dart';
import 'features/folder_detail/domain/usecase/get_image_direction_usecase.dart';
import 'features/folder_detail/domain/usecase/get_result_usecase.dart';

class InjectionContainer {
  InjectionContainer._();

  static initial() {
    _folder();
    _folderDetail();
    _camera();
  }

  static void _camera() {
    Get.lazyPut(
      () => ClaimMeCameraRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeUploadImageUsecase(Get.find<ClaimMeCameraRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeCallEngineUsecase(Get.find<ClaimMeCameraRepositoryImpl>()),
      fenix: true,
    );
  }

  static void _folderDetail() {
    Get.lazyPut(
      () => ClaimMeFolderDetailRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeDirectionDetailRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeGetImageDirectionUsecase(
          Get.find<ClaimMeFolderDetailRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeGetResultUsecase(
          Get.find<ClaimMeFolderDetailRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetDirectionImageDetailUsecase(
          Get.find<ClaimMeDirectionDetailRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeDeleteAllImageUsecase(
          Get.find<ClaimMeDirectionDetailRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeDeleteImageByIdUsecase(
          Get.find<ClaimMeDirectionDetailRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeGetCarPartHasDamageUsecase(
          Get.find<ClaimMeDirectionDetailRepositoryImpl>()),
      fenix: true,
    );
  }

  static void _folder() {
    Get.lazyPut(
      () => AicycleClaimMeRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () =>
          ClaimMeCreateFolderUsecase(Get.find<AicycleClaimMeRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ClaimMeGetDuplicateFolderUsecase(
          Get.find<AicycleClaimMeRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetUserInfoUsecase(Get.find<AicycleClaimMeRepositoryImpl>()),
      fenix: true,
    );
  }
}
