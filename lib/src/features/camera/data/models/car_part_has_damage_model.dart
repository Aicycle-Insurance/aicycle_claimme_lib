class CarPartHasDamageModel {
  final String? vehiclePartExcelId;
  final String? vehiclePartName;
  final int? totalCloseImages;

  const CarPartHasDamageModel({
    this.vehiclePartExcelId,
    this.vehiclePartName,
    this.totalCloseImages,
  });

  factory CarPartHasDamageModel.fromJson(Map<String, dynamic> json) {
    return CarPartHasDamageModel(
      vehiclePartExcelId: json['vehiclePartExcelId']?.toString(),
      vehiclePartName: json['vehiclePartName']?.toString(),
      totalCloseImages: int.tryParse(json['totalCloseImages'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    if (vehiclePartExcelId != null) 'vehiclePartExcelId': vehiclePartExcelId,
    if (vehiclePartName != null) 'vehiclePartName': vehiclePartName,
    if (totalCloseImages != null) 'totalCloseImages': totalCloseImages,
  };
}
