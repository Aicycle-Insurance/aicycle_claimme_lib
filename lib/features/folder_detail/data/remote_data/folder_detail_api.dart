import '../../../../network/api_request.dart';
import '../../../../network/endpoints.dart';

class FolderDetailApi extends APIRequest {
  ///
  FolderDetailApi.getImagesDirectionV2(String claimId)
      : super(
          endpoint:
              Endpoint.getImageDirectionV2.replaceAll('{claimId}', claimId),
          method: HTTPMethod.get,
          isLogResponse: false,
        );

  ///
  FolderDetailApi.getResult(String claimId)
      : super(
          endpoint: Endpoint.getResult.replaceAll('{claimId}', claimId),
          method: HTTPMethod.get,
          isLogResponse: true,
        );
}
