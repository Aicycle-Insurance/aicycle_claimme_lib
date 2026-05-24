import '../entities/upload_vehicle_inspection.dart';
import '../repositories/image_respository.dart';

class UploadImageParams {
  final String imagePath;
  final String claimId;
  final String? angleId;
  final String? positionId;
  final String? vehiclePartExcelId;
  final bool isFramedPhoto;
  // Địa điểm chụp hoặc lấy từ metadata ảnh
  final String? locationName;
  // Địa điểm tải lên
  final String? uploadLocation;
  // Thời gian tạo ảnh theo UTC
  final String? utcTimeCreated;

  UploadImageParams({
    required this.imagePath,
    required this.claimId,
    this.angleId,
    this.positionId,
    this.vehiclePartExcelId,
    this.isFramedPhoto = false,
    this.locationName,
    this.uploadLocation,
    this.utcTimeCreated,
  });
}

class UploadImageUseCase {
  final ImageRepository _repository;

  UploadImageUseCase(this._repository);

  Future<UploadVehicleInspection> call(UploadImageParams params) {
    return _repository.uploadImage(
      imagePath: params.imagePath,
      claimId: params.claimId,
      angleId: params.angleId,
      positionId: params.positionId,
      vehiclePartExcelId: params.vehiclePartExcelId,
      isFramedPhoto: params.isFramedPhoto,
      locationName: params.locationName,
      uploadLocation: params.uploadLocation,
      utcTimeCreated: params.utcTimeCreated,
    );
  }
}
