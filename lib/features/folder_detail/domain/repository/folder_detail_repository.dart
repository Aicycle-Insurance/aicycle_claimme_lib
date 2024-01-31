import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/models/image_direction_model.dart';

abstract class FolderDetailRepository {
  Future<Either<APIErrors, List<ImageDirectionModel>>> getImagesDirectionV2(
      {required String claimId});
  Future<Either<APIErrors, dynamic>> getResult({required String claimId});
}
