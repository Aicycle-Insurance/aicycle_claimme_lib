import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/models/image_direction_model.dart';
import '../repository/folder_detail_repository.dart';

class GetImageDirectionUsecase {
  final FolderDetailRepository repository;
  GetImageDirectionUsecase(this.repository);

  Future<Either<APIErrors, List<ImageDirectionModel>>> call(String claimId) {
    return repository.getImagesDirectionV2(claimId: claimId);
  }
}
