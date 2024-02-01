import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/models/image_upload_response.dart';
import '../repository/camera_repository.dart';

class ClaimMeUploadImageUsecase {
  final CameraRepository repository;
  ClaimMeUploadImageUsecase(this.repository);

  Future<Either<APIErrors, ImageUploadResponse>> call({
    required String localFilePath,
  }) {
    return repository.uploadImageToS3Server(localFilePath: localFilePath);
  }
}
