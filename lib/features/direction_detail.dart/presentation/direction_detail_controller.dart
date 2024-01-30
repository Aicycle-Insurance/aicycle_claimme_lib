import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../camera/presentation/camera_page.dart';
import '../../folder_detail/presentation/folder_detail_controller.dart';
import '../data/models/claim_image_model.dart';
import '../domain/usecase/delete_all_image_usecase.dart';
import '../domain/usecase/delete_image_by_id_usecase.dart';
import '../domain/usecase/get_direction_image_usecase.dart';

class DirectionDetailController extends BaseController {
  late final ClaimMeCameraArgument? argument;
  final GetDirectionImageDetailUsecase getDirectionImageDetailUsecase =
      Get.find();
  final DeleteAllImageUsecase deleteAllImageUsecase = Get.find();
  final DeleteImageByIdUsecase deleteImageByIdUsecase = Get.find();

  var longShotImages = <ClaimImageModel>[].obs;
  var middleShotImages = <ClaimImageModel>[].obs;
  var closeUpShotImages = <ClaimImageModel>[].obs;

  var longLoading = false.obs;
  var middleLoading = false.obs;
  var closeUpLoading = false.obs;

  var deletingList = <String>[].obs;

  @override
  void onReady() async {
    super.onReady();
    longLoading(true);
    getDirectionImage(1).whenComplete(() => longLoading(false));

    middleLoading(true);
    getDirectionImage(2).whenComplete(() => middleLoading(false));

    closeUpLoading(true);
    getDirectionImage(3).whenComplete(() => closeUpLoading(false));
  }

  Future<void> getDirectionImage(int rangeId) async {
    if (argument?.claimId == null) {
      return;
    }
    processUsecaseResult(
      result: await getDirectionImageDetailUsecase(
        claimId: argument!.claimId,
        rangeId: rangeId,
        partDirectionId: argument?.carPartDirectionEnum.id,
      ),
      onSuccess: (res) {
        switch (rangeId) {
          case 1:
            longShotImages.assignAll(res);
            break;
          case 2:
            middleShotImages.assignAll(res);
            break;
          case 3:
            closeUpShotImages.assignAll(res);
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

        ///
        if (Get.isRegistered<FolderDetailController>()) {
          await Get.find<FolderDetailController>().getImageDirection();
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
        if (Get.isRegistered<FolderDetailController>()) {
          await Get.find<FolderDetailController>().getImageDirection();
        }
      },
    );
  }
}
