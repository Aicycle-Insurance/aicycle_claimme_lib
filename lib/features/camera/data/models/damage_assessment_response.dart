import 'package:equatable/equatable.dart';

class ExtraInfor extends Equatable {
  final String? plateNumber;
  final dynamic chassisNumber;
  final String? carCompany;
  final String? carModel;
  final List<num?>? carColor;
  final String? imageDirection;
  final String? imagePosition;
  final String? carShape;

  const ExtraInfor({
    this.plateNumber,
    this.chassisNumber,
    this.carCompany,
    this.carModel,
    this.carColor,
    this.imageDirection,
    this.imagePosition,
    this.carShape,
  });

  factory ExtraInfor.fromJson(Map<String, dynamic> json) {
    return ExtraInfor(
      plateNumber:
          json['plateNumber']?.toString() ?? json['plate_number']?.toString(),
      chassisNumber: json['chassisNumber'] ?? json['chassis_number'],
      carCompany:
          json['carCompany']?.toString() ?? json['car_company']?.toString(),
      carModel: json['carModel']?.toString() ?? json['car_model']?.toString(),
      carColor: (json['carColor'] ?? json['car_color']) is List
          ? (json['carColor'] ?? json['car_color'])
              .map<num?>((e) => num.tryParse(e.toString()))
              .toList()
          : null,
      imageDirection: json['imageDirection']?.toString() ??
          json['image_direction']?.toString(),
      imagePosition: json['imagePosition']?.toString() ??
          json['image_position']?.toString(),
      carShape: json['carShape']?.toString() ?? json['car_shape']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (plateNumber != null) 'plateNumber': plateNumber,
        if (chassisNumber != null) 'chassisNumber': chassisNumber,
        if (carCompany != null) 'carCompany': carCompany,
        if (carModel != null) 'carModel': carModel,
        if (carColor != null) 'carColor': carColor,
        if (imageDirection != null) 'imageDirection': imageDirection,
        if (imagePosition != null) 'imagePosition': imagePosition,
        if (carShape != null) 'carShape': carShape,
      };

  ExtraInfor copyWith({
    String? plateNumber,
    dynamic chassisNumber,
    String? carCompany,
    String? carModel,
    List<num?>? carColor,
    String? imageDirection,
    String? imagePosition,
    String? carShape,
  }) {
    return ExtraInfor(
      plateNumber: plateNumber ?? this.plateNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      carCompany: carCompany ?? this.carCompany,
      carModel: carModel ?? this.carModel,
      carColor: carColor ?? this.carColor,
      imageDirection: imageDirection ?? this.imageDirection,
      imagePosition: imagePosition ?? this.imagePosition,
      carShape: carShape ?? this.carShape,
    );
  }

  @override
  List<Object?> get props {
    return [
      plateNumber,
      chassisNumber,
      carCompany,
      carModel,
      carColor,
      imageDirection,
      imagePosition,
      carShape,
    ];
  }
}

class CarDamage extends Equatable {
  final num? score;
  final List<num?>? box;
  final String? maskPath;
  final bool? isPart;
  final String? maskUrl;
  final String? className;
  final String? damageKey;
  final String? classUuid;

  const CarDamage({
    this.score,
    this.box,
    this.maskPath,
    this.isPart,
    this.maskUrl,
    this.className,
    this.damageKey,
    this.classUuid,
  });

