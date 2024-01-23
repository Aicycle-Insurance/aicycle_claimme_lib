
An Aicycle ClaimMe package for Aicycle Insurance's partners.

### Set permissions
   - **iOS** add these on ```ios/Runner/Info.plist``` file

```xml
<key>NSCameraUsageDescription</key>
<string>Your own description</string>

<key>NSMicrophoneUsageDescription</key>
<string>Your own description</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>Your own description</string>
```

  - **Android**
    - Set permissions before ```<application>```
    <br />

    ```xml
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />
    ```

    - Change the minimum SDK version to 21 (or higher) in ```android/app/build.gradle```
    <br />

    ```
    minSdkVersion 22
    ```
### Import the package
```dart
import 'package:aicycle_claimme_lib/aicycle_claimme_lib.dart';
```

### Required
```dart
Future<void> main() async {
  /// add this two lines below
  WidgetsFlutterBinding.ensureInitialized();
  await AICycle.initial();

  runApp(const YourApp());
}
```