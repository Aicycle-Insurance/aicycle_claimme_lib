import '../../domain/entities/car_part_has_damage.dart';
import '../../domain/entities/cert_upload_entity.dart';
import '../../domain/entities/upload_vehicle_inspection.dart';
import '../../domain/repositories/image_respository.dart';
import '../data_source/image_remote_data_source.dart';
import '../mapper/car_part_has_damage_mapper.dart';
import '../mapper/upload_vehicle_inspection_mapper.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource _remoteDataSource;
  ImageRepositoryImpl(this._remoteDataSource);

  @override
  Future<CertUploadEntity> uploadVehicleInspection({
    required List<String> imagePaths,
    required String claimId,
  }) async {
    final response = await _remoteDataSource.uploadVehicleInspection(
      imagePaths: imagePaths,
      claimId: claimId,
    );
    return response.toEntity();
  }

  @override
  Future<UploadVehicleInspection> uploadImage({
    required String imagePath,
    required String claimId,
    String? angleId,
    String? positionId,
    String? vehiclePartExcelId,
    bool isFramedPhoto = false,
  }) async {
    final response = await _remoteDataSource.uploadImage(
      imagePath: imagePath,
      claimId: claimId,
      angleId: angleId,
      positionId: positionId,
      vehiclePartExcelId: vehiclePartExcelId,
      isFramedPhoto: isFramedPhoto,
    );
    return response.toEntity();
  }

  @override
  Future<void> deleteImageById({
    required List<int> imageIds,
    String? vehicleAngleId,
  }) async {
    await _remoteDataSource.deleteImageById(imageIds, vehicleAngleId);
  }

  @override
  Future<List<CarPartHasDamage>> getCarPartHasDamage({
    required String claimId,
    required String directionId,
  }) async {
    final response = await _remoteDataSource.getCarPartHasDamage(
      claimId: claimId,
      directionId: directionId,
    );
    return response.map((e) => e.toEntity()).toList();
  }
}
