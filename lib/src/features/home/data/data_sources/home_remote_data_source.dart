import '../../../../../aicycle_claimme_plus.dart';
import '../../../../core/extension/car_angle_ext.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/claim_me_folder_model.dart';
import '../models/directional_image_model.dart';
import '../models/segment_result_model.dart';
import '../models/vehicle_info_model.dart';

abstract class HomeRemoteDataSource {
  Future<ClaimMeFolderModel> createClaimFolder(Map<String, dynamic> data);
  Future<ClaimMeFolderModel> getDuplicateFolder(String externalId);
  Future<List<DirectionalImageModel>> getDirectionalImages({
    required String claimId,
    required String angleId,
  });
  Future<void> deleteImageById(List<int> imageIds, String? vehicleAngleId);
  Future<String> getValidationResult({required String claimId});
  Future<VehicleInfoModel> getVehicleInfo(String claimId);
  Future<List<SegmentResultModel>> getDamageStatistics(String claimId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ClaimMeFolderModel> createClaimFolder(
    Map<String, dynamic> data,
  ) async {
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

  @override
  Future<String> getValidationResult({required String claimId}) async {
    final response = await _dioClient.post<dynamic>(
      ApiEndpoints.getValidationResult,
      data: {'claimId': claimId, 'direction': AicycleCarAngle.exterior.id},
    );
    if (response['message'] != null) {
      return response['message'] as String;
    }
    return '';
  }

  @override
  Future<VehicleInfoModel> getVehicleInfo(String claimId) async {
    final response = await _dioClient.get<dynamic>(
      ApiEndpoints.getVehicleInfo,
      queryParameters: {'claimId': claimId},
    );
    return VehicleInfoModel.fromJson(response);
  }

  @override
  Future<List<SegmentResultModel>> getDamageStatistics(String claimId) async {
    final response = await _dioClient.get<List<dynamic>>(
      ApiEndpoints.getSegmentResult(claimId),
    );
    return response.map((e) => SegmentResultModel.fromJson(e)).toList();
  }
}
