import '../../../../core/utils/internal_cache.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';
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
      'licensePlate': licensePlate,
      'vehicleType': vehicleType,
      'hasLicensePlate': hasLicensePlate,
    };
    try {
      final model = await _remoteDataSource.createBuyFolder(data);
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
}
