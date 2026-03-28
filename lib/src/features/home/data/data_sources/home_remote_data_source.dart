import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/claim_me_folder_model.dart';

abstract class HomeRemoteDataSource {
  Future<ClaimMeFolderModel> createBuyFolder(Map<String, dynamic> data);
  Future<ClaimMeFolderModel> getDuplicateFolder(String externalId);
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
}
