import '../entities/car_part_has_damage.dart';
import '../repositories/image_respository.dart';

class GetListCarPartHasDamageUseCase {
  final ImageRepository repository;

  GetListCarPartHasDamageUseCase(this.repository);
  Future<List<CarPartHasDamage>> call(
    GetListCarPartHasDamageParams params,
  ) async {
    return await repository.getCarPartHasDamage(
      claimId: params.claimId,
      directionId: params.directionId,
    );
  }
}

class GetListCarPartHasDamageParams {
  final String claimId;
  final String directionId;

  GetListCarPartHasDamageParams({
    required this.claimId,
    required this.directionId,
  });
}
