import '../entities/car_part_has_damage.dart';
import '../entities/upload_vehicle_inspection.dart';

abstract class ImageRepository {
  Future<UploadVehicleInspection> uploadVehicleInspection({
    required String imagePath,
    required String claimId,
  });

  Future<UploadVehicleInspection> uploadImage({
    required String imagePath,
    required String claimId,
    String? angleId,
    String? positionId,
    String? vehiclePartExcelId,
    bool isFramedPhoto = false,
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
