import 'package:equatable/equatable.dart';

class DamageTypeModel extends Equatable {
  final String? damageTypeNameKey;
  final String? damageTypeGuid;
  final String? damageTypeColor;
  final String? createdDate;
  final num? damageTypeId;

  const DamageTypeModel({
    this.damageTypeNameKey,
    this.damageTypeGuid,
    this.damageTypeColor,
    this.createdDate,
    this.damageTypeId,
  });

  factory DamageTypeModel.fromJson(Map<String, dynamic> json) {
    return DamageTypeModel(
      damageTypeNameKey: json['damageTypeNameKey']?.toString(),
      damageTypeGuid: json['damageTypeGuid']?.toString(),
      damageTypeColor: json['damageTypeColor']?.toString(),
      createdDate: json['createdDate']?.toString(),
      damageTypeId: num.tryParse(json['damageTypeId'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        if (damageTypeNameKey != null) 'damageTypeNameKey': damageTypeNameKey,
        if (damageTypeGuid != null) 'damageTypeGuid': damageTypeGuid,
        if (damageTypeColor != null) 'damageTypeColor': damageTypeColor,
        if (createdDate != null) 'createdDate': createdDate,
        if (damageTypeId != null) 'damageTypeId': damageTypeId,
      };

  DamageTypeModel copyWith({
    String? damageTypeNameKey,
    String? damageTypeGuid,
    String? damageTypeColor,
    String? createdDate,
    num? damageTypeId,
  }) {
    return DamageTypeModel(
      damageTypeNameKey: damageTypeNameKey ?? this.damageTypeNameKey,
      damageTypeGuid: damageTypeGuid ?? this.damageTypeGuid,
      damageTypeColor: damageTypeColor ?? this.damageTypeColor,
      createdDate: createdDate ?? this.createdDate,
      damageTypeId: damageTypeId ?? this.damageTypeId,
    );
  }

  @override
  List<Object?> get props {
    return [
      damageTypeNameKey,
      damageTypeGuid,
      damageTypeColor,
      createdDate,
      damageTypeId,
    ];
  }
}
