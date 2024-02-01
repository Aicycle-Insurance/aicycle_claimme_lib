import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/model/claim_folder_model.dart';
import '../repository/aicycle_claim_me_repository.dart';

class ClaimMeCreateFolderUsecase {
  final AiCycleClaimMeRepository repository;
  ClaimMeCreateFolderUsecase(this.repository);
  Future<Either<APIErrors, ClaimFolderModel>> call({
    required String externalClaimId,
    required String folderName,
    String? vehicleBrandId,
    String? parentId,
    String? vehicleLicensePlates,
    String? carColor,
    String? appUser,
    bool? hasLicensePlate = true,
  }) {
    return repository.createFolder(
      externalClaimId: externalClaimId,
      folderName: folderName,
      appUser: appUser,
      carColor: carColor,
      hasLicensePlate: hasLicensePlate,
      parentId: parentId,
      vehicleBrandId: vehicleBrandId,
      vehicleLicensePlates: vehicleLicensePlates,
    );
  }
}
