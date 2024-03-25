import '../../../../network/api_request.dart';
import '../../../../network/endpoints.dart';
import '../../presentation/aicycle_claim_me.dart';

class AicycleClaimMeApi extends APIRequest {
  AicycleClaimMeApi.createFolder({
    required String externalClaimId,
    required String folderName,
    String? vehicleBrandId,
    String? parentId,
    String? vehicleLicensePlates,
    String? carColor,
    String? appUser,
    bool? hasLicensePlate = true,
  }) : super(
            endpoint: Endpoint.claimFolders,
            method: HTTPMethod.post,
            isLogResponse: false,
            body: {
              "claimName": folderName,
              "vehicleBrandId": vehicleBrandId,
              if (vehicleLicensePlates != null)
                "vehicleLicensePlates": vehicleLicensePlates,
              "externalClaimId": externalClaimId,
              if (carColor != null) "carColor": carColor,
              if (appUser != null) "appUser": appUser,
              "isClaim": true,
              if (hasLicensePlate != null) "hasLicensePlate": hasLicensePlate,
              if (parentId != null) "parentClaimId": parentId,
            });

  ///
  AicycleClaimMeApi.getDuplicateFolder({
    required String externalClaimId,
  }) : super(
            endpoint: Endpoint.claimFolders,
            method: HTTPMethod.get,
            isLogResponse: false,
            query: {
              "externalClaimId": externalClaimId,
            });

  ///
  AicycleClaimMeApi.getUserInfo()
      : super(
          endpoint: Endpoint.getUserInfo,
          method: HTTPMethod.get,
          baseUrl: environment == Evn.production
              ? BaseEndpoint.adminBaseUrl
              : environment == Evn.stage
                  ? BaseEndpoint.stageAdminBaseUrl
                  : BaseEndpoint.devAdminBaseUrl,
          isLogResponse: false,
          isBaseResponse: false,
        );
}
