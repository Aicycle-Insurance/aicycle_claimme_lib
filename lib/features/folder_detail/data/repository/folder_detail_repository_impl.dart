import 'package:aicycle_claimme_lib/features/folder_detail/data/models/image_direction_model.dart';
import 'package:aicycle_claimme_lib/features/folder_detail/data/remote_data/folder_detail_api.dart';

import 'package:aicycle_claimme_lib/network/api_error.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/folder_detail_repository.dart';

class FolderDetailRepositoryImpl implements FolderDetailRepository {
  @override
  Future<Either<APIErrors, List<ImageDirectionModel>>> getImagesDirectionV2(
      {required String claimId}) async {
    try {
      final res = await FolderDetailApi.getImagesDirectionV2(claimId).request();
      return Right(List<ImageDirectionModel>.from(
          (res as List).map((e) => ImageDirectionModel.fromJson(e)).toList()));
    } catch (e) {
      if (e is APIErrors) {
        return Left(e);
      } else {
        return Left(FetchDataError(e.toString()));
      }
    }
  }
}
