import 'package:flutter/foundation.dart';

import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/internal_cache.dart';
import '../../domain/usecases/create_buyme_folder_use_case.dart';

/// Status of the BuyMe folder creation or initialization process.
enum ClaimMeStatus { initial, loading, success, error }

class HomeController extends ChangeNotifier {
  final CreateBuyMeFolderUseCase _createBuyMeFolderUseCase =
      sl.createBuyMeFolderUseCase;

  ClaimMeStatus _status = ClaimMeStatus.initial;
  String _errorMessage = '';
  bool _isDisposed = false;

  ClaimMeStatus get status => _status;
  String get errorMessage => _errorMessage;

  /// Create new or get existing AiCycle document, then load all directional images.
  Future<void> init(AiCycleConfig config) async {
    try {
      _status = ClaimMeStatus.loading;
      if (!_isDisposed) notifyListeners();

      AicycleClaimMe.configInternal = config;

      if (config.generalConfig.organization == AiCycleOrg.aicycle) {
        InternalCache.claimId = config.generalConfig.documentId;
      } else {
        final carInfo = config.carInformation;

        await _createBuyMeFolderUseCase(
          CreateBuyMeFolderParams(
            externalClaimId: config.generalConfig.documentId,
            claimName:
                config.generalConfig.documentName ??
                config.generalConfig.documentId,
            vehicleBrandId: '5',
            priceTypeId: 10,
            isClaim: true,
            brand: carInfo?.carCompanyId,
            model: carInfo?.carModelId,
            vehicleYear: carInfo?.manufacturingYear,
            vehicleSpec: carInfo?.vehicleSpec,
            licensePlate: carInfo?.licensePlate,
            vehicleType: carInfo?.vehicleType ?? 'truck',
            hasLicensePlate: carInfo?.licensePlate?.isNotEmpty == true,
          ),
        );
      }

      // await sl.vehicleImageVault.loadAllDirectionalImages();
      // await sl.validationVault.validateVehicleAngle();

      _status = ClaimMeStatus.success;
      if (!_isDisposed) notifyListeners();
    } catch (e) {
      _status = ClaimMeStatus.error;
      _errorMessage = e.toString();
      if (!_isDisposed) notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    InternalCache.resetAll();
    // sl.vehicleImageVault.reset();
    // sl.validationVault.reset();
    AicycleClaimMe.configInternal = null;
    super.dispose();
  }
}
