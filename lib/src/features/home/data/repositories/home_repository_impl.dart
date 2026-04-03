import '../../../../core/utils/internal_cache.dart';
import '../../domain/entities/directional_image.dart';
import '../../domain/entities/ocr_info.dart';
import '../../domain/entities/segment_result.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';
import '../mapper/directional_image_mapper.dart';
import '../mapper/ocr_mapper.dart';
import '../mapper/segment_result_mapper.dart';
import '../models/claim_me_folder_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<String> createNewAiCycleDocument({
    required String externalClaimId,
    String? claimName,
    String? vehicleBrandId,
    int? priceTypeId,
    bool? isClaim,
    String? brand,
    String? model,
    int? vehicleYear,
    String? vehicleSpec,
    String? licensePlate,
    String? vehicleType,
    bool? hasLicensePlate,
  }) async {
    final data = {
      'externalClaimId': externalClaimId,
      'claimName': claimName,
      'vehicleBrandId': vehicleBrandId,
      'priceTypeId': priceTypeId,
      'isClaim': isClaim,
      'brand': brand,
      'model': model,
      'vehicleYear': vehicleYear,
      'vehicleSpec': vehicleSpec,
      'vehicleLicensePlates': licensePlate,
      'vehicleType': vehicleType,
      'hasLicensePlate': hasLicensePlate,
    };
    try {
      final model = await _remoteDataSource.createClaimFolder(data);
      return _processResponse(model);
    } catch (e) {
      if (e.toString().toLowerCase().contains('duplicate')) {
        final model = await _remoteDataSource.getDuplicateFolder(
          externalClaimId,
        );
        return _processResponse(model);
      }
      rethrow;
    }
  }

  String _processResponse(ClaimMeFolderModel model) {
    final id = model.claimId?.toString() ?? '';
    InternalCache.claimId = id;
    return id;
  }

  @override
  Future<List<DirectionalImage>> getDirectionalImages({
    required String claimId,
    required String angleId,
  }) async {
    final models = await _remoteDataSource.getDirectionalImages(
      claimId: claimId,
      angleId: angleId,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> deleteImageById({
    required List<int> imageIds,
    String? vehicleAngleId,
  }) async {
    await _remoteDataSource.deleteImageById(imageIds, vehicleAngleId);
  }

  @override
  Future<String> getValidationResult({required String claimId}) {
    return _remoteDataSource.getValidationResult(claimId: claimId);
  }

  @override
  Future<OCRInfo> getVehicleInfo(String claimId) async {
    final res = await _remoteDataSource.getVehicleInfo(claimId);
    return res.toEntity();
  }

  @override
  Future<List<SegmentResult>> getDamageStatistics(String claimId) async {
    final response = await _remoteDataSource.getDamageStatistics(claimId);
    return response.map((e) => e.toEntity()).toList();
  }
}
