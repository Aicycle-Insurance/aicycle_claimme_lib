import '../entities/segment_result.dart';
import '../repositories/home_repository.dart';

class GetDamageStatisticsUseCase {
  final HomeRepository _repository;

  GetDamageStatisticsUseCase(this._repository);

  Future<List<SegmentResult>> call(String claimId) {
    return _repository.getDamageStatistics(claimId);
  }
}
