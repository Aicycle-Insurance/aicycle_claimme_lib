import 'package:equatable/equatable.dart';

class Urls extends Equatable {
  final String? fetchUrl;
  final String? uploadUrl;
  final String? filePath;

  const Urls({
    this.fetchUrl,
    this.uploadUrl,
    this.filePath,
  });

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      fetchUrl: json['fetchUrl']?.toString(),
      uploadUrl: json['uploadUrl']?.toString(),
      filePath: json['filePath']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (fetchUrl != null) 'fetchUrl': fetchUrl,
        if (uploadUrl != null) 'uploadUrl': uploadUrl,
        if (filePath != null) 'filePath': filePath,
      };

  Urls copyWith({
    String? fetchUrl,
    String? uploadUrl,
    String? filePath,
  }) {
    return Urls(
      fetchUrl: fetchUrl ?? this.fetchUrl,
      uploadUrl: uploadUrl ?? this.uploadUrl,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  List<Object?> get props {
    return [
      fetchUrl,
      uploadUrl,
      filePath,
    ];
  }
}

class GetUploadUrlResponse extends Equatable {
  final List<Urls>? urls;
  final String? message;
  final String? status;

  const GetUploadUrlResponse({
    this.urls,
    this.message,
    this.status,
  });

  factory GetUploadUrlResponse.fromJson(Map<String, dynamic> json) {
    return GetUploadUrlResponse(
      urls: json['urls'] is List
          ? json['urls'].map<Urls>((e) => Urls.fromJson(e)).toList()
          : null,
      message: json['message']?.toString(),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (urls != null) 'urls': urls,
        if (message != null) 'message': message,
        if (status != null) 'status': status,
      };

  GetUploadUrlResponse copyWith({
    List<Urls>? urls,
    String? message,
    String? status,
  }) {
    return GetUploadUrlResponse(
      urls: urls ?? this.urls,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      urls,
      message,
      status,
    ];
  }
}
