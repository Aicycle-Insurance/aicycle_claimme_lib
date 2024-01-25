import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/models/image_upload_response.dart';
import '../repository/camera_repository.dart';

class UploadImageUsecase {
  final CameraRepository repository;
  UploadImageUsecase(this.repository);

  Future<Either<APIErrors, ImageUploadResponse>> call({
    required String localFilePath,
  }) {
    return repository.uploadImageToS3Server(localFilePath: localFilePath);
  }
}
