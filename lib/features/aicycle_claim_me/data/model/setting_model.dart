import 'package:equatable/equatable.dart';

class CarDirectionSetting extends Equatable {
  final String? directionSlug;
  final String? directionName;
  final num? width;
  final num? height;
  final num? borderRadius;
  final bool? isDefault;

  const CarDirectionSetting({
    this.directionSlug,
    this.directionName,
    this.width,
    this.height,
    this.borderRadius,
    this.isDefault,
  });

  factory CarDirectionSetting.fromJson(Map<String, dynamic> json) {
    return CarDirectionSetting(
      directionSlug: json['directionSlug']?.toString(),
      directionName: json['directionName']?.toString(),
      width: num.tryParse(json['width'].toString()),
      height: num.tryParse(json['height'].toString()),
      borderRadius: num.tryParse(json['borderRadius'].toString()),
      isDefault: json['isDefault'].toString().contains('true'),
    );
  }

  Map<String, dynamic> toJson() => {
        if (directionSlug != null) 'directionSlug': directionSlug,
        if (directionName != null) 'directionName': directionName,
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (borderRadius != null) 'borderRadius': borderRadius,
        if (isDefault != null) 'isDefault': isDefault,
      };

  CarDirectionSetting copyWith({
    String? directionSlug,
    String? directionName,
    num? width,
    num? height,
    num? borderRadius,
    bool? isDefault,
  }) {
    return CarDirectionSetting(
      directionSlug: directionSlug ?? this.directionSlug,
      directionName: directionName ?? this.directionName,
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props {
    return [
      directionSlug,
      directionName,
      width,
      height,
      borderRadius,
      isDefault,
    ];
  }
}

class AICycleClaimMeSetting extends Equatable {
  final String? bgImage;
  final String? bgColor;
  final String? customCarImage;
  final List<CarDirectionSetting>? carDirections;

  const AICycleClaimMeSetting({
    this.bgImage,
    this.bgColor,
    this.customCarImage,
    this.carDirections,
  });

  factory AICycleClaimMeSetting.fromJson(Map<String, dynamic> json) {
    return AICycleClaimMeSetting(
      bgImage: json['bgImage']?.toString(),
      bgColor: json['bgColor']?.toString(),
      customCarImage: json['customCarImage']?.toString(),
      carDirections: json['carDirections'] is List
          ? json['carDirections']
              .map<CarDirectionSetting>((e) => CarDirectionSetting.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (bgImage != null) 'bgImage': bgImage,
        if (bgColor != null) 'bgColor': bgColor,
        if (customCarImage != null) 'customCarImage': customCarImage,
        if (carDirections != null) 'carDirections': carDirections,
      };

  AICycleClaimMeSetting copyWith({
    String? bgImage,
    String? bgColor,
    String? customCarImage,
    List<CarDirectionSetting>? carDirections,
  }) {
    return AICycleClaimMeSetting(
      bgImage: bgImage ?? this.bgImage,
      bgColor: bgColor ?? this.bgColor,
      customCarImage: customCarImage ?? this.customCarImage,
      carDirections: carDirections ?? this.carDirections,
    );
  }

  @override
  List<Object?> get props {
    return [
      bgImage,
      bgColor,
      customCarImage,
      carDirections,
    ];
  }
}
