import 'package:equatable/equatable.dart';

class PartsMasks extends Equatable {
  final String? masksPath;
  final List<num?>? boxes;
  final String? vehiclePartName;
  final String? vehicleColor;
  final num? scores;
  final String? location;
  final num? imageId;
  final String? vehiclePartExcelId;
  final String? maskUrl;
  final bool? isPart;

  const PartsMasks({
    this.masksPath,
    this.boxes,
    this.vehiclePartName,
    this.vehicleColor,
    this.scores,
    this.location,
    this.imageId,
    this.vehiclePartExcelId,
    this.maskUrl,
    this.isPart,
  });

  factory PartsMasks.fromJson(Map<String, dynamic> json) {
    return PartsMasks(
      masksPath: json['masksPath']?.toString(),
      boxes: json['boxes'] is List
          ? json['boxes'].map<num?>((e) => num.tryParse(e.toString())).toList()
          : null,
      vehiclePartName: json['vehiclePartName']?.toString(),
      vehicleColor: json['vehicleColor']?.toString(),
      scores: num.tryParse(json['scores'].toString()),
      location: json['location']?.toString(),
      imageId: num.tryParse(json['imageId'].toString()),
      vehiclePartExcelId: json['vehiclePartExcelId']?.toString(),
      maskUrl: json['maskUrl']?.toString(),
      isPart: json['isPart'].toString().contains('true'),
    );
  }

  Map<String, dynamic> toJson() => {
        if (masksPath != null) 'masksPath': masksPath,
        if (boxes != null) 'boxes': boxes,
        if (vehiclePartName != null) 'vehiclePartName': vehiclePartName,
        if (vehicleColor != null) 'vehicleColor': vehicleColor,
        if (scores != null) 'scores': scores,
        if (location != null) 'location': location,
        if (imageId != null) 'imageId': imageId,
        if (vehiclePartExcelId != null)
          'vehiclePartExcelId': vehiclePartExcelId,
        if (maskUrl != null) 'maskUrl': maskUrl,
        if (isPart != null) 'isPart': isPart,
      };

  PartsMasks copyWith({
    String? masksPath,
    List<num?>? boxes,
    String? vehiclePartName,
    String? vehicleColor,
    num? scores,
    String? location,
    num? imageId,
    String? vehiclePartExcelId,
    String? maskUrl,
    bool? isPart,
  }) {
    return PartsMasks(
      masksPath: masksPath ?? this.masksPath,
      boxes: boxes ?? this.boxes,
      vehiclePartName: vehiclePartName ?? this.vehiclePartName,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      scores: scores ?? this.scores,
      location: location ?? this.location,
      imageId: imageId ?? this.imageId,
      vehiclePartExcelId: vehiclePartExcelId ?? this.vehiclePartExcelId,
      maskUrl: maskUrl ?? this.maskUrl,
      isPart: isPart ?? this.isPart,
    );
  }

  @override
  List<Object?> get props {
    return [
      masksPath,
      boxes,
      vehiclePartName,
      vehicleColor,
      scores,
      location,
      imageId,
      vehiclePartExcelId,
      maskUrl,
      isPart,
    ];
  }
}

class DamagePart extends Equatable {
  final String? vehiclePartName;
  final String? vehiclePartExcelId;

  const DamagePart({
    this.vehiclePartName,
    this.vehiclePartExcelId,
  });

