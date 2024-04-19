import 'package:aicycle_claimme_lib/features/aicycle_claim_me/data/model/setting_model.dart';
import 'package:equatable/equatable.dart';

class Kvp extends Equatable {
  final Settings? settings;
  final ValueMe? valueMe;
  final AICycleClaimMeSetting? sdk;

  const Kvp({
    this.settings,
    this.valueMe,
    this.sdk,
  });

  factory Kvp.fromJson(Map<String, dynamic> json) {
    return Kvp(
      settings: json['settings'] == null
          ? null
          : Settings.fromJson(Map<String, dynamic>.from(json['settings'])),
      valueMe: json['valueMe'] == null
          ? null
          : ValueMe.fromJson(Map<String, dynamic>.from(json['valueMe'])),
      sdk: json['sdk'] == null
          ? null
          : AICycleClaimMeSetting.fromJson(
              Map<String, dynamic>.from(json['sdk'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (settings != null) 'settings': settings,
        if (valueMe != null) 'valueMe': valueMe,
        if (sdk != null) 'sdk': sdk,
      };

  Kvp copyWith({
    Settings? settings,
    ValueMe? valueMe,
    AICycleClaimMeSetting? sdk,
  }) {
    return Kvp(
      settings: settings ?? this.settings,
      valueMe: valueMe ?? this.valueMe,
      sdk: sdk ?? this.sdk,
    );
  }

  @override
  List<Object?> get props {
    return [
      settings,
      valueMe,
      sdk,
    ];
  }
}

class Settings extends Equatable {
  final num? timeTokenExpire;
  final bool? enableApiVersion2;
  final bool? enableSsoAdminUser;
  final bool? enableEngineVinDetection;
  final bool? enableOcrValuation;
  final Storage? storage;
  final bool? enableResizeImage;
  final bool? validatePlateNumber;
  final bool? enableValidateEnoughDirection;

  const Settings({
    this.timeTokenExpire,
    this.enableApiVersion2,
    this.enableSsoAdminUser,
    this.enableEngineVinDetection,
    this.enableOcrValuation,
    this.storage,
    this.enableResizeImage,
    this.validatePlateNumber,
    this.enableValidateEnoughDirection,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      timeTokenExpire: num.tryParse(json['timeTokenExpire'].toString()),
      enableApiVersion2: json['enableApiVersion2'].toString().contains('true'),
      enableSsoAdminUser:
          json['enableSsoAdminUser'].toString().contains('true'),
      enableEngineVinDetection:
          json['enableEngineVinDetection'].toString().contains('true'),
      enableOcrValuation:
          json['enableOcrValuation'].toString().contains('true'),
      storage: json['storage'] == null
          ? null
          : Storage.fromJson(Map<String, dynamic>.from(json['storage'])),
      enableResizeImage: json['enableResizeImage'].toString().contains('true'),
      validatePlateNumber:
          json['validatePlateNumber'].toString().contains('true'),
      enableValidateEnoughDirection:
          json['enableValidateEnoughDirection'].toString().contains('true'),
    );
  }

  Map<String, dynamic> toJson() => {
        if (timeTokenExpire != null) 'timeTokenExpire': timeTokenExpire,
        if (enableApiVersion2 != null) 'enableApiVersion2': enableApiVersion2,
        if (enableSsoAdminUser != null)
          'enableSsoAdminUser': enableSsoAdminUser,
        if (enableEngineVinDetection != null)
          'enableEngineVinDetection': enableEngineVinDetection,
        if (enableOcrValuation != null)
          'enableOcrValuation': enableOcrValuation,
        if (storage != null) 'storage': storage,
        if (enableResizeImage != null) 'enableResizeImage': enableResizeImage,
        if (validatePlateNumber != null)
          'validatePlateNumber': validatePlateNumber,
        if (enableValidateEnoughDirection != null)
          'enableValidateEnoughDirection': enableValidateEnoughDirection,
      };

  Settings copyWith({
    num? timeTokenExpire,
    bool? enableApiVersion2,
    bool? enableSsoAdminUser,
    bool? enableEngineVinDetection,
    bool? enableOcrValuation,
    Storage? storage,
    bool? enableResizeImage,
    bool? validatePlateNumber,
    bool? enableValidateEnoughDirection,
  }) {
    return Settings(
      timeTokenExpire: timeTokenExpire ?? this.timeTokenExpire,
      enableApiVersion2: enableApiVersion2 ?? this.enableApiVersion2,
      enableSsoAdminUser: enableSsoAdminUser ?? this.enableSsoAdminUser,
      enableEngineVinDetection:
          enableEngineVinDetection ?? this.enableEngineVinDetection,
      enableOcrValuation: enableOcrValuation ?? this.enableOcrValuation,
      storage: storage ?? this.storage,
      enableResizeImage: enableResizeImage ?? this.enableResizeImage,
      validatePlateNumber: validatePlateNumber ?? this.validatePlateNumber,
      enableValidateEnoughDirection:
          enableValidateEnoughDirection ?? this.enableValidateEnoughDirection,
    );
  }

  @override
  List<Object?> get props {
    return [
      timeTokenExpire,
      enableApiVersion2,
      enableSsoAdminUser,
      enableEngineVinDetection,
      enableOcrValuation,
      storage,
      enableResizeImage,
      validatePlateNumber,
      enableValidateEnoughDirection,
    ];
  }
}

class CarFuel extends Equatable {
  final num? priority;
  final String? carFuelKey;

  const CarFuel({
    this.priority,
    this.carFuelKey,
  });

  factory CarFuel.fromJson(Map<String, dynamic> json) {
    return CarFuel(
      priority: num.tryParse(json['priority'].toString()),
      carFuelKey: json['carFuelKey']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (priority != null) 'priority': priority,
        if (carFuelKey != null) 'carFuelKey': carFuelKey,
      };

  CarFuel copyWith({
    num? priority,
    String? carFuelKey,
  }) {
    return CarFuel(
      priority: priority ?? this.priority,
      carFuelKey: carFuelKey ?? this.carFuelKey,
    );
  }

  @override
  List<Object?> get props {
    return [
      priority,
      carFuelKey,
    ];
  }
}

class Storage extends Equatable {
  final bool? isGenerateUniqueFilePath;

  const Storage({
    this.isGenerateUniqueFilePath,
  });

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      isGenerateUniqueFilePath:
          json['isGenerateUniqueFilePath'].toString().contains('true'),
    );
  }

  Map<String, dynamic> toJson() => {
        if (isGenerateUniqueFilePath != null)
          'isGenerateUniqueFilePath': isGenerateUniqueFilePath,
      };

  Storage copyWith({
    bool? isGenerateUniqueFilePath,
  }) {
    return Storage(
      isGenerateUniqueFilePath:
          isGenerateUniqueFilePath ?? this.isGenerateUniqueFilePath,
    );
  }

  @override
  List<Object?> get props {
    return [
      isGenerateUniqueFilePath,
    ];
  }
}

class ValueMe extends Equatable {
  final num? max;
  final num? min;
  final num? value;
  final bool? disableOcrSuggestion;
  final List<CarFuel>? carFuel;
  final num? minPrice;
  final num? maxListed;
  final num? minListed;
  final num? valueListed;
  final num? maximumRateApplyForMinPrice;

  const ValueMe({
    this.max,
    this.min,
    this.value,
    this.disableOcrSuggestion,
    this.carFuel,
    this.minPrice,
    this.maxListed,
    this.minListed,
    this.valueListed,
    this.maximumRateApplyForMinPrice,
  });

  factory ValueMe.fromJson(Map<String, dynamic> json) {
    return ValueMe(
      max: num.tryParse(json['max'].toString()),
      min: num.tryParse(json['min'].toString()),
      value: num.tryParse(json['value'].toString()),
      disableOcrSuggestion:
          json['disableOcrSuggestion'].toString().contains('true'),
      carFuel: json['carFuel'] is List
          ? json['carFuel'].map<CarFuel>((e) => CarFuel.fromJson(e)).toList()
          : null,
      minPrice: num.tryParse(json['minPrice'].toString()),
      maxListed: num.tryParse(json['maxListed'].toString()),
      minListed: num.tryParse(json['minListed'].toString()),
      valueListed: num.tryParse(json['valueListed'].toString()),
      maximumRateApplyForMinPrice:
          num.tryParse(json['maximumRateApplyForMinPrice'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        if (max != null) 'max': max,
        if (min != null) 'min': min,
        if (value != null) 'value': value,
        if (disableOcrSuggestion != null)
          'disableOcrSuggestion': disableOcrSuggestion,
        if (carFuel != null) 'carFuel': carFuel,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxListed != null) 'maxListed': maxListed,
        if (minListed != null) 'minListed': minListed,
        if (valueListed != null) 'valueListed': valueListed,
        if (maximumRateApplyForMinPrice != null)
          'maximumRateApplyForMinPrice': maximumRateApplyForMinPrice,
      };

  ValueMe copyWith({
    num? max,
    num? min,
    num? value,
    bool? disableOcrSuggestion,
    List<CarFuel>? carFuel,
    num? minPrice,
    num? maxListed,
    num? minListed,
    num? valueListed,
    num? maximumRateApplyForMinPrice,
  }) {
    return ValueMe(
      max: max ?? this.max,
      min: min ?? this.min,
      value: value ?? this.value,
      disableOcrSuggestion: disableOcrSuggestion ?? this.disableOcrSuggestion,
      carFuel: carFuel ?? this.carFuel,
      minPrice: minPrice ?? this.minPrice,
      maxListed: maxListed ?? this.maxListed,
      minListed: minListed ?? this.minListed,
      valueListed: valueListed ?? this.valueListed,
      maximumRateApplyForMinPrice:
          maximumRateApplyForMinPrice ?? this.maximumRateApplyForMinPrice,
    );
  }

  @override
  List<Object?> get props {
    return [
      max,
      min,
      value,
      disableOcrSuggestion,
      carFuel,
      minPrice,
      maxListed,
      minListed,
      valueListed,
      maximumRateApplyForMinPrice,
    ];
  }
}

class CarDirections extends Equatable {
  final String? directionSlug;
  final String? directionName;
  final num? width;
  final num? height;
  final num? borderRadius;
  final bool? isDefault;

  const CarDirections({
    this.directionSlug,
    this.directionName,
    this.width,
    this.height,
    this.borderRadius,
    this.isDefault,
  });

  factory CarDirections.fromJson(Map<String, dynamic> json) {
    return CarDirections(
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

  CarDirections copyWith({
    String? directionSlug,
    String? directionName,
    num? width,
    num? height,
    num? borderRadius,
    bool? isDefault,
  }) {
    return CarDirections(
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
