import 'package:flutter/foundation.dart';

import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/internal_cache.dart';
import '../../domain/usecases/create_claimme_folder_use_case.dart';
import '../../domain/usecases/get_vehicle_info_use_case.dart';
import '../../domain/entities/ocr_info.dart';

/// Status of the ClaimMe folder creation or initialization process.
enum ClaimMeStatus { initial, loading, success, error }

class HomeController extends ChangeNotifier {
  final CreateClaimMeFolderUseCase _createClaimMeFolderUseCase =
      sl.createClaimMeFolderUseCase;
  final GetVehicleInfoUseCase _getVehicleInfoUseCase = sl.getVehicleInfoUseCase;

  ClaimMeStatus _status = ClaimMeStatus.initial;
  String _errorMessage = '';
  bool _isDisposed = false;
  OCRInfo? _ocrInfo;
  bool _isFetchingOCR = false;
  int _previousRegCertCount = 0;

  ClaimMeStatus get status => _status;
  String get errorMessage => _errorMessage;
  OCRInfo? get ocrInfo => _ocrInfo;
  bool get isFetchingOCR => _isFetchingOCR;

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

        await _createClaimMeFolderUseCase(
          CreateClaimMeFolderParams(
            externalClaimId: config.generalConfig.documentId,
            claimName:
                config.generalConfig.documentName ??
                config.generalConfig.documentId,
            vehicleBrandId: '5',
            priceTypeId: 10,
            isClaim: false,
            brand: carInfo?.carCompanyId,
            model: carInfo?.carModelId,
            vehicleYear: carInfo?.manufacturingYear,
            vehicleSpec: carInfo?.vehicleVersion,
            licensePlate: carInfo?.licensePlate,
            vehicleType: carInfo?.vehicleType ?? 'truck',
            hasLicensePlate: carInfo?.licensePlate.isNotEmpty == true,
          ),
        );
      }

      await sl.vehicleImageVault.loadAllDirectionalImages();
      sl.vehicleImageVault.addListener(_onVaultChanged);
      _onVaultChanged();

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
    sl.vehicleImageVault.removeListener(_onVaultChanged);
    InternalCache.resetAll();
    sl.vehicleImageVault.reset();
    // sl.validationVault.reset();
    AicycleClaimMe.configInternal = null;
    super.dispose();
  }

  void _onVaultChanged() async {
    final images = sl.vehicleImageVault.regCertImages;
    final currentCount = images.length;

    // Nếu số lượng ảnh thay đổi (tăng hoặc giảm)
    if (currentCount != _previousRegCertCount) {
      _previousRegCertCount = currentCount;

      if (currentCount > 0) {
        final claimId = InternalCache.claimId;
        if (claimId.isEmpty) return;

        _isFetchingOCR = true;
        if (!_isDisposed) notifyListeners();

        try {
          _ocrInfo = await _getVehicleInfoUseCase(claimId);
        } catch (e) {
          debugPrint('Error fetching vehicle info: $e');
        } finally {
          _isFetchingOCR = false;
          if (!_isDisposed) notifyListeners();
        }
      } else {
        // Nếu xóa hết ảnh
        _ocrInfo = null;
        if (!_isDisposed) notifyListeners();
      }
    }
  }
}
