import '../entities/directional_image.dart';
import '../entities/ocr_info.dart';
import '../entities/segment_result.dart';

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

  Future<String> getValidationResult({required String claimId});

  Future<OCRInfo> getVehicleInfo(String claimId);

  Future<List<SegmentResult>> getDamageStatistics(String claimId);
}
