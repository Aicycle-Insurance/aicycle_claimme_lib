import '../features/aicycle_claim_me/presentation/aicycle_claim_me.dart';
import 'api_provider.dart';
import 'endpoints.dart';

enum HTTPMethod { get, post, delete, put, patch }

class APIRequest {
  String baseUrl = environtment == Evn.production
      ? BaseEndpoint.baseUrl
      : environtment == Evn.stage
          ? BaseEndpoint.stageBaseUrl
          : BaseEndpoint.devBaseUrl;
  String endpoint;
  String contentType;
  HTTPMethod method;
  bool isLogResponse;
  bool isBaseResponse;
  bool isMultiLanguage;
  Map<String, String>? headers;
  Map<String, String>? query;
  dynamic body;

  APIRequest({
    required this.endpoint,
    this.method = HTTPMethod.get,
    Map<String, String>? headers,
    this.query = const {},
    this.body,
    this.contentType = "application/json",
    this.isLogResponse = false,
    String? baseUrl,
    this.isBaseResponse = true,
    this.isMultiLanguage = true,
  }) {
    String langCode = 'vi';
    switch (locale?.languageCode) {
      case "en":
        langCode = 'en';
        break;
      case "vi":
        langCode = 'vi';
        break;
      case "ja":
        langCode = 'jp';
        break;
    }
    final baseHeaders = {
      if (apiToken != null) 'Authorization': "Bearer $apiToken",
      if (isMultiLanguage) "lang": langCode,
    };
    this.headers = baseHeaders;
    this.headers?.addAll(headers ?? {});
    if (baseUrl != null) {
      this.baseUrl = baseUrl;
    }
  }

  Future request() => APIProvider.instance.request(this);
}
