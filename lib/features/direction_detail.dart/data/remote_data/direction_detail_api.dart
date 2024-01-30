import '../../../../network/api_request.dart';
import '../../../../network/endpoints.dart';

class DirectionDetailAPI extends APIRequest {
  /// v1
  DirectionDetailAPI.getDirectionImageV1({
    int? currentPage,
    int? pageSize,
    int? rangeId,
    int? partDirectionId,
    required String claimId,
  }) : super(
          endpoint:
              Endpoint.getDirectionImageV1.replaceAll("{claimId}", claimId),
          method: HTTPMethod.get,
          isLogResponse: false,
          query: {
            if (currentPage != null) "currentPage": currentPage.toString(),
            if (pageSize != null) "pageSize": pageSize.toString(),
            if (rangeId != null) "rangeId": rangeId.toString(),
            if (partDirectionId != null)
              "partDirectionId": partDirectionId.toString(),
          },
        );

  /// v2
  DirectionDetailAPI.getDirectionImageV2({
    int? offset,
    int? limit,
    String? direction,
    String? position,
    required String claimId,
  }) : super(
          endpoint:
              Endpoint.getDirectionImageV2.replaceAll("{claimId}", claimId),
          method: HTTPMethod.get,
          isLogResponse: false,
          query: {
            if (offset != null) "offset": offset.toString(),
            if (limit != null) "limit": limit.toString(),
            if (position != null) "position": position,
            if (direction != null) "direction": direction,
          },
        );

  ///
  DirectionDetailAPI.deleteAllImage({
    int? partDirectionId,
    required String claimId,
  }) : super(
          endpoint: Endpoint.deleteAllImage.replaceAll("{claimId}", claimId),
          method: HTTPMethod.delete,
          query: {
            if (partDirectionId != null)
              "partDirectionId": partDirectionId.toString(),
          },
        );

  ///
  DirectionDetailAPI.deleteImageById({
    required String imageId,
  }) : super(
          endpoint: Endpoint.deleteImageById.replaceAll("{imageId}", imageId),
          method: HTTPMethod.delete,
        );

  ///
  DirectionDetailAPI.getCarPartHasDamage({
    required String claimId,
    required String directionId,
  }) : super(
          endpoint:
              Endpoint.getCarPartHasDamage.replaceAll("{claimId}", claimId),
          method: HTTPMethod.get,
          isLogResponse: true,
          query: {"directionId": directionId},
        );
}
