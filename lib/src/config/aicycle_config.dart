import 'package:flutter/material.dart';

enum AiCycleEnvironment { develop, stage, production }

enum AiCycleOrg { aicycle, partner, others }

enum AicycleCarAngle {
  /// Góc trước
  front,

  /// Góc trước bên trái
  frontLeft,

  /// Góc trước bên phải
  frontRight,

  /// Góc sau
  rear,

  /// Góc sau bên trái
  rearLeft,

  /// Góc sau bên phải
  rearRight,

  /// Góc sườn trái
  // left,

  /// Góc sườn phải
  // right,

  /// Góc đăng kiểm
  regCert,

  /// Góc ngoại thất - dùng cho capture nhiều góc ngoại thất liên tiếp.
  exterior,
}

/// Map góc xe với tên hiển thị mặc định
const Map<AicycleCarAngle, String> _kDefaultCarAnglesWithDisplayName = {
  AicycleCarAngle.front: 'Trước',
  AicycleCarAngle.frontLeft: 'Trước trái',
  AicycleCarAngle.frontRight: 'Trước phải',
  AicycleCarAngle.rear: 'Sau',
  AicycleCarAngle.rearLeft: 'Sau trái',
  AicycleCarAngle.rearRight: 'Sau phải',
  // AicycleCarAngle.left: 'Sườn trái',
  // AicycleCarAngle.right: 'Sườn phải',
  AicycleCarAngle.regCert: 'Đăng kiểm',
  AicycleCarAngle.exterior: 'Ngoại thất',
};

/// Public configuration for the AiCycle ClaimMe SDK.
class AiCycleConfig {
  /// Thông tin xe
  final CarInformation carInformation;

  /// Cấu hình validation
  final ValidationConfig validationConfig;

  /// Cấu hình chung
  final GeneralConfig generalConfig;

  /// Cấu hình hiển thị
  final DisplayConfig displayConfig;

  const AiCycleConfig({
    required this.generalConfig,
    this.displayConfig = const DisplayConfig(),
    required this.carInformation,
    this.validationConfig = const ValidationConfig(
      missingPartValidation: true,
      sameCarValidation: true,
    ),
  });
}

class GeneralConfig {
  /// Token API
  final String apiToken;

  /// ID của hồ sơ
  final String documentId;

  /// Tên của hồ sơ
  final String? documentName;

  /// Môi trường
  final AiCycleEnvironment environment;

  /// Hiển thị màn hình kết quả
  final bool? showResultScreen;

  /// Cho phép log hay không
  final bool loggingEnabled;

  /// Tổ chức sử dụng SDK
  final AiCycleOrg organization;

  GeneralConfig({
    required this.apiToken,
    required this.documentId,
    required this.organization,
    this.environment = AiCycleEnvironment.develop,
    this.documentName,
    this.showResultScreen = true,
    this.loggingEnabled = false,
  });
}

class CarInformation {
  /// Hãng xe (ví dụ: "toyota")
  final String companyId;

  /// Dòng xe/Hiệu xe (ví dụ: "mazda.bt_50")
  final String modelId;

  /// Năm sản xuất (ví dụ: 2022)
  final int? manufacturingYear;

  /// Phiên bản xe (ví dụ: "luxury_1_9l_4x2_at")
  final String vehicleVersion;

  /// Biển số xe (ví dụ: "30A1983")
  final String licensePlate;

  /// Loại xe (ví dụ: "pickup")
  final String? vehicleType;

  /// Màu xe (nếu có)
  /// Dạng hex #RRGGBB
  final String? color;

  /// ID của garage
  final String garageId;

  /// ID của brand
  final String brandId;

  CarInformation({
    required this.companyId,
    required this.modelId,
    required this.brandId,
    required this.garageId,
    this.manufacturingYear,
    required this.vehicleVersion,
    required this.licensePlate,
    this.vehicleType,
    this.color,
  });
}

class ValidationConfig {
  /// Nếu false thì sẽ không kiểm tra các ảnh có phải cùng 1 xe hay không
  final bool sameCarValidation;

  /// Nếu false thì sẽ không kiểm tra hồ sơ có thiếu bộ phận nào không
  final bool missingPartValidation;

  const ValidationConfig({
    this.sameCarValidation = true,
    this.missingPartValidation = true,
  });
}

class DisplayConfig {
  /// Custom loading widget
  final Widget? loadingWidget;

  /// Danh sách và tên hiển thị của các góc xe.
  /// Mặc định sẽ hiển thị đầy đủ các góc với tên được cấu hình bởi AICycle
  final Map<AicycleCarAngle, String> carAnglesWithDisplayName;

  /// Hiển thị nút back
  final bool showBackButton;

  const DisplayConfig({
    this.loadingWidget,
    this.carAnglesWithDisplayName = _kDefaultCarAnglesWithDisplayName,
    this.showBackButton = false,
  });
}
