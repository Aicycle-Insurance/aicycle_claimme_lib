class OCRInfo {
  /// Hãng xe
  final String? vehicleCompany;

  /// Hiệu xe - phiên bản = codebookName
  final String? codebookName;

  /// Năm sản xuất
  final String? manufacturedYear;

  /// Biển số xe
  final String? licensePlate;

  /// Số quản lý
  final String? serialNumber;

  /// Loại phương tiện
  final String? vehicleType;

  /// Nhãn hiệu xe
  final String? vehicleMark;

  /// Số loại
  final String? modelCode;

  /// Số máy
  final String? engineNumber;

  /// Số khung
  final String? chassisNumber;

  /// Quốc gia
  final String? country;

  /// Công thức bánh xe
  final String? wheelFormula;

  /// Loại nhiên liệu
  final String? typeOfFuel;

  /// Dung tích động cơ
  final String? engineDisplacement;

  OCRInfo({
    required this.vehicleCompany,
    required this.codebookName,
    required this.manufacturedYear,
    required this.licensePlate,
    required this.serialNumber,
    required this.vehicleType,
    required this.vehicleMark,
    required this.modelCode,
    required this.engineNumber,
    required this.chassisNumber,
    required this.country,
    required this.wheelFormula,
    required this.typeOfFuel,
    required this.engineDisplacement,
  });
}
