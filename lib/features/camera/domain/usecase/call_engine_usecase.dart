import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/models/damage_assessment_response.dart';
import '../repository/camera_repository.dart';

class ClaimMeCallEngineUsecase {
  final CameraRepository repository;
  ClaimMeCallEngineUsecase(this.repository);

  Future<Either<APIErrors, DamageAssessmentResponse>> call({
    required String claimId,
    required String imageName,
    required String filePath,
    required String position,
    required String direction,
    required String vehiclePartExcelId,
    String? oldImageId,
    double? timeAppUpload,
    String? resizePath,
    String? locationName,
    String? uploadLocation,
    String? utcTimeCreated,
    bool? isTruck,
  }) async {
    return repository.callAiEngineAfterTakePhotoV2(
      claimId: claimId,
      imageName: imageName,
      filePath: filePath,
      position: position,
      direction: direction,
      vehiclePartExcelId: vehiclePartExcelId,
      locationName: locationName,
      oldImageId: oldImageId,
      resizePath: resizePath,
      timeAppUpload: timeAppUpload,
      uploadLocation: uploadLocation,
      utcTimeCreated: utcTimeCreated,
      isTruck: isTruck,
    );
  }
}
