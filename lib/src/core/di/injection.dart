import '../../core/network/dio_client.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/create_buyme_folder_use_case.dart';
import '../../features/home/domain/usecases/delete_image_use_case.dart';
import '../../features/home/domain/usecases/get_directional_image_use_case.dart';
import '../../features/home/presentation/controller/validation_vault.dart';
import '../../features/home/presentation/controller/vehicle_image_vault.dart';
import '../utils/logger.dart';

/// Centralized dependency injection for the AiCycle SDK.
/// This class manages the instantiation of all core components,
/// ensuring that implementation details are hidden from the presentation layer.
class AiCycleInjection {
  AiCycleInjection._();

  static final AiCycleInjection _instance = AiCycleInjection._();
  factory AiCycleInjection() => _instance;

  // --- Core ---
  late final LoggerService logger = LoggerService();
  late final DioClient _dioClient = DioClient(logger);
  late final VehicleImageVault vehicleImageVault = VehicleImageVault(
    deleteImageUseCase,
    getDirectionalImagesUseCase,
  );
  late final ValidationVault validationVault = ValidationVault();

  // --- Data Sources ---
  late final HomeRemoteDataSource homeRemoteDataSource =
      HomeRemoteDataSourceImpl(_dioClient);

  // --- Repositories ---
  late final HomeRepository homeRepository = HomeRepositoryImpl(
    homeRemoteDataSource,
  );

  // --- Use Cases ---
  late final CreateBuyMeFolderUseCase createBuyMeFolderUseCase =
      CreateBuyMeFolderUseCase(homeRepository);
  late final DeleteImageUseCase deleteImageUseCase = DeleteImageUseCase(
    homeRepository,
  );
  late final GetDirectionalImagesUseCase getDirectionalImagesUseCase =
      GetDirectionalImagesUseCase(homeRepository);
}

/// Global instance for accessing dependencies.
final sl = AiCycleInjection();
