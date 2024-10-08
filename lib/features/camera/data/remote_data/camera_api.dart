// import 'package:aicycle_claimme_lib/common/contants/direction_constant.dart';
// import 'package:aicycle_claimme_lib/enum/car_part_direction.dart';

import '../../../../network/api_request.dart';
import '../../../../network/endpoints.dart';

class CameraAPI extends APIRequest {
  ///
  CameraAPI.callEngineV2({
    required String claimId,
    required String imageName,
    required String filePath,
    required String position,
    required String direction,
    required String vehiclePartExcelId,
    String? resizePath,
    String? oldImageId,
    double? timeAppUpload,
    String? locationName,
    String? uploadLocation,
    String? utcTimeCreated,
    bool? isTruck,
  }) : super(
          endpoint: Endpoint.callClaimMeEngine,
          method: HTTPMethod.post,
          isLogResponse: true,
          isBaseResponse: false,
          body: {
            "claimId": claimId,
            "imageName": imageName,
            "filePath": filePath,
            "position": position,
            "direction": direction,
            "vehiclePartExcelId": vehiclePartExcelId,
            if (oldImageId != null) "oldImageId": oldImageId,
            "timeAppUpload": timeAppUpload,
            "resizePath": resizePath,
            "location": locationName,
            "requestedTime": utcTimeCreated,
            "uploadLocation": uploadLocation,
            "isValidate": true,
            if (isTruck == true) "vehicleType": "truck",
          },
        );

  CameraAPI.getImageUploadUrl({required String serverFilePath})
      : super(
          endpoint: Endpoint.getImageUploadUrl,
          method: HTTPMethod.post,
          isLogResponse: false,
          body: {
            'filePaths': [serverFilePath]
          },
        );

  CameraAPI.validateAfterUploadToS3({required String serverFilePath})
      : super(
            endpoint: Endpoint.validateUpload,
            method: HTTPMethod.post,
            isLogResponse: false,
            body: {'filePath': serverFilePath});

  // CameraAPI.uploadImageToS3Server({required String localFilePath})
  //     : super(
  //         endpoint: Endpoint.callEngine,
  //         method: HTTPMethod.post,
  //         isLogResponse: true,
  //         body: {
  //           "claimId": claimId,
  //           "imageName": imageName,
  //           "filePath": filePath,
  //           "position": position,
  //           "direction": direction,
  //           "vehiclePartExcelId": vehiclePartExcelId,
  //           "oldImageId": oldImageId,
  //           "timeAppUpload": timeAppUpload,
  //           "resizePath": resizePath,
  //           "location": locationName,
  //           "requestedTime": utcTimeCreated,
  //           "uploadLocation": uploadLocation,
  //         },
  //       );
}
