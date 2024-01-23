import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../domain/repository/aicycle_claim_me_repository.dart';
import '../model/claim_folder_model.dart';
import '../remote_data/aicycle_claim_me_api.dart';

class AicycleClaimMeRepositoryImpl implements AiCycleClaimMeRepository {
  @override
  Future<Either<APIErrors, ClaimFolderModel>> createFolder({
    required String externalClaimId,
    required String folderName,
    String? vehicleBrandId,
    String? parentId,
    String? vehicleLicensePlates,
    String? carColor,
    String? appUser,
    bool? hasLicensePlate = true,
  }) async {
    try {
      final res = await AicycleClaimMeApi.createFolder(
        externalClaimId: externalClaimId,
        folderName: folderName,
        appUser: appUser,
        carColor: carColor,
        hasLicensePlate: hasLicensePlate,
        parentId: parentId,
        vehicleBrandId: vehicleBrandId,
        vehicleLicensePlates: vehicleLicensePlates,
      ).request();
      if (res is List) {
        return Right(ClaimFolderModel.fromJson(res[0]));
      }
      return Right(ClaimFolderModel.fromJson(res));
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }

  @override
  Future<Either<APIErrors, ClaimFolderModel>> getDuplicateFolder(
      {required String externalClaimId}) async {
    try {
      final res = await AicycleClaimMeApi.getDuplicateFolder(
        externalClaimId: externalClaimId,
      ).request();
      return Right(ClaimFolderModel.fromJson(res[0]));
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }
}
