import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../repository/direction_detail_repository.dart';

class DeleteAllImageUsecase {
  final DirectionDetailRepository repository;
  DeleteAllImageUsecase(this.repository);
  Future<Either<APIErrors, bool>> call({
    int? partDirectionId,
    required String claimId,
  }) async {
    return repository.deleteAllImage(
      claimId: claimId,
      partDirectionId: partDirectionId,
    );
  }
}
