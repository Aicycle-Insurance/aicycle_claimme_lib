import '../entities/car_part_has_damage.dart';
import '../entities/cert_upload_entity.dart';
import '../entities/upload_vehicle_inspection.dart';

abstract class ImageRepository {
  Future<CertUploadEntity> uploadVehicleInspection({
    required List<String> imagePaths,
    required String claimId,
  });

  Future<UploadVehicleInspection> uploadImage({
    required String imagePath,
    required String claimId,
    String? angleId,
    String? positionId,
    String? vehiclePartExcelId,
    bool isFramedPhoto = false,
    String? locationName,
    String? uploadLocation,
    String? utcTimeCreated,
  });

  Future<void> deleteImageById({
    required List<int> imageIds,
    String? vehicleAngleId,
  });

  Future<List<CarPartHasDamage>> getCarPartHasDamage({
    required String claimId,
    required String directionId,
  });
}
