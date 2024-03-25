import 'package:dartz/dartz.dart';

import '../../../../network/api_error.dart';
import '../../data/model/user_info_model.dart';
import '../repository/aicycle_claim_me_repository.dart';

class GetUserInfoUsecase {
  final AiCycleClaimMeRepository repository;
  GetUserInfoUsecase(this.repository);

  Future<Either<APIErrors, UserInfo>> call() {
    return repository.getUserInfo();
  }
}
