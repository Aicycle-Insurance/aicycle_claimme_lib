import 'package:equatable/equatable.dart';

class ImageUploadResponse extends Equatable {
  final bool? claimImageIsValid;
  final String? filePath;
  final String? imageUrl;
  final String? message;
  final String? level;

  const ImageUploadResponse({
    this.claimImageIsValid,
    this.filePath,
    this.imageUrl,
    this.message,
    this.level,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponse(
      claimImageIsValid: json['claimImageIsValid'].toString().contains('true'),
      filePath: json['filePath']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      message: json['message']?.toString(),
      level: json['level']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (claimImageIsValid != null) 'claimImageIsValid': claimImageIsValid,
        if (filePath != null) 'filePath': filePath,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (message != null) 'message': message,
        if (level != null) 'level': level,
      };

  ImageUploadResponse copyWith({
    bool? claimImageIsValid,
    String? filePath,
    String? imageUrl,
    String? message,
    String? level,
  }) {
    return ImageUploadResponse(
      claimImageIsValid: claimImageIsValid ?? this.claimImageIsValid,
      filePath: filePath ?? this.filePath,
      imageUrl: imageUrl ?? this.imageUrl,
      message: message ?? this.message,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props {
    return [
      claimImageIsValid,
      filePath,
      imageUrl,
      message,
      level,
    ];
  }
}
