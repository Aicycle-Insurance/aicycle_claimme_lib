import 'package:equatable/equatable.dart';

class CarPartHasDamageModel extends Equatable {
  final String? vehiclePartExcelId;
  final String? vehiclePartName;
  final num? totalCloseImages;

  const CarPartHasDamageModel({
    this.vehiclePartExcelId,
    this.vehiclePartName,
    this.totalCloseImages,
  });

  factory CarPartHasDamageModel.fromJson(Map<String, dynamic> json) {
    return CarPartHasDamageModel(
      vehiclePartExcelId: json['vehiclePartExcelId']?.toString(),
      vehiclePartName: json['vehiclePartName']?.toString(),
      totalCloseImages: num.tryParse(json['totalCloseImages'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        if (vehiclePartExcelId != null)
          'vehiclePartExcelId': vehiclePartExcelId,
        if (vehiclePartName != null) 'vehiclePartName': vehiclePartName,
        if (totalCloseImages != null) 'totalCloseImages': totalCloseImages,
      };

  CarPartHasDamageModel copyWith({
    String? vehiclePartExcelId,
    String? vehiclePartName,
    num? totalCloseImages,
  }) {
    return CarPartHasDamageModel(
      vehiclePartExcelId: vehiclePartExcelId ?? this.vehiclePartExcelId,
      vehiclePartName: vehiclePartName ?? this.vehiclePartName,
      totalCloseImages: totalCloseImages ?? this.totalCloseImages,
    );
  }

  @override
  List<Object?> get props {
    return [
      vehiclePartExcelId,
      vehiclePartName,
      totalCloseImages,
    ];
  }
}
