import 'package:flutter/foundation.dart';

/// Central store for managing validation results.
/// Shared across different pages (HomePage, CameraPage, CarCapturePage...)
/// via `sl.validationVault`
class ValidationVault extends ChangeNotifier {}
