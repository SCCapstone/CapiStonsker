import 'da'
import 'package:path/path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test_driver.dart';


Future<void> main() async {
  final Map<String, String> envVars = Platform.environment;
  String? adbPath = join(envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME']!,
    'platform-tools',
    Platform.isWindows ? 'adb.exe' : 'adb',
  );
  await Process.run(adbPath , ['shell' ,'pm', 'grant', 'com.example', 'android.permission.ACCESS_FINE_LOCATION']);
  await Process.run(adbPath , ['shell' ,'pm', 'grant', 'com.example', 'android.permission.ACCESS_COARSE_LOCATION']);
  await integrationDriver();
}