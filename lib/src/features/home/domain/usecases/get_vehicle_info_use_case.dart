import '../entities/ocr_info.dart';
import '../repositories/home_repository.dart';

class GetVehicleInfoUseCase {
  final HomeRepository _repository;
  GetVehicleInfoUseCase(this._repository);

  Future<OCRInfo> call(String params) {
    return _repository.getVehicleInfo(params);
  }
}