  factory CarDamage.fromJson(Map<String, dynamic> json) {
    return CarDamage(
      score: num.tryParse(json['score'].toString()),
      box: json['box'] is List
          ? json['box']
              .map<num>((e) => num.tryParse(e.toString()) ?? 0)
              .toList()
          : null,
      maskPath: json['maskPath']?.toString() ?? json['mask_path']?.toString(),
      isPart: (json['isPart'] ?? json['is_part'])?.toString().contains('true'),
      maskUrl: json['maskUrl']?.toString() ?? json['mask_url']?.toString(),
      className: json['name']?.toString() ?? json['class']?.toString(),
      damageKey:
          json['damageKey']?.toString() ?? json['damage_key']?.toString(),
      classUuid:
          json['classUuid']?.toString() ?? json['class_uuid']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (score != null) 'score': score,
        if (box != null) 'box': box,
        if (maskPath != null) 'maskPath': maskPath,
        if (isPart != null) 'isPart': isPart,
        if (maskUrl != null) 'maskUrl': maskUrl,
        if (className != null) 'name': className,
        if (damageKey != null) 'damageKey': damageKey,
        if (classUuid != null) 'classUuid': classUuid,
      };

  CarDamage copyWith({
    num? score,
    List<num?>? box,
    String? maskPath,
    bool? isPart,
    String? maskUrl,
    String? className,
    String? damageKey,
    String? classUuid,
  }) {
    return CarDamage(
      score: score ?? this.score,
      box: box ?? this.box,
      maskPath: maskPath ?? this.maskPath,
      isPart: isPart ?? this.isPart,
      maskUrl: maskUrl ?? this.maskUrl,
      className: className ?? this.className,
      damageKey: damageKey ?? this.damageKey,
      classUuid: classUuid ?? this.classUuid,
    );
  }

  @override
  List<Object?> get props {
    return [
      score,
      box,
      maskPath,
      isPart,
      maskUrl,
      className,
      damageKey,
      classUuid,
    ];
  }
}

class Damage extends Equatable {
  final num? score;
  final List<num?>? box;
  final String? maskPath;
  final bool? isPart;
  final num? overlapRate;
  final String? className;
  final String? damageKey;
  final String? damageColor;
  final String? maskUrl;

  final String? classUuid;
  final String? location;
  final int? claimId;
  final String? imageId;
  final bool? isMaskDuplicate;
  final String? damageTypeName;
  final String? damageTypeColor;

  const Damage({
    this.classUuid,
    this.location,
    this.claimId,
    this.imageId,
    this.isMaskDuplicate,
    this.damageTypeName,
    this.damageTypeColor,
    this.score,
    this.box,
    this.maskPath,
    this.isPart,
    this.overlapRate,
    this.className,
    this.damageKey,
    this.damageColor,
    this.maskUrl,
  });

