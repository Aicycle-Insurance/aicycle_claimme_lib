import '../../domain/entities/car_part_has_damage.dart';
import '../models/car_part_has_damage_model.dart';

extension CarPartHasDamageMapper on CarPartHasDamageModel {
  CarPartHasDamage toEntity() {
    return CarPartHasDamage(
      vehiclePartExcelId: vehiclePartExcelId,
      vehiclePartName: vehiclePartName,
      totalCloseImages: totalCloseImages,
    );
  }
}
