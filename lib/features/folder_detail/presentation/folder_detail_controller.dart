import 'dart:async';

import 'package:aicycle_claimme_lib/enum/car_part_direction.dart';
import 'package:aicycle_claimme_lib/features/aicycle_claim_me/data/model/user_info_model.dart';
import 'package:aicycle_claimme_lib/features/aicycle_claim_me/domain/usecase/get_user_info_usecase.dart';
import 'package:get/get.dart';

import '../../../common/base_controller.dart';
import '../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import '../../camera/data/models/damage_assessment_response.dart';
import '../data/models/image_direction_model.dart';
import '../domain/usecase/get_image_direction_usecase.dart';
import '../domain/usecase/get_result_usecase.dart';

class ClaimMeFolderDetailController extends ClaimMeBaseController {
  final ClaimMeGetImageDirectionUsecase getImageDirectionUsecase = Get.find();
  final ClaimMeGetResultUsecase getResultUsecase = Get.find();
  final GetUserInfoUsecase getUserInfoUsecase = Get.find();
  late AiCycleClaimMeArgument argument;

  // var imagesDirections = <ImageDirectionModel>[].obs;
  final front = Rx<ImageDirectionModel?>(null);
  final leftFront = Rx<ImageDirectionModel?>(null);
  final rightFront = Rx<ImageDirectionModel?>(null);
  final leftBack = Rx<ImageDirectionModel?>(null);
  final back = Rx<ImageDirectionModel?>(null);
  final rightBack = Rx<ImageDirectionModel?>(null);

  final damageResponseStream =
      StreamController<DamageAssessmentResponse?>.broadcast();
  final deleteImageResponseStream = StreamController<bool?>.broadcast();

  bool get hideCloseUpShot {
    if (user?.data?.organizations != null &&
        user!.data!.organizations!.isNotEmpty) {
      return user!
              .data!.organizations!.first.kvp?.settings?.disableClosePhoto ??
          false;
    }
    return false;
  }

  @override
  void onReady() async {
    super.onReady();
    if (user == null) {
      await getUserInfo();
    }
    await getImageDirection();
  }

  @override
  void onClose() {
    damageResponseStream.close();
    deleteImageResponseStream.close();
    super.onClose();
  }

  Future<void> getImageDirection() async {
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
    front.value = null;
    leftFront.value = null;
    rightFront.value = null;
    leftBack.value = null;
    back.value = null;
    rightBack.value = null;
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

  Future<void> getResult(Function(dynamic)? resultCallBack) async {
    if (argument.aicycleClaimId == null) {
      return;
    }
    isLoading(true);
    processUsecaseResult(
      result: await getResultUsecase(argument.aicycleClaimId!),
      onSuccess: (p0) {
        resultCallBack?.call(p0);
      },
    );
  }

  Future<void> getUserInfo() async {
    isLoading(true);
    processUsecaseResult<UserInfoResponse>(
      result: await getUserInfoUsecase(),
      onSuccess: (p0) {
        user = p0;
      },
    );
  }
}
