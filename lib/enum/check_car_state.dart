enum CheckCarState {
  init,

  /// Chỉ có 1 ảnh
  isOneImage,

  /// Sai góc
  invalidCorner,

  /// Cùng 1 xe
  isTheSameCar,

  /// Không cùng 1 xe
  notTheSameCar,

  /// Không phát hiện được ít nhất 1 biển số
  noLicensePlateDetected,

  /// Không có ảnh
  noImage;

  factory CheckCarState.fromId(int id) {
    switch (id) {
      case 0:
        return CheckCarState.init;
      case 1:
        return CheckCarState.isOneImage;
      case 2:
        return CheckCarState.invalidCorner;
      case 4:
        return CheckCarState.notTheSameCar;
      case 3:
        return CheckCarState.isTheSameCar;
      case 5:
        return CheckCarState.noLicensePlateDetected;
      case 6:
        return CheckCarState.noImage;
      default:
        return CheckCarState.init;
    }
  }
}

extension CheckCarStateExtension on CheckCarState {
  int get id => index;
}
