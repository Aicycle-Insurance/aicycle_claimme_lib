import '../entities/directional_image.dart';

abstract class HomeRepository {
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
  });

  Future<List<DirectionalImage>> getDirectionalImages({
    required String claimId,
    required String angleId,
  });

  Future<void> deleteImageById({
    required List<int> imageIds,
    String? vehicleAngleId,
  });
}
