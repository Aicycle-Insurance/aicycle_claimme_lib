import 'package:equatable/equatable.dart';

class ImageDirectionModel extends Equatable {
  final String? directionName;
  final String? directionSlug;
  final num? totalImage;
  final num? directionId;
  final String? thumbnail;

  const ImageDirectionModel({
    this.directionName,
    this.directionSlug,
    this.totalImage,
    this.directionId,
    this.thumbnail,
  });

  factory ImageDirectionModel.fromJson(Map<String, dynamic> json) {
    return ImageDirectionModel(
      directionName: json['directionName']?.toString(),
      directionSlug: json['directionSlug']?.toString(),
      totalImage: num.tryParse(json['totalImage'].toString()),
      directionId: num.tryParse(json['directionId'].toString()),
      thumbnail: json['thumbnail']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (directionName != null) 'directionName': directionName,
        if (directionSlug != null) 'directionSlug': directionSlug,
        if (totalImage != null) 'totalImage': totalImage,
        if (directionId != null) 'directionId': directionId,
        if (thumbnail != null) 'thumbnail': thumbnail,
      };

  ImageDirectionModel copyWith({
    String? directionName,
    String? directionSlug,
    num? totalImage,
    num? directionId,
    String? thumbnail,
  }) {
    return ImageDirectionModel(
      directionName: directionName ?? this.directionName,
      directionSlug: directionSlug ?? this.directionSlug,
      totalImage: totalImage ?? this.totalImage,
      directionId: directionId ?? this.directionId,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props {
    return [
      directionName,
      directionSlug,
      totalImage,
      directionId,
      thumbnail,
    ];
  }
}