  factory Damage.fromJson(Map<String, dynamic> json) {
    return Damage(
      score: num.tryParse(json['score'].toString()),
      box: json['box'] is List
          ? json['box'].map<num?>((e) => num.tryParse(e.toString())).toList()
          : null,
      maskPath: json['maskPath']?.toString() ?? json['mask_path']?.toString(),
      isPart: (json['isPart'] ?? json['is_part'])?.toString().contains('true'),
      overlapRate: num.tryParse(
        (json['overlapRate'] ?? json['overlap_rate']).toString(),
      ),
      className: json['name']?.toString() ?? json['class']?.toString(),
      damageKey:
          json['damageKey']?.toString() ?? json['damage_key']?.toString(),
      damageColor:
          json['damageColor']?.toString() ?? json['damage_color']?.toString(),
      maskUrl: json['maskUrl']?.toString() ?? json['mask_url']?.toString(),
      claimId: json['claimId'] != null
          ? int.tryParse(json['claimId']!.toString())
          : null,
      classUuid:
          json['classUuid']?.toString() ?? json['class_uuid']?.toString(),
      damageTypeColor: json['damageTypeColor']?.toString() ??
          json['damage_type_color']?.toString(),
      damageTypeName: json['damageTypeName']?.toString() ??
          json['damage_type_name']?.toString(),
      imageId: json['imageId']?.toString(),
      isMaskDuplicate: json['isMaskDuplicate']?.toString().contains('true'),
      location: json['location']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (score != null) 'score': score,
        if (box != null) 'box': box,
        if (maskPath != null) 'maskPath': maskPath,
        if (isPart != null) 'isPart': isPart,
        if (overlapRate != null) 'overlapRate': overlapRate,
        if (className != null) 'name': className,
        if (damageKey != null) 'damageKey': damageKey,
        if (damageColor != null) 'damageColor': damageColor,
        if (maskUrl != null) 'maskUrl': maskUrl,
      };

  Damage copyWith({
    num? score,
    List<num?>? box,
    String? maskPath,
    bool? isPart,
    num? overlapRate,
    String? className,
    String? damageKey,
    String? damageColor,
    String? maskUrl,
    String? classUuid,
    String? location,
    int? claimId,
    String? imageId,
    bool? isMaskDuplicate,
    String? damageTypeName,
    String? damageTypeColor,
  }) {
    return Damage(
      score: score ?? this.score,
      box: box ?? this.box,
      maskPath: maskPath ?? this.maskPath,
      isPart: isPart ?? this.isPart,
      overlapRate: overlapRate ?? this.overlapRate,
      className: className ?? this.className,
      damageKey: damageKey ?? this.damageKey,
      damageColor: damageColor ?? this.damageColor,
      maskUrl: maskUrl ?? this.maskUrl,
      claimId: claimId ?? this.claimId,
      classUuid: classUuid ?? this.classUuid,
      damageTypeColor: damageTypeColor ?? this.damageTypeColor,
      damageTypeName: damageTypeName ?? this.damageTypeName,
      imageId: imageId ?? this.imageId,
      isMaskDuplicate: isMaskDuplicate ?? this.isMaskDuplicate,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props {
    return [
      score,
      box,
      maskPath,
      isPart,
      overlapRate,
      className,
      damageKey,
      damageColor,
      maskUrl,
    ];
  }
}

class CarParts extends Equatable {
  final num? score;
  final List<num?>? box;
  final String? maskPath;
  final bool? isPart;
  final String? partDirection;
  final List<Damage>? damages;
  final String? carPartKey;
  final String? className;
  final String? maskColor;
  final String? position;
  final String? maskUrl;
  final String? classUuid;
  final String? location;
  final String? carPartName;
  final String? rawLocation;
  final String? carPartColor;

  const CarParts({
    this.classUuid,
    this.location,
    this.carPartName,
    this.rawLocation,
    this.carPartColor,
    this.score,
    this.box,
    this.maskPath,
    this.isPart,
    this.partDirection,
    this.damages,
    this.carPartKey,
    this.className,
    this.maskColor,
    this.position,
    this.maskUrl,
  });

  factory CarParts.fromJson(Map<String, dynamic> json) {
    return CarParts(
      score: num.tryParse(json['score'].toString()),
      box: json['box'] is List
          ? json['box'].map<num?>((e) => num.tryParse(e.toString())).toList()
          : null,
      maskPath: json['maskPath']?.toString() ?? json['mask_path']?.toString(),
      isPart: (json['isPart'] ?? json['is_part'])?.toString().contains('true'),
      partDirection: json['partDirection']?.toString() ??
          json['part_direction']?.toString(),
      damages: json['damages'] is List
          ? json['damages'].map<Damage>((e) => Damage.fromJson(e)).toList()
          : null,
      carPartKey:
          json['carPartKey']?.toString() ?? json['car_part_key']?.toString(),
      className: json['name']?.toString() ?? json['class']?.toString(),
      maskColor:
          json['maskColor']?.toString() ?? json['mask_color']?.toString(),
      position: json['position']?.toString(),
      maskUrl: json['maskUrl']?.toString() ?? json['mask_url']?.toString(),
      carPartColor: json['carPartColor']?.toString() ??
          json['car_part_color']?.toString(),
      carPartName:
          json['carPartName']?.toString() ?? json['car_part_name']?.toString(),
      classUuid:
          json['classUuid']?.toString() ?? json['class_uuid']?.toString(),
      location: json['location']?.toString(),
      rawLocation:
          json['rawLocation']?.toString() ?? json['raw_location']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (score != null) 'score': score,
        if (box != null) 'box': box,
        if (maskPath != null) 'maskPath': maskPath,
        if (isPart != null) 'isPart': isPart,
        if (partDirection != null) 'partDirection': partDirection,
        if (damages != null) 'damages': damages,
        if (carPartKey != null) 'carPartKey': carPartKey,
        if (className != null) 'name': className,
        if (maskColor != null) 'maskColor': maskColor,
        if (position != null) 'position': position,
        if (maskUrl != null) 'maskUrl': maskUrl,
      };

  CarParts copyWith({
    num? score,
    List<num?>? box,
    String? maskPath,
    bool? isPart,
    String? partDirection,
    List<Damage>? damages,
    String? carPartKey,
    String? className,
    String? maskColor,
    String? position,
    String? maskUrl,
    String? classUuid,
    String? location,
    String? carPartName,
    String? rawLocation,
    String? carPartColor,
  }) {
    return CarParts(
      score: score ?? this.score,
      box: box ?? this.box,
      maskPath: maskPath ?? this.maskPath,
      isPart: isPart ?? this.isPart,
      partDirection: partDirection ?? this.partDirection,
      damages: damages ?? this.damages,
      carPartKey: carPartKey ?? this.carPartKey,
      className: className ?? this.className,
      maskColor: maskColor ?? this.maskColor,
      position: position ?? this.position,
      maskUrl: maskUrl ?? this.maskUrl,
      carPartColor: carPartColor ?? this.carPartColor,
      carPartName: carPartName ?? this.carPartName,
      classUuid: classUuid ?? this.classUuid,
      location: location ?? this.location,
      rawLocation: rawLocation ?? this.rawLocation,
    );
  }

  @override
  List<Object?> get props {
    return [
      score,
      box,
      maskPath,
      isPart,
      partDirection,
      damages,
      carPartKey,
      className,
      maskColor,
      position,
      maskUrl,
      location,
      rawLocation,
      carPartColor,
      carPartName,
      classUuid,
    ];
  }
}

class DamageAssessmentModel extends Equatable {
  final List<int?>? imgSize;
  final String? imgUrl;
  final String? imgDrawName;
  final String? imgDrawUrl;
  final ExtraInfor? extraInfor;
  final List<CarDamage>? carDamages;
  final List<CarParts>? carParts;

  const DamageAssessmentModel({
    this.imgSize,
    this.imgUrl,
    this.imgDrawName,
    this.imgDrawUrl,
    this.extraInfor,
    this.carDamages,
    this.carParts,
  });

  factory DamageAssessmentModel.fromJson(Map<String, dynamic> json) {
    return DamageAssessmentModel(
      imgSize: (json['imgSize'] ?? json['img_size']) is List
          ? (json['imgSize'] ?? json['img_size'])
              .map<int?>((e) => int.tryParse(e.toString()))
              .toList()
          : null,
      imgUrl: json['imgUrl']?.toString() ?? json['img_url']?.toString(),
      imgDrawName:
          json['imgDrawName']?.toString() ?? json['img_draw_name']?.toString(),
      imgDrawUrl:
          json['imgDrawUrl']?.toString() ?? json['img_draw_url']?.toString(),
      extraInfor: json['extraInfor'] != null
          ? ExtraInfor.fromJson(Map<String, dynamic>.from(json['extraInfor']))
          : json['extra_infor'] != null
              ? ExtraInfor.fromJson(
                  Map<String, dynamic>.from(json['extra_infor']),
                )
              : null,
      carDamages: (json['damages'] ?? json['car_damages']) is List
          ? (json['damages'] ?? json['car_damages'])
              .map<CarDamage>((e) => CarDamage.fromJson(e))
              .toList()
          : null,
      carParts: (json['carParts'] ?? json['car_parts']) is List
          ? (json['carParts'] ?? json['car_parts'])
              .map<CarParts>((e) => CarParts.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (imgSize != null) 'imgSize': imgSize,
        if (imgUrl != null) 'imgUrl': imgUrl,
        if (imgDrawName != null) 'imgDrawName': imgDrawName,
        if (imgDrawUrl != null) 'imgDrawUrl': imgDrawUrl,
        if (extraInfor != null) 'extraInfor': extraInfor,
        if (carDamages != null) 'damages': carDamages,
        if (carParts != null) 'carParts': carParts,
      };

  DamageAssessmentModel copyWith({
    List<int?>? imgSize,
    String? imgUrl,
    String? imgDrawName,
    String? imgDrawUrl,
    ExtraInfor? extraInfor,
    List<CarDamage>? carDamages,
    List<CarParts>? carParts,
  }) {
    return DamageAssessmentModel(
      imgSize: imgSize ?? this.imgSize,
      imgUrl: imgUrl ?? this.imgUrl,
      imgDrawName: imgDrawName ?? this.imgDrawName,
      imgDrawUrl: imgDrawUrl ?? this.imgDrawUrl,
      extraInfor: extraInfor ?? this.extraInfor,
      carDamages: carDamages ?? this.carDamages,
      carParts: carParts ?? this.carParts,
    );
  }

  @override
  List<Object?> get props {
    return [
      imgSize,
      imgUrl,
      imgDrawName,
      imgDrawUrl,
      extraInfor,
      carDamages,
      carParts,
    ];
  }
}

class DamageAssessmentResponse extends Equatable {
  final String? status;
  final bool? isPhotoValid;
  final String? traceId;
  final num? errorCodeFromEngine;
  final String? message;
  final num? imageId;
  final DamageAssessmentModel? result;

  const DamageAssessmentResponse({
    this.status,
    this.isPhotoValid,
    this.traceId,
    this.errorCodeFromEngine,
    this.message,
    this.imageId,
    this.result,
  });

  factory DamageAssessmentResponse.fromJson(Map<String, dynamic> json) {
    return DamageAssessmentResponse(
      status: json['status']?.toString(),
      isPhotoValid: json['isPhotoValid']?.toString().contains('true'),
      traceId: json['traceId']?.toString(),
      errorCodeFromEngine: num.tryParse(json['errorCodeFromEngine'].toString()),
      message: json['message']?.toString(),
      imageId: num.tryParse(json['imageId'].toString()),
      result: json['result'] == null
          ? null
          : json['result'] is List
              ? json['result'][0] != null
                  ? DamageAssessmentModel.fromJson(
                      Map<String, dynamic>.from(json['result'][0]),
                    )
                  : null
              : DamageAssessmentModel.fromJson(
                  Map<String, dynamic>.from(json['result']),
                ),
    );
  }

  Map<String, dynamic> toJson() => {
        if (status != null) 'status': status,
        if (isPhotoValid != null) 'isPhotoValid': isPhotoValid,
        if (traceId != null) 'traceId': traceId,
        if (errorCodeFromEngine != null)
          'errorCodeFromEngine': errorCodeFromEngine,
        if (message != null) 'message': message,
        if (imageId != null) 'imageId': imageId,
        if (result != null) 'result': result,
      };

  DamageAssessmentResponse copyWith({
    String? status,
    bool? isPhotoValid,
    String? traceId,
    num? errorCodeFromEngine,
    String? message,
    num? imageId,
    DamageAssessmentModel? result,
  }) {
    return DamageAssessmentResponse(
      status: status ?? this.status,
      isPhotoValid: isPhotoValid ?? this.isPhotoValid,
      traceId: traceId ?? this.traceId,
      errorCodeFromEngine: errorCodeFromEngine ?? this.errorCodeFromEngine,
      message: message ?? this.message,
      imageId: imageId ?? this.imageId,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      isPhotoValid,
      traceId,
      errorCodeFromEngine,
      message,
      imageId,
      result,
    ];
  }
}
