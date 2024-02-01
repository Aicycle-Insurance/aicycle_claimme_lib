import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../../camera/data/models/car_part_has_damage_model.dart';
import '../repository/direction_detail_repository.dart';

class ClaimMeGetCarPartHasDamageUsecase {
  final DirectionDetailRepository repository;
  ClaimMeGetCarPartHasDamageUsecase(this.repository);
  Future<Either<APIErrors, List<CarPartHasDamageModel>>> call({
    required int partDirectionId,
    required String claimId,
  }) async {
    return repository.getCarPartHasDamage(
      claimId: claimId,
      partDirectionId: partDirectionId,
    );
  }
}
