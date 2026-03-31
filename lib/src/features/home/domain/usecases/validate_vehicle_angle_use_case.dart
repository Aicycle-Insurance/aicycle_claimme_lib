import '../repositories/home_repository.dart';

class ValidateVehicleAngleUseCase {
  final HomeRepository _repository;

  ValidateVehicleAngleUseCase(this._repository);

  Future<String> call(String claimId) {
    return _repository.getValidationResult(claimId: claimId);
  }
}
