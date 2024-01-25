import 'package:get/get.dart';

import 'features/aicycle_claim_me/data/repository/aicycle_claim_me_repository_impl.dart';
import 'features/aicycle_claim_me/domain/usecase/create_folder_usecase.dart';
import 'features/aicycle_claim_me/domain/usecase/get_duplicate_folder_usecase.dart';
import 'features/camera/data/repository/camera_repository_impl.dart';
import 'features/camera/domain/usecase/call_engine_usecase.dart';
import 'features/camera/domain/usecase/upload_image_usecase.dart';
import 'features/folder_detail/data/repository/folder_detail_repository_impl.dart';
import 'features/folder_detail/domain/usecase/get_image_direction_usecase.dart';

class InjectionContainer {
  InjectionContainer._();

  static initial() {
    _folder();
    _folderDetail();
    _camera();
  }

  static void _camera() {
    Get.lazyPut(
      () => CameraRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () => UploadImageUsecase(Get.find<CameraRepositoryImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => CallEngineUsecase(Get.find<CameraRepositoryImpl>()),
      fenix: true,
    );
  }

  static void _folderDetail() {
    Get.lazyPut(
      () => FolderDetailRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetImageDirectionUsecase(Get.find<FolderDetailRepositoryImpl>()),
      fenix: true,
    );
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
