import 'package:aicycle_claimme_lib/features/camera/data/models/car_part_has_damage_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/contants/direction_constant.dart';
import '../../../../enum/car_part_direction.dart';
import '../../../../network/api_error.dart';
import '../../../aicycle_claim_me/presentation/aicycle_claim_me.dart';
import '../../domain/repository/direction_detail_repository.dart';
import '../models/claim_image_model.dart';
import '../remote_data/direction_detail_api.dart';

class ClaimMeDirectionDetailRepositoryImpl
    implements DirectionDetailRepository {
  @override
  Future<Either<APIErrors, List<ClaimImageModel>>> getClaimImages({
    int? currentPage,
    int? pageSize,
    int? rangeId,
    int? partDirectionId,
    required String claimId,
  }) async {
    try {
      late final dynamic res;
      if (enableVersion2 == true) {
        res = await DirectionDetailAPI.getDirectionImageV2(
          claimId: claimId,
          offset: currentPage,
          limit: pageSize,
          position: rangeId != null ? positionIds[rangeId - 1] : null,
          direction: partDirectionId != null
              ? CarPartDirectionEnum.fromId(partDirectionId).excelId
              : null,
        ).request();
      } else {
        res = await DirectionDetailAPI.getDirectionImageV1(
          claimId: claimId,
          pageSize: pageSize,
          rangeId: rangeId,
          partDirectionId: partDirectionId,
          currentPage: currentPage,
        ).request();
      }
      return Right(List<ClaimImageModel>.from(
          (res as List).map((e) => ClaimImageModel.fromJson(e)).toList()));
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }

  @override
  Future<Either<APIErrors, bool>> deleteAllImage(
      {int? partDirectionId, required String claimId}) async {
    try {
      await DirectionDetailAPI.deleteAllImage(
        claimId: claimId,
        partDirectionId: partDirectionId,
      ).request();
      return const Right(true);
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }

  @override
  Future<Either<APIErrors, bool>> deleteImageById(
      {required String imageId}) async {
    try {
      await DirectionDetailAPI.deleteImageById(
        imageId: imageId,
      ).request();
      return const Right(true);
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }

  @override
  Future<Either<APIErrors, List<CarPartHasDamageModel>>> getCarPartHasDamage(
      {required int partDirectionId, required String claimId}) async {
    try {
      final res = await DirectionDetailAPI.getCarPartHasDamage(
        claimId: claimId,
        directionId: partDirectionId.toString(),
      ).request();
      return Right(List<CarPartHasDamageModel>.from((res as List)
          .map((e) => CarPartHasDamageModel.fromJson(e))
          .toList()));
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }
}
