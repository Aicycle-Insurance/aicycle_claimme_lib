import '../../core/network/dio_client.dart';
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
}

/// Global instance for accessing dependencies.
final sl = AiCycleInjection();
