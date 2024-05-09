import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../camera/data/models/car_part_has_damage_model.dart';
import '../../camera/presentation/camera_page.dart';
import '../../folder_detail/presentation/folder_detail_controller.dart';
import '../data/models/claim_image_model.dart';
import '../domain/usecase/delete_all_image_usecase.dart';
import '../domain/usecase/delete_image_by_id_usecase.dart';
import '../domain/usecase/get_car_part_has_damage_usecase.dart';
import '../domain/usecase/get_direction_image_usecase.dart';

class ClaimMeDirectionDetailController extends ClaimMeBaseController {
  late final ClaimMeCameraArgument? argument;
  final GetDirectionImageDetailUsecase getDirectionImageDetailUsecase =
      Get.find();
  final ClaimMeDeleteAllImageUsecase deleteAllImageUsecase = Get.find();
  final ClaimMeDeleteImageByIdUsecase deleteImageByIdUsecase = Get.find();
  final ClaimMeGetCarPartHasDamageUsecase getCarPartHasDamageUsecase =
      Get.find();

  var longShotImages = <ClaimImageModel>[].obs;
  var middleShotImages = <ClaimImageModel>[].obs;
  var closeUpShotImages = <ClaimImageModel>[].obs;

  var longLoading = false.obs;
  var middleLoading = false.obs;
  var closeUpLoading = false.obs;

  var deletingList = <String>[].obs;
  List<CarPartHasDamageModel> carPartsForCloseUpShot = [];

  @override
  void onReady() async {
    super.onReady();
    await getCarPartsForCloseUpShot();
    getDirectionImage(1);
    getDirectionImage(2);
    getDirectionImage(3);
  }

  Future<void> getCarPartsForCloseUpShot() async {
    if (argument?.claimId == null) {
      return;
    }
    isLoading(true);
    processUsecaseResult(
      result: await getCarPartHasDamageUsecase(
        claimId: argument!.claimId,
        partDirectionId: argument!.carPartDirectionEnum.id,
      ),
      onSuccess: (value) {
        carPartsForCloseUpShot.assignAll(value);
      },
    );
  }

  Future<void> getDirectionImage(int rangeId) async {
    if (argument?.claimId == null) {
      return;
    }
    switch (rangeId) {
      case 1:
        longLoading(true);
        break;
      case 2:
        middleLoading(true);
        break;
      case 3:
        closeUpLoading(true);
        break;
    }
    processUsecaseResult(
      result: await getDirectionImageDetailUsecase(
        claimId: argument!.claimId,
        rangeId: rangeId,
        partDirectionId: argument?.carPartDirectionEnum.id,
      ),
      onFail: (p0) {
        switch (rangeId) {
          case 1:
            longLoading(false);
            break;
          case 2:
            middleLoading(false);
            break;
          case 3:
            closeUpLoading(false);
            break;
        }
      },
      onSuccess: (res) {
        switch (rangeId) {
          case 1:
            longShotImages.assignAll(res);
            longLoading(false);
            break;
          case 2:
            middleShotImages.assignAll(res);
            middleLoading(false);
            break;
          case 3:
            closeUpShotImages.assignAll(res);
            closeUpLoading(false);
            break;
        }
      },
    );
  }

  onDeleteImage(String imageId) async {
    deletingList.add(imageId);

    /// delete on server
    processUsecaseResult(
      result: await deleteImageByIdUsecase(imageId: imageId),
      shouldShowError: false,
      onFail: (p0) => deletingList.remove(imageId),
      onSuccess: (p0) async {
        deletingList.remove(imageId);

        /// delete on local
        longShotImages.removeWhere((element) => element.imageId == imageId);
        middleShotImages.removeWhere((element) => element.imageId == imageId);
        closeUpShotImages.removeWhere((element) => element.imageId == imageId);
        carPartsForCloseUpShot.clear();
        await getCarPartsForCloseUpShot();

        ///
        if (Get.isRegistered<ClaimMeFolderDetailController>()) {
          await Get.find<ClaimMeFolderDetailController>().getImageDirection();
          Get.find<ClaimMeFolderDetailController>()
              .deleteImageResponseStream
              .sink
              .add(true);
        }
      },
    );
  }

  onDeleteAllImage() async {
    if (argument == null) {
      return;
    }
    isLoading(true);
    processUsecaseResult(
      result: await deleteAllImageUsecase(
        claimId: argument!.claimId,
        partDirectionId: argument!.carPartDirectionEnum.id,
      ),
      onSuccess: (p0) async {
        /// delete on local
        longShotImages.clear();
        middleShotImages.clear();
        closeUpShotImages.clear();

        ///
        carPartsForCloseUpShot.clear();

        ///
        if (Get.isRegistered<ClaimMeFolderDetailController>()) {
          await Get.find<ClaimMeFolderDetailController>().getImageDirection();
          Get.find<ClaimMeFolderDetailController>()
              .deleteImageResponseStream
              .sink
              .add(true);
        }
      },
    );
  }
}
