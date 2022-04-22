import 'dart:io' show Platform;
import 'dart:io' show Process;

import 'package:integration_test/integration_test_driver.dart';


Future<void> main() async {
  final Map<String, String> envVars = Platform.environment;

  String loc = envVars['LOCALAPPDATA']!;
  
  print(loc+'/Android/Sdk/platform-tools/adb.exe');
  await Process.run(loc+'/Android/Sdk/platform-tools/adb.exe' , ['shell' ,'pm', 'grant', 'capi.ston.sker', 'android.permission.ACCESS_FINE_LOCATION']);
  await Process.run(loc+'/Android/Sdk/platform-tools/adb.exe' , ['shell' ,'pm', 'grant', 'capi.ston.sker', 'android.permission.ACCESS_COARSE_LOCATION']);
  await integrationDriver();
}