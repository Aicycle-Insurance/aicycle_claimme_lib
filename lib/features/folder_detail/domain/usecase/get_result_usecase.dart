import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../repository/folder_detail_repository.dart';

class ClaimMeGetResultUsecase {
  final FolderDetailRepository repository;
  ClaimMeGetResultUsecase(this.repository);

  Future<Either<APIErrors, dynamic>> call(String claimId) {
    return repository.getResult(claimId: claimId);
  }
}
