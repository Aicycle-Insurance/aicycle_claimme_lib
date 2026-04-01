import '../../domain/entities/ocr_info.dart';
import '../models/vehicle_info_model.dart';

extension OCRMapper on VehicleInfoModel {
  OCRInfo toEntity() {
    return OCRInfo(
      vehicleCompany: predictedCarInfo?.companyName,
      codebookName: predictedCarInfo?.codebookName,
      manufacturedYear: predictedCarInfo?.manufacturedYear,
      licensePlate: predictedCarInfo?.registrationNumber,
      serialNumber: predictedCarInfo?.seriNumber,
      vehicleType: predictedCarInfo?.typeValue,
      vehicleMark: predictedCarInfo?.markValue,
      modelCode: predictedCarInfo?.modelCode,
      engineNumber: predictedCarInfo?.engineNumber,
      chassisNumber: predictedCarInfo?.chassisNumber,
      country: predictedCarInfo?.manufacturedYearCountry,
      wheelFormula: predictedCarInfo?.wheelFormula,
      typeOfFuel: predictedCarInfo?.typeOfFuel,
      engineDisplacement: predictedCarInfo?.engineDisplacement,
    );
  }
}
