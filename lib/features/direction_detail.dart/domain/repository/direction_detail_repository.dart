import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../../camera/data/models/car_part_has_damage_model.dart';
import '../../data/models/claim_image_model.dart';

abstract class DirectionDetailRepository {
  Future<Either<APIErrors, List<ClaimImageModel>>> getClaimImages({
    int? currentPage,
    int? pageSize,
    int? rangeId,
    int? partDirectionId,
    required String claimId,
  });
  Future<Either<APIErrors, bool>> deleteAllImage({
    int? partDirectionId,
    required String claimId,
  });
  Future<Either<APIErrors, bool>> deleteImageById({
    required String imageId,
  });

  Future<Either<APIErrors, List<CarPartHasDamageModel>>> getCarPartHasDamage({
    required int partDirectionId,
    required String claimId,
  });
}