  factory DamagePart.fromJson(Map<String, dynamic> json) {
    return DamagePart(
      vehiclePartName: json['vehiclePartName']?.toString(),
      vehiclePartExcelId: json['vehiclePartExcelId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (vehiclePartName != null) 'vehiclePartName': vehiclePartName,
        if (vehiclePartExcelId != null)
          'vehiclePartExcelId': vehiclePartExcelId,
      };

  DamagePart copyWith({
    String? vehiclePartName,
    String? vehiclePartExcelId,
  }) {
    return DamagePart(
      vehiclePartName: vehiclePartName ?? this.vehiclePartName,
      vehiclePartExcelId: vehiclePartExcelId ?? this.vehiclePartExcelId,
    );
  }

  @override
  List<Object?> get props {
    return [
      vehiclePartName,
      vehiclePartExcelId,
    ];
  }
}

class DamageMasks extends Equatable {
  final String? maskPath;
  final String? maskUrl;
  final String? vehiclePartName;
  final String? damageTypeUuid;
  final String? damageTypeName;
  final String? damageTypeColor;
  final List<num?>? boxes;
  final bool? isPart;
  final bool? userCreated;

  const DamageMasks({
    this.maskPath,
    this.maskUrl,
    this.vehiclePartName,
    this.damageTypeUuid,
    this.damageTypeName,
    this.damageTypeColor,
    this.boxes,
    this.isPart,
    this.userCreated,
  });

  factory DamageMasks.fromJson(Map<String, dynamic> json) {
    return DamageMasks(
      maskPath: json['maskPath']?.toString(),
      maskUrl: json['maskUrl']?.toString(),
      vehiclePartName: json['vehiclePartName']?.toString(),
      damageTypeUuid: json['damageTypeUuid']?.toString(),
      damageTypeName: json['damageTypeName']?.toString(),
      damageTypeColor: json['damageTypeColor']?.toString(),
      boxes: json['boxes'] is List
          ? json['boxes'].map<num?>((e) => num.tryParse(e.toString())).toList()
          : null,
      isPart: json['isPart'].toString().contains('true'),
      userCreated: json['userCreated'].toString().contains('true'),
    );
  }

  Map<String, dynamic> toJson() => {
        if (maskPath != null) 'maskPath': maskPath,
        if (maskUrl != null) 'maskUrl': maskUrl,
        if (vehiclePartName != null) 'vehiclePartName': vehiclePartName,
        if (damageTypeUuid != null) 'damageTypeUuid': damageTypeUuid,
        if (damageTypeName != null) 'damageTypeName': damageTypeName,
        if (damageTypeColor != null) 'damageTypeColor': damageTypeColor,
        if (boxes != null) 'boxes': boxes,
        if (isPart != null) 'isPart': isPart,
        if (userCreated != null) 'userCreated': userCreated,
      };

  DamageMasks copyWith({
    String? maskPath,
    String? maskUrl,
    String? vehiclePartName,
    String? damageTypeUuid,
    String? damageTypeName,
    String? damageTypeColor,
    List<num?>? boxes,
    bool? isPart,
    bool? userCreated,
  }) {
    return DamageMasks(
      maskPath: maskPath ?? this.maskPath,
      maskUrl: maskUrl ?? this.maskUrl,
      vehiclePartName: vehiclePartName ?? this.vehiclePartName,
      damageTypeUuid: damageTypeUuid ?? this.damageTypeUuid,
      damageTypeName: damageTypeName ?? this.damageTypeName,
      damageTypeColor: damageTypeColor ?? this.damageTypeColor,
      boxes: boxes ?? this.boxes,
      isPart: isPart ?? this.isPart,
      userCreated: userCreated ?? this.userCreated,
    );
  }

  @override
  List<Object?> get props {
    return [
      maskPath,
      maskUrl,
      vehiclePartName,
      damageTypeUuid,
      damageTypeName,
      damageTypeColor,
      boxes,
      isPart,
      userCreated,
    ];
  }
}

class DamageDetail extends Equatable {
  final String? filePath;
  final String? url;
  final String? damageTypeName;
  final String? damageTypeColor;
  final String? damageUuid;
  final List<num?>? boxes;
  final num? damageArea;
  final num? damagePercentage;
  final num? damageId;
  final num? imageDuplicateId;
  final num? parentClaimId;
  final num? damageDuplicateId;

  const DamageDetail({
    this.filePath,
    this.url,
    this.damageTypeName,
    this.damageTypeColor,
    this.damageUuid,
    this.boxes,
    this.damageArea,
    this.damagePercentage,
    this.damageId,
    this.imageDuplicateId,
    this.parentClaimId,
    this.damageDuplicateId,
  });

  factory DamageDetail.fromJson(Map<String, dynamic> json) {
    return DamageDetail(
      filePath: json['filePath']?.toString(),
      url: json['url']?.toString(),
      damageTypeName: json['damageTypeName']?.toString(),
      damageTypeColor: json['damageTypeColor']?.toString(),
      damageUuid: json['damageUuid']?.toString(),
      boxes: json['boxes'] is List
          ? json['boxes'].map<num?>((e) => num.tryParse(e.toString())).toList()
          : null,
      damageArea: num.tryParse(json['damageArea'].toString()),
      damagePercentage: num.tryParse(json['damagePercentage'].toString()),
      damageId: num.tryParse(json['damageId'].toString()),
      imageDuplicateId: num.tryParse(json['imageDuplicateId'].toString()),
      parentClaimId: num.tryParse(json['parentClaimId'].toString()),
      damageDuplicateId: num.tryParse(json['damageDuplicateId'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        if (filePath != null) 'filePath': filePath,
        if (url != null) 'url': url,
        if (damageTypeName != null) 'damageTypeName': damageTypeName,
        if (damageTypeColor != null) 'damageTypeColor': damageTypeColor,
        if (damageUuid != null) 'damageUuid': damageUuid,
        if (boxes != null) 'boxes': boxes,
        if (damageArea != null) 'damageArea': damageArea,
        if (damagePercentage != null) 'damagePercentage': damagePercentage,
        if (damageId != null) 'damageId': damageId,
        if (imageDuplicateId != null) 'imageDuplicateId': imageDuplicateId,
        if (parentClaimId != null) 'parentClaimId': parentClaimId,
        if (damageDuplicateId != null) 'damageDuplicateId': damageDuplicateId,
      };

  DamageDetail copyWith({
    String? filePath,
    String? url,
    String? damageTypeName,
    String? damageTypeColor,
    String? damageUuid,
    List<num?>? boxes,
    num? damageArea,
    num? damagePercentage,
    num? damageId,
    num? imageDuplicateId,
    num? parentClaimId,
    num? damageDuplicateId,
  }) {
    return DamageDetail(
      filePath: filePath ?? this.filePath,
      url: url ?? this.url,
      damageTypeName: damageTypeName ?? this.damageTypeName,
      damageTypeColor: damageTypeColor ?? this.damageTypeColor,
      damageUuid: damageUuid ?? this.damageUuid,
      boxes: boxes ?? this.boxes,
      damageArea: damageArea ?? this.damageArea,
      damagePercentage: damagePercentage ?? this.damagePercentage,
      damageId: damageId ?? this.damageId,
      imageDuplicateId: imageDuplicateId ?? this.imageDuplicateId,
      parentClaimId: parentClaimId ?? this.parentClaimId,
      damageDuplicateId: damageDuplicateId ?? this.damageDuplicateId,
    );
  }

  @override
  List<Object?> get props {
    return [
      filePath,
      url,
      damageTypeName,
      damageTypeColor,
      damageUuid,
      boxes,
      damageArea,
      damagePercentage,
      damageId,
      imageDuplicateId,
      parentClaimId,
      damageDuplicateId,
    ];
  }
}

class DamageInfo extends Equatable {
  final String? vehiclePartName;
  final String? vehiclePartExcelId;
  final num? price;
  final num? laborCost;
  final num? totalCost;
  final String? repairPlan;
  final num? area;
  final String? location;
  final List<DamageDetail>? damageDetail;

  const DamageInfo({
    this.vehiclePartName,
    this.vehiclePartExcelId,
    this.price,
    this.laborCost,
    this.totalCost,
    this.repairPlan,
    this.area,
    this.location,
    this.damageDetail,
  });

  factory DamageInfo.fromJson(Map<String, dynamic> json) {
    return DamageInfo(
      vehiclePartName: json['vehiclePartName']?.toString(),
      vehiclePartExcelId: json['vehiclePartExcelId']?.toString(),
      price: num.tryParse(json['price'].toString()),
      laborCost: num.tryParse(json['laborCost'].toString()),
      totalCost: num.tryParse(json['totalCost'].toString()),
      repairPlan: json['repairPlan']?.toString(),
      area: num.tryParse(json['area'].toString()),
      location: json['location']?.toString(),
      damageDetail: json['damageDetail'] is List
          ? json['damageDetail']
              .map<DamageDetail>((e) => DamageDetail.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (vehiclePartName != null) 'vehiclePartName': vehiclePartName,
        if (vehiclePartExcelId != null)
          'vehiclePartExcelId': vehiclePartExcelId,
        if (price != null) 'price': price,
        if (laborCost != null) 'laborCost': laborCost,
        if (totalCost != null) 'totalCost': totalCost,
        if (repairPlan != null) 'repairPlan': repairPlan,
        if (area != null) 'area': area,
        if (location != null) 'location': location,
        if (damageDetail != null) 'damageDetail': damageDetail,
      };

  DamageInfo copyWith({
    String? vehiclePartName,
    String? vehiclePartExcelId,
    num? price,
    num? laborCost,
    num? totalCost,
    String? repairPlan,
    num? area,
    String? location,
    List<DamageDetail>? damageDetail,
  }) {
    return DamageInfo(
      vehiclePartName: vehiclePartName ?? this.vehiclePartName,
      vehiclePartExcelId: vehiclePartExcelId ?? this.vehiclePartExcelId,
      price: price ?? this.price,
      laborCost: laborCost ?? this.laborCost,
      totalCost: totalCost ?? this.totalCost,
      repairPlan: repairPlan ?? this.repairPlan,
      area: area ?? this.area,
      location: location ?? this.location,
      damageDetail: damageDetail ?? this.damageDetail,
    );
  }

  @override
  List<Object?> get props {
    return [
      vehiclePartName,
      vehiclePartExcelId,
      price,
      laborCost,
      totalCost,
      repairPlan,
      area,
      location,
      damageDetail,
    ];
  }
}

class ClaimImageModel extends Equatable {
  final String? imageName;
  final String? imageId;
  final String? claimId;
  final String? url;
  final String? imageUrl;
  final String? resizePath;
  final List<num?>? imageSize;
  final String? imageRange;
  final bool? damageExist;
  final String? directionName;
  final String? imageRangeName;
  final String? location;
  final String? requestedTime;
  final String? uploadedTime;
  final String? uploadLocation;
  final num? timeProcess;
  final num? timeAppUpload;
  final String? errorNote;
  final List<dynamic>? errorType;
  final String? imageRangeId;
  final String? filePath;
  final String? traceId;
  final String? processStatus;
  final List<PartsMasks>? partsMasks;
  final List<DamagePart>? damagePart;
  final List<DamageMasks>? damageMasks;
  final List<DamageInfo>? damageInfo;

  const ClaimImageModel({
    this.imageName,
    this.imageId,
    this.claimId,
    this.url,
    this.imageUrl,
    this.resizePath,
    this.imageSize,
    this.imageRange,
    this.damageExist,
    this.directionName,
    this.imageRangeName,
    this.location,
    this.requestedTime,
    this.uploadedTime,
    this.uploadLocation,
    this.timeProcess,
    this.timeAppUpload,
    this.errorNote,
    this.errorType,
    this.imageRangeId,
    this.filePath,
    this.traceId,
    this.processStatus,
    this.partsMasks,
    this.damagePart,
    this.damageMasks,
    this.damageInfo,
  });

  factory ClaimImageModel.fromJson(Map<String, dynamic> json) {
    return ClaimImageModel(
      imageName: json['imageName']?.toString(),
      imageId: json['imageId']?.toString(),
      claimId: json['claimId']?.toString(),
      url: json['url']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      resizePath: json['resizePath']?.toString(),
      imageSize: json['imageSize'] is List
          ? json['imageSize']
              .map<num?>((e) => num.tryParse(e.toString()))
              .toList()
          : null,
      imageRange: json['imageRange']?.toString(),
      damageExist: json['damageExist'].toString().contains('true'),
      directionName: json['directionName']?.toString(),
      imageRangeName: json['imageRangeName']?.toString(),
      location: json['location']?.toString(),
      requestedTime: json['requestedTime']?.toString(),
      uploadedTime: json['uploadedTime']?.toString(),
      uploadLocation: json['uploadLocation']?.toString(),
      timeProcess: num.tryParse(json['timeProcess'].toString()),
      timeAppUpload: num.tryParse(json['timeAppUpload'].toString()),
      errorNote: json['errorNote']?.toString(),
      errorType: json['errorType'] is List
          ? json['errorType'].map<dynamic>((e) => e).toList()
          : null,
      imageRangeId: json['imageRangeId']?.toString(),
      filePath: json['filePath']?.toString(),
      traceId: json['traceId']?.toString(),
      processStatus: json['processStatus']?.toString(),
      partsMasks: json['partsMasks'] is List
          ? json['partsMasks']
              .map<PartsMasks>((e) => PartsMasks.fromJson(e))
              .toList()
          : null,
      damagePart: json['damagePart'] is List
          ? json['damagePart']
              .map<DamagePart>((e) => DamagePart.fromJson(e))
              .toList()
          : null,
      damageMasks: json['damageMasks'] is List
          ? json['damageMasks']
              .map<DamageMasks>((e) => DamageMasks.fromJson(e))
              .toList()
          : null,
      damageInfo: json['damageInfo'] is List
          ? json['damageInfo']
              .map<DamageInfo>((e) => DamageInfo.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (imageName != null) 'imageName': imageName,
        if (imageId != null) 'imageId': imageId,
        if (claimId != null) 'claimId': claimId,
        if (url != null) 'url': url,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (resizePath != null) 'resizePath': resizePath,
        if (imageSize != null) 'imageSize': imageSize,
        if (imageRange != null) 'imageRange': imageRange,
        if (damageExist != null) 'damageExist': damageExist,
        if (directionName != null) 'directionName': directionName,
        if (imageRangeName != null) 'imageRangeName': imageRangeName,
        if (location != null) 'location': location,
        if (requestedTime != null) 'requestedTime': requestedTime,
        if (uploadedTime != null) 'uploadedTime': uploadedTime,
        if (uploadLocation != null) 'uploadLocation': uploadLocation,
        if (timeProcess != null) 'timeProcess': timeProcess,
        if (timeAppUpload != null) 'timeAppUpload': timeAppUpload,
        if (errorNote != null) 'errorNote': errorNote,
        if (errorType != null) 'errorType': errorType,
        if (imageRangeId != null) 'imageRangeId': imageRangeId,
        if (filePath != null) 'filePath': filePath,
        if (traceId != null) 'traceId': traceId,
        if (processStatus != null) 'processStatus': processStatus,
        if (partsMasks != null) 'partsMasks': partsMasks,
        if (damagePart != null) 'damagePart': damagePart,
        if (damageMasks != null) 'damageMasks': damageMasks,
        if (damageInfo != null) 'damageInfo': damageInfo,
      };

  ClaimImageModel copyWith({
    String? imageName,
    String? imageId,
    String? claimId,
    String? url,
    String? imageUrl,
    String? resizePath,
    List<num?>? imageSize,
    String? imageRange,
    bool? damageExist,
    String? directionName,
    String? imageRangeName,
    String? location,
    String? requestedTime,
    String? uploadedTime,
    String? uploadLocation,
    num? timeProcess,
    num? timeAppUpload,
    String? errorNote,
    List<dynamic>? errorType,
    String? imageRangeId,
    String? filePath,
    String? traceId,
    String? processStatus,
    List<PartsMasks>? partsMasks,
    List<DamagePart>? damagePart,
    List<DamageMasks>? damageMasks,
    List<DamageInfo>? damageInfo,
  }) {
    return ClaimImageModel(
      imageName: imageName ?? this.imageName,
      imageId: imageId ?? this.imageId,
      claimId: claimId ?? this.claimId,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      resizePath: resizePath ?? this.resizePath,
      imageSize: imageSize ?? this.imageSize,
      imageRange: imageRange ?? this.imageRange,
      damageExist: damageExist ?? this.damageExist,
      directionName: directionName ?? this.directionName,
      imageRangeName: imageRangeName ?? this.imageRangeName,
      location: location ?? this.location,
      requestedTime: requestedTime ?? this.requestedTime,
      uploadedTime: uploadedTime ?? this.uploadedTime,
      uploadLocation: uploadLocation ?? this.uploadLocation,
      timeProcess: timeProcess ?? this.timeProcess,
      timeAppUpload: timeAppUpload ?? this.timeAppUpload,
      errorNote: errorNote ?? this.errorNote,
      errorType: errorType ?? this.errorType,
      imageRangeId: imageRangeId ?? this.imageRangeId,
      filePath: filePath ?? this.filePath,
      traceId: traceId ?? this.traceId,
      processStatus: processStatus ?? this.processStatus,
      partsMasks: partsMasks ?? this.partsMasks,
      damagePart: damagePart ?? this.damagePart,
      damageMasks: damageMasks ?? this.damageMasks,
      damageInfo: damageInfo ?? this.damageInfo,
    );
  }

  @override
  List<Object?> get props {
    return [
      imageName,
      imageId,
      claimId,
      url,
      imageUrl,
      resizePath,
      imageSize,
      imageRange,
      damageExist,
      directionName,
      imageRangeName,
      location,
      requestedTime,
      uploadedTime,
      uploadLocation,
      timeProcess,
      timeAppUpload,
      errorNote,
      errorType,
      imageRangeId,
      filePath,
      traceId,
      processStatus,
      partsMasks,
      damagePart,
      damageMasks,
      damageInfo,
    ];
  }
}
