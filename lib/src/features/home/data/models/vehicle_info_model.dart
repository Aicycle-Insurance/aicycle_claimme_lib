class VehicleInfoModel {
  final String? carCompany;
  final String? carModel;
  final List<int>? carColor;
  final String? plateNumber;
  final String? vinNumber;
  final num? odo;
  final PredictedCarInfo? predictedCarInfo;

  VehicleInfoModel({
    this.carCompany,
    this.carModel,
    this.carColor,
    this.plateNumber,
    this.vinNumber,
    this.odo,
    this.predictedCarInfo,
  });

  factory VehicleInfoModel.fromJson(Map<String, dynamic> json) {
    return VehicleInfoModel(
      carCompany: json['carCompany'],
      carModel: json['carModel'],
      carColor: json['carColor'] != null
          ? List<int>.from(json['carColor'])
          : null,
      plateNumber: json['plateNumber'],
      vinNumber: json['vinNumber'],
      odo: num.tryParse(json['odo']?.toString() ?? ''),
      predictedCarInfo: json['predictedCarInfo'] != null
          ? PredictedCarInfo.fromJson(json['predictedCarInfo'])
          : null,
    );
  }
}

class PredictedCarInfo {
  final String? modelCode;
  final String? manufacturedYear;
  final String? companyName;
  final String? modelName;
  final String? registrationNumber;
  final String? chassisNumber;
  final String? engineNumber;
  final String? vehicleType;
  final String? typeValue;
  final String? markValue;
  final String? overallDimension;
  final String? manufacturedYearCountry;
  final String? engineDisplacement;
  final String? permissiblePersCarried;
  final String? tireInformation;
  final String? typeOfFuel;
  final String? seriNumber;
  final String? wheelFormula;
  final String? codebookName;
  final List<SuggestedVersion>? suggestedVersions;

  PredictedCarInfo({
    this.modelCode,
    this.manufacturedYear,
    this.companyName,
    this.modelName,
    this.registrationNumber,
    this.chassisNumber,
    this.engineNumber,
    this.vehicleType,
    this.typeValue,
    this.markValue,
    this.overallDimension,
    this.manufacturedYearCountry,
    this.engineDisplacement,
    this.permissiblePersCarried,
    this.tireInformation,
    this.typeOfFuel,
    this.seriNumber,
    this.wheelFormula,
    this.codebookName,
    this.suggestedVersions,
  });

  factory PredictedCarInfo.fromJson(Map<String, dynamic> json) {
    return PredictedCarInfo(
      modelCode: json['modelCode'],
      manufacturedYear: json['manufacturedYear'],
      companyName: json['companyName'],
      modelName: json['modelName'],
      registrationNumber: json['registrationNumber'],
      chassisNumber: json['chassisNumber'],
      engineNumber: json['engineNumber'],
      vehicleType: json['vehicleType'],
      typeValue: json['typeValue'],
      markValue: json['markValue'],
      overallDimension: json['overallDimension'],
      manufacturedYearCountry: json['manufacturedYearCountry'],
      engineDisplacement: json['engineDisplacement'],
      permissiblePersCarried: json['permissiblePersCarried'],
      tireInformation: json['tireInformation'],
      typeOfFuel: json['typeOfFuel'],
      seriNumber: json['seriNumber'],
      wheelFormula: json['wheelFormula'],
      codebookName: json['codebookName'],
      suggestedVersions: json['suggestedVersions'] != null
          ? (json['suggestedVersions'] as List)
                .map((v) => SuggestedVersion.fromJson(v))
                .toList()
          : null,
    );
  }
}

class SuggestedVersion {
  final double? score;
  final String? carType;
  final String? carModel;
  final String? carCompany;
  final String? carVersion;
  final String? codebookName;
  final int? manufactureYear;

  SuggestedVersion({
    this.score,
    this.carType,
    this.carModel,
    this.carCompany,
    this.carVersion,
    this.codebookName,
    this.manufactureYear,
  });

  factory SuggestedVersion.fromJson(Map<String, dynamic> json) {
    return SuggestedVersion(
      score: (json['score'] as num?)?.toDouble(),
      carType: json['carType'],
      carModel: json['carModel'],
      carCompany: json['carCompany'],
      carVersion: json['carVersion'],
      codebookName: json['codebookName'],
      manufactureYear: json['manufactureYear'],
    );
  }
}
