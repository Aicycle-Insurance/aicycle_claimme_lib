import '../../../../../aicycle_claimme_plus.dart';
import '../../domain/entities/upload_vehicle_inspection.dart';
import '../models/upload_vehicle_inspection_response.dart';

extension UploadVehicleInspectionMapper on UploadVehicleInspectionResponse {
  UploadVehicleInspection toEntity() {
    return UploadVehicleInspection(
      errorCodeFromEngine: errorCodeFromEngine,
      errorMessage: errorMessage,
      imageId: imageId,
      imgUrl: imgUrl,
      angleFromEngine: imageDirection.toAngle(),
    );
  }
}

extension on String? {
  AicycleCarAngle? toAngle() {
    switch (this) {
      case 'truoc-sT9qgX':
        return AicycleCarAngle.front;
      case 'sau-htBwjB':
        return AicycleCarAngle.rear;
      case 'trai-truoc-r6BEZd':
      case '45-trai-truoc-C1xM02':
        return AicycleCarAngle.frontLeft;
      case 'phai-truoc-eYWg1d':
      case '45-phai-truoc-UoYzs6':
        return AicycleCarAngle.frontRight;
      case '45-trai-sau-1q3G3J':
      case 'trai-sau-t8QgFO':
        return AicycleCarAngle.rearLeft;
      case 'phai-sau-v1hAm6':
      case '45-phai-sau-fRzY3r':
        return AicycleCarAngle.rearRight;
      case 'dang-kiem-xe-82YjAa':
        return AicycleCarAngle.regCert;
      default:
        return null;
    }
  }
}
