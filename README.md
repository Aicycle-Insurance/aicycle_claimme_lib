# Getting started

### 1. Requirements

- Flutter: ">=1.17.0"
- Dart: "^3.11.1"

### 2. Add dependency

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  aicycle_claimme_plus: ^latest_version
```

### 3. Platform Setup

#### iOS

Add the following keys to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture vehicle photos for AI inspection.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to upload vehicle photos.</string>
```

#### Android

Ensure your `minSdkVersion` is at least **21** in `android/app/build.gradle`.

## Usage

### Simple Implementation

```dart
import 'package:aicycle_claimme_plus/aicycle_claimme_plus.dart';

// ... inside your widget ...

ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AicycleClaimMe(
          aiCycleConfig: AiCycleConfig(
            generalConfig: GeneralConfig(
              apiToken: 'YOUR_API_TOKEN',
              documentId: 'YOUR_CLAIM_ID', // e.g., Claim number or Job ID
              organization: AiCycleOrg.aicycle,
              environment: AiCycleEnvironment.stage,
            ),
            carInformation: CarInformation(
              companyId: 'toyota',
              modelId: 'corolla',
              brandId: 'brand_id',
              garageId: 'garage_id',
              vehicleVersion: 'v1.0',
              licensePlate: '30A12345',
            ),
          ),
          onComplete: (data) {
            print('Inspection completed: $data');
            // 'data' contains 'damageStatistics' with full AI results
          },
          onError: (error) {
            print('Error: $error');
          },
        ),
      ),
    );
  },
  child: const Text('Start AI Inspection'),
)
```

## Configuration Reference

The `AiCycleConfig` class consists of four main configuration sections:

### 1. GeneralConfig

Core settings for API access and SDK behavior.

| Property           | Type                 | Default   | Description                                          |
| :----------------- | :------------------- | :-------- | :--------------------------------------------------- |
| `apiToken`         | `String`             | Required  | Your AiCycle API token.                              |
| `documentId`       | `String`             | Required  | Unique ID for the inspection (External ID).          |
| `organization`     | `AiCycleOrg`         | Required  | `AiCycleOrg.aicycle`, `partner`, or `others`.        |
| `environment`      | `AiCycleEnvironment` | `develop` | `develop`, `stage`, or `production`.                 |
| `documentName`     | `String?`            | `null`    | Optional name for the inspection document.           |
| `showResultScreen` | `bool`               | `true`    | Show AiCycle's built-in result screen after capture. |
| `loggingEnabled`   | `bool`               | `false`   | Enable/disable Internal SDK logging.                 |

### 2. DisplayConfig

Customize the UI and visible capture angles.

| Property                   | Type      | Default    | Description                                                                     |
| :------------------------- | :-------- | :--------- | :------------------------------------------------------------------------------ |
| `loadingWidget`            | `Widget?` | `null`     | Custom widget to show during initialization.                                    |
| `carAnglesWithDisplayName` | `Map`     | All angles | Map of `AicycleCarAngle` to their display names. Controls which buttons appear. |
| `showBackButton`           | `bool`    | `false`    | Show/hide back button in the SDK.                                               |

### 3. CarInformation

Vehicle details for the inspection.

| Property            | Type      | Description                                       |
| :------------------ | :-------- | :------------------------------------------------ |
| `companyId`         | `String`  | Required. Vehicle brand ID (e.g., 'toyota').      |
| `modelId`           | `String`  | Required. Vehicle model ID.                       |
| `brandId`           | `String`  | Required. Brand ID.                               |
| `garageId`          | `String`  | Required. Garage ID.                              |
| `vehicleVersion`    | `String`  | Required. Vehicle version/specification.          |
| `licensePlate`      | `String`  | Required. Vehicle license plate number.           |
| `manufacturingYear` | `int?`    | Optional. Year of manufacture.                    |
| `vehicleType`       | `String?` | Optional. `sedan`, `suv`, `truck`, `pickup`, etc. |
| `color`             | `String?` | Optional. Hex color code (e.g., `#FFFFFF`).       |

### 4. ValidationConfig

Toggle various AI validation features.

| Property                | Type   | Default | Description                                            |
| :---------------------- | :----- | :------ | :----------------------------------------------------- |
| `sameCarValidation`     | `bool` | `true`  | Verify if all photos belong to the same vehicle.       |
| `missingPartValidation` | `bool` | `true`  | Check if any required car parts are missing in photos. |

## Data Output Structure

The `onComplete` callback returns a `Map<String, dynamic>` containing:

```json
{
  "damageStatistics": [
    {
      "vehiclePartName": "Cánh cửa trước trái",
      "paintPercentage": 1.0,
      "dentedLevel": "slight",
      "damages": [
        {
          "damageTypeName": "Trầy (xước)",
          "damagePercentage": 0.007,
          "damageTypeColor": "#FFEC05"
        }
      ],
      "images": [...]
    }
  ]
}
```

## Support

For issues and feature requests, please contact [AiCycle Support](mailto:support@aicycle.ai).
