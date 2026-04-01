import '../../core/network/dio_client.dart';
import '../../features/camera/data/data_source/image_remote_data_source.dart';
import '../../features/camera/data/repositories/image_repository_impl.dart';
import '../../features/camera/domain/repositories/image_respository.dart';
import '../../features/camera/domain/usecases/upload_image_use_case.dart';
import '../../features/camera/domain/usecases/upload_vehicle_inspection_use_case.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/create_claimme_folder_use_case.dart';
import '../../features/home/domain/usecases/delete_image_use_case.dart';
import '../../features/home/domain/usecases/get_directional_image_use_case.dart';
import '../../features/home/domain/usecases/get_vehicle_info_use_case.dart';
import '../../features/home/domain/usecases/validate_vehicle_angle_use_case.dart';
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
  late final ValidationVault validationVault = ValidationVault(
    validateVehicleAngleUseCase,
  );

  // --- Data Sources ---
  late final HomeRemoteDataSource homeRemoteDataSource =
      HomeRemoteDataSourceImpl(_dioClient);

  late final ImageRemoteDataSource imageRemoteDataSource =
      ImageRemoteDataSourceImpl(_dioClient);

  // --- Repositories ---
  late final HomeRepository homeRepository = HomeRepositoryImpl(
    homeRemoteDataSource,
  );

  late final ImageRepository imageRepository = ImageRepositoryImpl(
    imageRemoteDataSource,
  );

  // --- Use Cases ---
  late final CreateClaimMeFolderUseCase createClaimMeFolderUseCase =
      CreateClaimMeFolderUseCase(homeRepository);
  late final DeleteImageUseCase deleteImageUseCase = DeleteImageUseCase(
    homeRepository,
  );
  late final GetDirectionalImagesUseCase getDirectionalImagesUseCase =
      GetDirectionalImagesUseCase(homeRepository);

  late final UploadVehicleInspectionUseCase uploadVehicleInspectionUseCase =
      UploadVehicleInspectionUseCase(imageRepository);

  late final UploadImageUseCase uploadImageUseCase = UploadImageUseCase(
    imageRepository,
  );

  late final ValidateVehicleAngleUseCase validateVehicleAngleUseCase =
      ValidateVehicleAngleUseCase(homeRepository);

  late final GetVehicleInfoUseCase getVehicleInfoUseCase =
      GetVehicleInfoUseCase(homeRepository);
}

/// Global instance for accessing dependencies.
final sl = AiCycleInjection();
