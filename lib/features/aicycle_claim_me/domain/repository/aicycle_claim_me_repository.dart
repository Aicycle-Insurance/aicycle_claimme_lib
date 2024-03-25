import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/model/claim_folder_model.dart';
import '../../data/model/user_info_model.dart';

abstract class AiCycleClaimMeRepository {
  Future<Either<APIErrors, ClaimFolderModel>> createFolder({
    required String externalClaimId,
    required String folderName,
    String? vehicleBrandId,
    String? parentId,
    String? vehicleLicensePlates,
    String? carColor,
    String? appUser,
    bool? hasLicensePlate = true,
  });

  Future<Either<APIErrors, ClaimFolderModel>> getDuplicateFolder({
    required String externalClaimId,
  });
  Future<Either<APIErrors, UserInfo>> getUserInfo();
}
