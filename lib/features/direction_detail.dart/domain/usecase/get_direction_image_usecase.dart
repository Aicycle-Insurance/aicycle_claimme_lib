import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/models/claim_image_model.dart';
import '../repository/direction_detail_repository.dart';

class GetDirectionImageDetailUsecase {
  final DirectionDetailRepository repository;
  GetDirectionImageDetailUsecase(this.repository);
  Future<Either<APIErrors, List<ClaimImageModel>>> call({
    int? currentPage,
    int? pageSize,
    int? rangeId,
    int? partDirectionId,
    required String claimId,
  }) async {
    return repository.getClaimImages(
      claimId: claimId,
      currentPage: currentPage,
      pageSize: pageSize,
      rangeId: rangeId,
      partDirectionId: partDirectionId,
    );
  }
}
