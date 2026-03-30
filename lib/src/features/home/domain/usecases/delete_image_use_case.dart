import '../repositories/home_repository.dart';

class DeleteImageUseCaseParams {
  final List<int> imageIds;
  final String? vehicleAngleId;
  DeleteImageUseCaseParams({required this.imageIds, this.vehicleAngleId});
}

class DeleteImageUseCase {
  final HomeRepository _repository;
  DeleteImageUseCase(this._repository);

  Future<void> call(DeleteImageUseCaseParams params) async {
    await _repository.deleteImageById(
      imageIds: params.imageIds,
      vehicleAngleId: params.vehicleAngleId,
    );
  }
}
