import 'package:aicycle_claimme_lib/enum/car_part_direction.dart';
import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import '../data/models/image_direction_model.dart';
import '../domain/usecase/get_image_direction_usecase.dart';

class FolderDetailController extends BaseController {
  final GetImageDirectionUsecase getImageDirectionUsecase = Get.find();
  late AiCycleClaimMeArgument argument;

  // var imagesDirections = <ImageDirectionModel>[].obs;
  var front = Rx<ImageDirectionModel?>(null);
  var leftFront = Rx<ImageDirectionModel?>(null);
  var rightFront = Rx<ImageDirectionModel?>(null);
  var leftBack = Rx<ImageDirectionModel?>(null);
  var back = Rx<ImageDirectionModel?>(null);
  var rightBack = Rx<ImageDirectionModel?>(null);

  @override
  void onReady() {
    super.onReady();
    getImageDirection();
  }

  void getImageDirection() async {
    if (argument.aicycleClaimId == null) {
      return;
    }
    isLoading(true);
    processUsecaseResult<List<ImageDirectionModel>>(
      result: await getImageDirectionUsecase(argument.aicycleClaimId!),
      onSuccess: (result) {
        matchDirection(result);
      },
    );
  }

  void matchDirection(List<ImageDirectionModel> value) {
    for (ImageDirectionModel direction in value) {
      if (direction.directionSlug == CarPartDirectionEnum.front.excelId) {
        front.value = direction;
      } else if (direction.directionSlug ==
          CarPartDirectionEnum.leftFront.excelId) {
        leftFront.value = direction;
      } else if (direction.directionSlug ==
          CarPartDirectionEnum.rightFront.excelId) {
        rightFront.value = direction;
      } else if (direction.directionSlug ==
          CarPartDirectionEnum.leftBack.excelId) {
        leftBack.value = direction;
      } else if (direction.directionSlug == CarPartDirectionEnum.back.excelId) {
        back.value = direction;
      } else if (direction.directionSlug ==
          CarPartDirectionEnum.rightBack.excelId) {
        rightBack.value = direction;
      }
    }
  }
}
