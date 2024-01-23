import 'car_part_direction.dart';

enum CarModelEnum {
  kiaMorning,
  toyotaInnova,
  toyotaCross,
  mazdaCX5,
  toyotaVios,
}

extension CarModelEnumExt on CarModelEnum {
  String imagePath(CarPartDirectionEnum directionEnum) {
    String result = 'assets/images/sedan_front.png';
    switch (this) {
      case CarModelEnum.kiaMorning:
        result = 'assets/images/hatchback_${directionEnum.name}.png';
        break;
      case CarModelEnum.toyotaInnova:
        result = 'assets/images/suv_${directionEnum.name}.png';
        break;
      case CarModelEnum.toyotaCross:
        result = 'assets/images/suv_${directionEnum.name}.png';
        break;
      case CarModelEnum.mazdaCX5:
        result = 'assets/images/suv_${directionEnum.name}.png';
        break;
      case CarModelEnum.toyotaVios:
        result = 'assets/images/sedan_${directionEnum.name}.png';
        break;
    }
    return result;
  }
}
