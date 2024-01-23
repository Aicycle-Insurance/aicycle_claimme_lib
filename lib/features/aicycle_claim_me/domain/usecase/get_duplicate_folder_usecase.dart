import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/model/claim_folder_model.dart';
import '../repository/aicycle_buy_me_repository.dart';

class GetDuplicateFolderUsecase {
  final AiCycleBuyMeRepository repository;
  GetDuplicateFolderUsecase(this.repository);
  Future<Either<APIErrors, ClaimFolderModel>> call({
    required String externalClaimId,
  }) async {
    return repository.getDuplicateFolder(externalClaimId: externalClaimId);
  }
}
