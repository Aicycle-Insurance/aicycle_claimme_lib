class ClaimMeFolderModel {
  final int? claimId;

  ClaimMeFolderModel({this.claimId});

  factory ClaimMeFolderModel.fromJson(Map<String, dynamic> json) {
    return ClaimMeFolderModel(
      claimId: int.tryParse(json['claimId']?.toString() ?? ''),
    );
  }

  /// Parses a response that might be a List or a Map, or wrapped in a 'data' field.
  factory ClaimMeFolderModel.fromDynamic(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('data')) {
      final innerData = data['data'];
      if (innerData is List && innerData.isNotEmpty) {
        return ClaimMeFolderModel.fromJson(
          innerData[0] as Map<String, dynamic>,
        );
      }
      return ClaimMeFolderModel.fromJson(innerData as Map<String, dynamic>);
    }

    if (data is List && data.isNotEmpty) {
      return ClaimMeFolderModel.fromJson(data[0] as Map<String, dynamic>);
    } else if (data is Map<String, dynamic>) {
      return ClaimMeFolderModel.fromJson(data);
    }
    return ClaimMeFolderModel();
  }
}
