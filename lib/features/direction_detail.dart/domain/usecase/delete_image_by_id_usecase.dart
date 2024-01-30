import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../repository/direction_detail_repository.dart';

class DeleteImageByIdUsecase {
  final DirectionDetailRepository repository;
  DeleteImageByIdUsecase(this.repository);
  Future<Either<APIErrors, bool>> call({
    required String imageId,
  }) async {
    return repository.deleteImageById(
      imageId: imageId,
    );
  }
}
