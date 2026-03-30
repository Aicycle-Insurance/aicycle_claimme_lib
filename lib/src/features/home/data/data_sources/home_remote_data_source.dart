import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/claim_me_folder_model.dart';
import '../models/directional_image_model.dart';

abstract class HomeRemoteDataSource {
  Future<ClaimMeFolderModel> createBuyFolder(Map<String, dynamic> data);
  Future<ClaimMeFolderModel> getDuplicateFolder(String externalId);
  Future<List<DirectionalImageModel>> getDirectionalImages({
    required String claimId,
    required String angleId,
  });
  Future<void> deleteImageById(List<int> imageIds, String? vehicleAngleId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ClaimMeFolderModel> createBuyFolder(Map<String, dynamic> data) async {
    final response = await _dioClient.post<dynamic>(
      ApiEndpoints.createClaimDocument,
      data: data,
    );
    return ClaimMeFolderModel.fromDynamic(response);
  }

  @override
  Future<ClaimMeFolderModel> getDuplicateFolder(String externalId) async {
    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.createClaimDocument,
      queryParameters: {'externalClaimId': externalId},
    );
    return ClaimMeFolderModel.fromDynamic(response);
  }

  @override
  Future<List<DirectionalImageModel>> getDirectionalImages({
    required String claimId,
    required String angleId,
  }) async {
    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.directionalImages,
      queryParameters: {'direction': angleId, 'claimId': claimId},
    );
    return DirectionalImagesResponse.fromJson(
      response as Map<String, dynamic>,
    ).images;
  }

  @override
  Future<void> deleteImageById(
    List<int> imageIds,
    String? vehicleAngleId,
  ) async {
    final ids = List<int>.from(imageIds);
    for (final int imageId in ids) {
      await _dioClient.delete<dynamic>(
        ApiEndpoints.deleteImageById(imageId.toString()),
        queryParameters: vehicleAngleId != null
            ? {'direction': vehicleAngleId}
            : null,
      );
    }
  }
}
