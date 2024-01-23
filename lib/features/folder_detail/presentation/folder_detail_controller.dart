import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import '../data/models/image_direction_model.dart';
import '../domain/usecase/get_image_direction_usecase.dart';

class FolderDetailController extends BaseController {
  final GetImageDirectionUsecase getImageDirectionUsecase = Get.find();
  late AiCycleClaimMeArgument argument;

  var imagesDirections = <ImageDirectionModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    getImageDirection();
  }

  void getImageDirection() async {
    isLoading(true);
    processUsecaseResult<List<ImageDirectionModel>>(
      result: await getImageDirectionUsecase(argument.externalClaimId),
      onSuccess: (result) {
        imagesDirections.assignAll(result);
      },
    );
  }
}
