import 'package:aicycle_claimme_lib/features/aicycle_claim_me/data/model/setting_model.dart';
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? profileId;
  final String? userId;
  final String? firstname;
  final String? lastname;
  final dynamic address;
  final dynamic sex;
  final dynamic assessorId;

  const Profile({
    this.profileId,
    this.userId,
    this.firstname,
    this.lastname,
    this.address,
    this.sex,
    this.assessorId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileId: json['profileId']?.toString(),
      userId: json['userId']?.toString(),
      firstname: json['firstname']?.toString(),
      lastname: json['lastname']?.toString(),
      address: json['address'],
      sex: json['sex'],
      assessorId: json['assessorId'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (profileId != null) 'profileId': profileId,
        if (userId != null) 'userId': userId,
        if (firstname != null) 'firstname': firstname,
        if (lastname != null) 'lastname': lastname,
        if (address != null) 'address': address,
        if (sex != null) 'sex': sex,
        if (assessorId != null) 'assessorId': assessorId,
      };

  Profile copyWith({
    String? profileId,
    String? userId,
    String? firstname,
    String? lastname,
    dynamic address,
    dynamic sex,
    dynamic assessorId,
  }) {
    return Profile(
      profileId: profileId ?? this.profileId,
      userId: userId ?? this.userId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      address: address ?? this.address,
      sex: sex ?? this.sex,
      assessorId: assessorId ?? this.assessorId,
    );
  }

  @override
  List<Object?> get props {
    return [profileId, userId, firstname, lastname, address, sex, assessorId];
  }
}

class Storage extends Equatable {
  final bool? isGenerateUniqueFilePath;

  const Storage({this.isGenerateUniqueFilePath});

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

  Storage copyWith({bool? isGenerateUniqueFilePath}) {
    return Storage(
      isGenerateUniqueFilePath:
          isGenerateUniqueFilePath ?? this.isGenerateUniqueFilePath,
    );
  }

  @override
  List<Object?> get props {
    return [isGenerateUniqueFilePath];
  }
}

class Settings extends Equatable {
  final num? timeTokenExpire;
  final bool? enableApiVersion2;
  final bool? enableSsoAdminUser;
  final bool? enableEngineVinDetection;
  final bool? enableOcrValuation;
  final Storage? storage;
  final bool? disableAssessmentBox;
  final bool? enableRecreateEvent;
  final bool? enableClaimMeClassifyResult;
  final bool? enableCheckSameCarWhenCallEngine;
  final bool? enableInspectionTaploDirection;
  final bool? disableClosePhoto;
  final bool? disableSelectCarShape;

  const Settings({
    this.timeTokenExpire,
    this.enableApiVersion2,
    this.enableSsoAdminUser,
    this.enableEngineVinDetection,
    this.enableOcrValuation,
    this.storage,
    this.disableAssessmentBox,
    this.enableRecreateEvent,
    this.enableClaimMeClassifyResult,
    this.enableCheckSameCarWhenCallEngine,
    this.enableInspectionTaploDirection,
    this.disableClosePhoto,
    this.disableSelectCarShape,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      timeTokenExpire: num.tryParse(json['timeTokenExpire'].toString()),
      enableApiVersion2: json['enableApiVersion2'].toString().contains('true'),
      enableSsoAdminUser: json['enableSsoAdminUser'].toString().contains(
            'true',
          ),
      enableEngineVinDetection:
          json['enableEngineVinDetection'].toString().contains('true'),
      enableOcrValuation: json['enableOcrValuation'].toString().contains(
            'true',
          ),
      storage: json['storage'] == null
          ? null
          : Storage.fromJson(Map<String, dynamic>.from(json['storage'])),
      disableAssessmentBox: json['disableAssessmentBox'].toString().contains(
            'true',
          ),
      enableRecreateEvent: json['enableRecreateEvent'].toString().contains(
            'true',
          ),
      enableClaimMeClassifyResult:
          json['enableClaimMeClassifyResult'].toString().contains('true'),
      enableCheckSameCarWhenCallEngine:
          json['enableCheckSameCarWhenCallEngine'].toString().contains('true'),
      enableInspectionTaploDirection:
          json['enableInspectionTaploDirection'].toString().contains('true'),
      disableClosePhoto: json['disableClosePhoto'].toString().contains('true'),
      disableSelectCarShape:
          json['disableSelectCarShape'].toString().contains('true'),
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
        if (storage != null) 'storage': storage?.toJson(),
        if (disableAssessmentBox != null)
          'disableAssessmentBox': disableAssessmentBox,
        if (enableRecreateEvent != null)
          'enableRecreateEvent': enableRecreateEvent,
        if (enableClaimMeClassifyResult != null)
          'enableClaimMeClassifyResult': enableClaimMeClassifyResult,
        if (enableCheckSameCarWhenCallEngine != null)
          'enableCheckSameCarWhenCallEngine': enableCheckSameCarWhenCallEngine,
        if (enableInspectionTaploDirection != null)
          'enableInspectionTaploDirection': enableInspectionTaploDirection,
        if (disableClosePhoto != null) 'disableClosePhoto': disableClosePhoto,
        if (disableSelectCarShape != null)
          'disableSelectCarShape': disableSelectCarShape,
      };

  Settings copyWith({
    num? timeTokenExpire,
    bool? enableApiVersion2,
    bool? enableSsoAdminUser,
    bool? enableEngineVinDetection,
    bool? enableOcrValuation,
    Storage? storage,
    bool? disableAssessmentBox,
    bool? enableRecreateEvent,
    bool? enableClaimMeClassifyResult,
    bool? enableCheckSameCarWhenCallEngine,
    bool? enableInspectionTaploDirection,
    bool? disableClosePhoto,
    bool? disableSelectCarShape,
  }) {
    return Settings(
      timeTokenExpire: timeTokenExpire ?? this.timeTokenExpire,
      enableApiVersion2: enableApiVersion2 ?? this.enableApiVersion2,
      enableSsoAdminUser: enableSsoAdminUser ?? this.enableSsoAdminUser,
      enableEngineVinDetection:
          enableEngineVinDetection ?? this.enableEngineVinDetection,
      enableOcrValuation: enableOcrValuation ?? this.enableOcrValuation,
      storage: storage ?? this.storage,
      disableAssessmentBox: disableAssessmentBox ?? this.disableAssessmentBox,
      enableRecreateEvent: enableRecreateEvent ?? this.enableRecreateEvent,
      enableClaimMeClassifyResult:
          enableClaimMeClassifyResult ?? this.enableClaimMeClassifyResult,
      enableCheckSameCarWhenCallEngine: enableCheckSameCarWhenCallEngine ??
          this.enableCheckSameCarWhenCallEngine,
      enableInspectionTaploDirection:
          enableInspectionTaploDirection ?? this.enableInspectionTaploDirection,
      disableClosePhoto: disableClosePhoto ?? this.disableClosePhoto,
      disableSelectCarShape:
          disableSelectCarShape ?? this.disableSelectCarShape,
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
      disableAssessmentBox,
      enableRecreateEvent,
      enableClaimMeClassifyResult,
      enableCheckSameCarWhenCallEngine,
      enableInspectionTaploDirection,
      disableClosePhoto,
      disableSelectCarShape,
    ];
  }
}

class CarOption extends Equatable {
  final num? priority;
  final String? optionKey;

  const CarOption({this.priority, this.optionKey});

  factory CarOption.fromJson(Map<String, dynamic> json) {
    return CarOption(
      priority: num.tryParse(json['priority'].toString()),
      optionKey: json['optionKey']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (priority != null) 'priority': priority,
        if (optionKey != null) 'optionKey': optionKey,
      };

  CarOption copyWith({num? priority, String? optionKey}) {
    return CarOption(
      priority: priority ?? this.priority,
      optionKey: optionKey ?? this.optionKey,
    );
  }

  @override
  List<Object?> get props {
    return [priority, optionKey];
  }
}

class DepreciationRate extends Equatable {
  final num? truck;
  final num? specialized;
  final num? coach;

  const DepreciationRate({this.truck, this.specialized, this.coach});

  factory DepreciationRate.fromJson(Map<String, dynamic> json) {
    return DepreciationRate(
      truck: num.tryParse(json['truck'].toString()),
      specialized: num.tryParse(json['specialized'].toString()),
      coach: num.tryParse(json['coach'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        if (truck != null) 'truck': truck,
        if (specialized != null) 'specialized': specialized,
        if (coach != null) 'coach': coach,
      };

  DepreciationRate copyWith({num? truck, num? specialized, num? coach}) {
    return DepreciationRate(
      truck: truck ?? this.truck,
      specialized: specialized ?? this.specialized,
      coach: coach ?? this.coach,
    );
  }

  @override
  List<Object?> get props {
    return [truck, specialized, coach];
  }
}

class ValueMe extends Equatable {
  final num? max;
  final num? min;
  final num? value;
  final bool? disableOcrSuggestion;
  final num? maxListed;
  final num? minListed;
  final num? valueListed;
  final num? maximumRateApplyForMinPrice;
  final List<CarOption>? carOption;
  final num? minPrice;
  final bool? isEnableTrackCodebookChanges;
  final List<String?>? emailsReceive;
  final bool? enabledDailyReport;
  final DepreciationRate? depreciationRate;

  const ValueMe({
    this.max,
    this.min,
    this.value,
    this.disableOcrSuggestion,
    this.maxListed,
    this.minListed,
    this.valueListed,
    this.maximumRateApplyForMinPrice,
    this.carOption,
    this.minPrice,
    this.isEnableTrackCodebookChanges,
    this.emailsReceive,
    this.enabledDailyReport,
    this.depreciationRate,
  });

  factory ValueMe.fromJson(Map<String, dynamic> json) {
    return ValueMe(
      max: num.tryParse(json['max'].toString()),
      min: num.tryParse(json['min'].toString()),
      value: num.tryParse(json['value'].toString()),
      disableOcrSuggestion: json['disableOcrSuggestion'].toString().contains(
            'true',
          ),
      maxListed: num.tryParse(json['maxListed'].toString()),
      minListed: num.tryParse(json['minListed'].toString()),
      valueListed: num.tryParse(json['valueListed'].toString()),
      maximumRateApplyForMinPrice: num.tryParse(
        json['maximumRateApplyForMinPrice'].toString(),
      ),
      carOption: json['carOption'] is List
          ? json['carOption']
              .map<CarOption>(
                (e) => CarOption.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList()
          : null,
      minPrice: num.tryParse(json['minPrice'].toString()),
      isEnableTrackCodebookChanges:
          json['isEnableTrackCodebookChanges'].toString().contains('true'),
      emailsReceive: json['emailsReceive'] is List
          ? json['emailsReceive'].map<String?>((e) => e.toString()).toList()
          : null,
      enabledDailyReport: json['enabledDailyReport'].toString().contains(
            'true',
          ),
      depreciationRate: json['depreciationRate'] == null
          ? null
          : DepreciationRate.fromJson(
              Map<String, dynamic>.from(json['depreciationRate']),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        if (max != null) 'max': max,
        if (min != null) 'min': min,
        if (value != null) 'value': value,
        if (disableOcrSuggestion != null)
          'disableOcrSuggestion': disableOcrSuggestion,
        if (maxListed != null) 'maxListed': maxListed,
        if (minListed != null) 'minListed': minListed,
        if (valueListed != null) 'valueListed': valueListed,
        if (maximumRateApplyForMinPrice != null)
          'maximumRateApplyForMinPrice': maximumRateApplyForMinPrice,
        if (carOption != null)
          'carOption': carOption?.map((e) => e.toJson()).toList(),
        if (minPrice != null) 'minPrice': minPrice,
        if (isEnableTrackCodebookChanges != null)
          'isEnableTrackCodebookChanges': isEnableTrackCodebookChanges,
        if (emailsReceive != null) 'emailsReceive': emailsReceive,
        if (enabledDailyReport != null)
          'enabledDailyReport': enabledDailyReport,
        if (depreciationRate != null)
          'depreciationRate': depreciationRate?.toJson(),
      };

  ValueMe copyWith({
    num? max,
    num? min,
    num? value,
    bool? disableOcrSuggestion,
    num? maxListed,
    num? minListed,
    num? valueListed,
    num? maximumRateApplyForMinPrice,
    List<CarOption>? carOption,
    num? minPrice,
    bool? isEnableTrackCodebookChanges,
    List<String?>? emailsReceive,
    bool? enabledDailyReport,
    DepreciationRate? depreciationRate,
  }) {
    return ValueMe(
      max: max ?? this.max,
      min: min ?? this.min,
      value: value ?? this.value,
      disableOcrSuggestion: disableOcrSuggestion ?? this.disableOcrSuggestion,
      maxListed: maxListed ?? this.maxListed,
      minListed: minListed ?? this.minListed,
      valueListed: valueListed ?? this.valueListed,
      maximumRateApplyForMinPrice:
          maximumRateApplyForMinPrice ?? this.maximumRateApplyForMinPrice,
      carOption: carOption ?? this.carOption,
      minPrice: minPrice ?? this.minPrice,
      isEnableTrackCodebookChanges:
          isEnableTrackCodebookChanges ?? this.isEnableTrackCodebookChanges,
      emailsReceive: emailsReceive ?? this.emailsReceive,
      enabledDailyReport: enabledDailyReport ?? this.enabledDailyReport,
      depreciationRate: depreciationRate ?? this.depreciationRate,
    );
  }

  @override
  List<Object?> get props {
    return [
      max,
      min,
      value,
      disableOcrSuggestion,
      maxListed,
      minListed,
      valueListed,
      maximumRateApplyForMinPrice,
      carOption,
      minPrice,
      isEnableTrackCodebookChanges,
      emailsReceive,
      enabledDailyReport,
      depreciationRate,
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

class Sdk extends Equatable {
  final dynamic bgImage;
  final dynamic bgColor;
  final dynamic customCarImage;
  final List<CarDirections>? carDirections;

  const Sdk({
    this.bgImage,
    this.bgColor,
    this.customCarImage,
    this.carDirections,
  });

  factory Sdk.fromJson(Map<String, dynamic> json) {
    return Sdk(
      bgImage: json['bgImage'],
      bgColor: json['bgColor'],
      customCarImage: json['customCarImage'],
      carDirections: json['carDirections'] is List
          ? json['carDirections']
              .map<CarDirections>(
                (e) => CarDirections.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (bgImage != null) 'bgImage': bgImage,
        if (bgColor != null) 'bgColor': bgColor,
        if (customCarImage != null) 'customCarImage': customCarImage,
        if (carDirections != null)
          'carDirections': carDirections?.map((e) => e.toJson()).toList(),
      };

  Sdk copyWith({
    dynamic bgImage,
    dynamic bgColor,
    dynamic customCarImage,
    List<CarDirections>? carDirections,
  }) {
    return Sdk(
      bgImage: bgImage ?? this.bgImage,
      bgColor: bgColor ?? this.bgColor,
      customCarImage: customCarImage ?? this.customCarImage,
      carDirections: carDirections ?? this.carDirections,
    );
  }

  @override
  List<Object?> get props {
    return [bgImage, bgColor, customCarImage, carDirections];
  }
}

class DirectionRules extends Equatable {
  final List<String?>? directionName;
  final List<String?>? requirePartSlugs;

  const DirectionRules({this.directionName, this.requirePartSlugs});

  factory DirectionRules.fromJson(Map<String, dynamic> json) {
    return DirectionRules(
      directionName: json['directionName'] is List
          ? json['directionName'].map<String?>((e) => e.toString()).toList()
          : null,
      requirePartSlugs: json['requirePartSlugs'] is List
          ? json['requirePartSlugs'].map<String?>((e) => e.toString()).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (directionName != null) 'directionName': directionName,
        if (requirePartSlugs != null) 'requirePartSlugs': requirePartSlugs,
      };

  DirectionRules copyWith({
    List<String?>? directionName,
    List<String?>? requirePartSlugs,
  }) {
    return DirectionRules(
      directionName: directionName ?? this.directionName,
      requirePartSlugs: requirePartSlugs ?? this.requirePartSlugs,
    );
  }

  @override
  List<Object?> get props {
    return [directionName, requirePartSlugs];
  }
}

class BuyMe extends Equatable {
  final List<DirectionRules>? directionRules;

  const BuyMe({this.directionRules});

  factory BuyMe.fromJson(Map<String, dynamic> json) {
    return BuyMe(
      directionRules: json['directionRules'] is List
          ? json['directionRules']
              .map<DirectionRules>(
                (e) => DirectionRules.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (directionRules != null)
          'directionRules': directionRules?.map((e) => e.toJson()).toList(),
      };

  BuyMe copyWith({List<DirectionRules>? directionRules}) {
    return BuyMe(directionRules: directionRules ?? this.directionRules);
  }

  @override
  List<Object?> get props {
    return [directionRules];
  }
}

class Kvp extends Equatable {
  final Settings? settings;
  final ValueMe? valueMe;
  final AICycleClaimMeSetting? sdk;
  final BuyMe? buyMe;

  const Kvp({this.settings, this.valueMe, this.sdk, this.buyMe});

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
              Map<String, dynamic>.from(json['sdk']),
            ),
      buyMe: json['buyMe'] == null
          ? null
          : BuyMe.fromJson(Map<String, dynamic>.from(json['buyMe'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (settings != null) 'settings': settings?.toJson(),
        if (valueMe != null) 'valueMe': valueMe?.toJson(),
        if (sdk != null) 'sdk': sdk?.toJson(),
        if (buyMe != null) 'buyMe': buyMe?.toJson(),
      };

  Kvp copyWith({
    Settings? settings,
    ValueMe? valueMe,
    AICycleClaimMeSetting? sdk,
    BuyMe? buyMe,
  }) {
    return Kvp(
      settings: settings ?? this.settings,
      valueMe: valueMe ?? this.valueMe,
      sdk: sdk ?? this.sdk,
      buyMe: buyMe ?? this.buyMe,
    );
  }

  @override
  List<Object?> get props {
    return [settings, valueMe, sdk, buyMe];
  }
}

class Organizations extends Equatable {
  final String? organizationName;
  final num? organizationId;
  final Kvp? kvp;

  const Organizations({this.organizationName, this.organizationId, this.kvp});

  factory Organizations.fromJson(Map<String, dynamic> json) {
    return Organizations(
      organizationName: json['organizationName']?.toString(),
      organizationId: num.tryParse(json['organizationId'].toString()),
      kvp: json['kvp'] == null
          ? null
          : Kvp.fromJson(Map<String, dynamic>.from(json['kvp'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (organizationName != null) 'organizationName': organizationName,
        if (organizationId != null) 'organizationId': organizationId,
        if (kvp != null) 'kvp': kvp?.toJson(),
      };

  Organizations copyWith({
    String? organizationName,
    num? organizationId,
    Kvp? kvp,
  }) {
    return Organizations(
      organizationName: organizationName ?? this.organizationName,
      organizationId: organizationId ?? this.organizationId,
      kvp: kvp ?? this.kvp,
    );
  }

  @override
  List<Object?> get props {
    return [organizationName, organizationId, kvp];
  }
}

class UserInfo extends Equatable {
  final String? userId;
  final String? userName;
  final String? status;
  final dynamic email;
  final String? phoneNumber;
  final dynamic passwordResetToken;
  final dynamic primaryUname;
  final bool? passwordChangeRequire;
  final dynamic lastLoggedIn;
  final String? passwordLastUpdated;
  final String? dateModified;
  final String? dateCreated;
  final dynamic kvp;
  final dynamic userSetting;
  final Profile? profile;
  final List<dynamic>? userVehicle;
  final List<Organizations>? organizations;
  final dynamic trial;
  final List<num?>? permissionMasks;
  final List<String?>? roleIds;

  const UserInfo({
    this.userId,
    this.userName,
    this.status,
    this.email,
    this.phoneNumber,
    this.passwordResetToken,
    this.primaryUname,
    this.passwordChangeRequire,
    this.lastLoggedIn,
    this.passwordLastUpdated,
    this.dateModified,
    this.dateCreated,
    this.kvp,
    this.userSetting,
    this.profile,
    this.userVehicle,
    this.organizations,
    this.trial,
    this.permissionMasks,
    this.roleIds,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['userId']?.toString(),
      userName: json['userName']?.toString(),
      status: json['status']?.toString(),
      email: json['email'],
      phoneNumber: json['phoneNumber']?.toString(),
      passwordResetToken: json['passwordResetToken'],
      primaryUname: json['primaryUname'],
      passwordChangeRequire: json['passwordChangeRequire'].toString().contains(
            'true',
          ),
      lastLoggedIn: json['lastLoggedIn'],
      passwordLastUpdated: json['passwordLastUpdated']?.toString(),
      dateModified: json['dateModified']?.toString(),
      dateCreated: json['dateCreated']?.toString(),
      kvp: json['kvp'],
      userSetting: json['userSetting'],
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(Map<String, dynamic>.from(json['profile'])),
      userVehicle: json['userVehicle'] is List
          ? json['userVehicle'].map<dynamic>((e) => e).toList()
          : null,
      organizations: json['organizations'] is List
          ? json['organizations']
              .map<Organizations>(
                (e) => Organizations.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList()
          : null,
      trial: json['trial'],
      permissionMasks: json['permissionMasks'] is List
          ? json['permissionMasks']
              .map<num?>((e) => num.tryParse(e.toString()))
              .toList()
          : null,
      roleIds: json['roleIds'] is List
          ? json['roleIds'].map<String?>((e) => e.toString()).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (userId != null) 'userId': userId,
        if (userName != null) 'userName': userName,
        if (status != null) 'status': status,
        if (email != null) 'email': email,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (passwordResetToken != null)
          'passwordResetToken': passwordResetToken,
        if (primaryUname != null) 'primaryUname': primaryUname,
        if (passwordChangeRequire != null)
          'passwordChangeRequire': passwordChangeRequire,
        if (lastLoggedIn != null) 'lastLoggedIn': lastLoggedIn,
        if (passwordLastUpdated != null)
          'passwordLastUpdated': passwordLastUpdated,
        if (dateModified != null) 'dateModified': dateModified,
        if (dateCreated != null) 'dateCreated': dateCreated,
        if (kvp != null) 'kvp': kvp,
        if (userSetting != null) 'userSetting': userSetting,
        if (profile != null) 'profile': profile?.toJson(),
        if (userVehicle != null) 'userVehicle': userVehicle,
        if (organizations != null)
          'organizations': organizations?.map((e) => e.toJson()).toList(),
        if (trial != null) 'trial': trial,
        if (permissionMasks != null) 'permissionMasks': permissionMasks,
        if (roleIds != null) 'roleIds': roleIds,
      };

  UserInfo copyWith({
    String? userId,
    String? userName,
    String? status,
    dynamic email,
    String? phoneNumber,
    dynamic passwordResetToken,
    dynamic primaryUname,
    bool? passwordChangeRequire,
    dynamic lastLoggedIn,
    String? passwordLastUpdated,
    String? dateModified,
    String? dateCreated,
    dynamic kvp,
    dynamic userSetting,
    Profile? profile,
    List<dynamic>? userVehicle,
    List<Organizations>? organizations,
    dynamic trial,
    List<num?>? permissionMasks,
    List<String?>? roleIds,
  }) {
    return UserInfo(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      passwordResetToken: passwordResetToken ?? this.passwordResetToken,
      primaryUname: primaryUname ?? this.primaryUname,
      passwordChangeRequire:
          passwordChangeRequire ?? this.passwordChangeRequire,
      lastLoggedIn: lastLoggedIn ?? this.lastLoggedIn,
      passwordLastUpdated: passwordLastUpdated ?? this.passwordLastUpdated,
      dateModified: dateModified ?? this.dateModified,
      dateCreated: dateCreated ?? this.dateCreated,
      kvp: kvp ?? this.kvp,
      userSetting: userSetting ?? this.userSetting,
      profile: profile ?? this.profile,
      userVehicle: userVehicle ?? this.userVehicle,
      organizations: organizations ?? this.organizations,
      trial: trial ?? this.trial,
      permissionMasks: permissionMasks ?? this.permissionMasks,
      roleIds: roleIds ?? this.roleIds,
    );
  }

  @override
  List<Object?> get props {
    return [
      userId,
      userName,
      status,
      email,
      phoneNumber,
      passwordResetToken,
      primaryUname,
      passwordChangeRequire,
      lastLoggedIn,
      passwordLastUpdated,
      dateModified,
      dateCreated,
      kvp,
      userSetting,
      profile,
      userVehicle,
      organizations,
      trial,
      permissionMasks,
      roleIds,
    ];
  }
}

class Data extends Equatable {
  final String? tokenId;
  final String? tokenName;
  final dynamic kvp;
  final bool? isRevoked;
  final String? organizationId;
  final List<String?>? rights;
  final dynamic dateExpired;
  final String? userId;
  final UserInfo? userInfo;

  const Data({
    this.tokenId,
    this.tokenName,
    this.kvp,
    this.isRevoked,
    this.organizationId,
    this.rights,
    this.dateExpired,
    this.userId,
    this.userInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tokenId: json['tokenId']?.toString(),
      tokenName: json['tokenName']?.toString(),
      kvp: json['kvp'],
      isRevoked: json['isRevoked'].toString().contains('true'),
      organizationId: json['organizationId']?.toString(),
      rights: json['rights'] is List
          ? json['rights'].map<String?>((e) => e.toString()).toList()
          : null,
      dateExpired: json['dateExpired'],
      userId: json['user_id']?.toString(),
      userInfo: json['userInfo'] == null
          ? null
          : UserInfo.fromJson(Map<String, dynamic>.from(json['userInfo'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (tokenId != null) 'tokenId': tokenId,
        if (tokenName != null) 'tokenName': tokenName,
        if (kvp != null) 'kvp': kvp,
        if (isRevoked != null) 'isRevoked': isRevoked,
        if (organizationId != null) 'organizationId': organizationId,
        if (rights != null) 'rights': rights,
        if (dateExpired != null) 'dateExpired': dateExpired,
        if (userId != null) 'userId': userId,
        if (userInfo != null) 'userInfo': userInfo?.toJson(),
      };

  Data copyWith({
    String? tokenId,
    String? tokenName,
    dynamic kvp,
    bool? isRevoked,
    String? organizationId,
    List<String?>? rights,
    dynamic dateExpired,
    String? userId,
    UserInfo? userInfo,
  }) {
    return Data(
      tokenId: tokenId ?? this.tokenId,
      tokenName: tokenName ?? this.tokenName,
      kvp: kvp ?? this.kvp,
      isRevoked: isRevoked ?? this.isRevoked,
      organizationId: organizationId ?? this.organizationId,
      rights: rights ?? this.rights,
      dateExpired: dateExpired ?? this.dateExpired,
      userId: userId ?? this.userId,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object?> get props {
    return [
      tokenId,
      tokenName,
      kvp,
      isRevoked,
      organizationId,
      rights,
      dateExpired,
      userId,
      userInfo,
    ];
  }
}

class UserInfoResponse extends Equatable {
  final String? tokenType;
  final UserInfo? data;

  const UserInfoResponse({this.tokenType, this.data});

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      tokenType: json['tokenType']?.toString(),
      data: json['data'] == null
          ? null
          : UserInfo.fromJson(Map<String, dynamic>.from(json['data'])),
    );
  }

  Map<String, dynamic> toJson() => {
        if (tokenType != null) 'tokenType': tokenType,
        if (data != null) 'data': data?.toJson(),
      };

  UserInfoResponse copyWith({String? tokenType, UserInfo? data}) {
    return UserInfoResponse(
      tokenType: tokenType ?? this.tokenType,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props {
    return [tokenType, data];
  }
}
