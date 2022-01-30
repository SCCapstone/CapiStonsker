import 'dart:io' show Platform;
import 'dart:io' show Process;

import 'package:integration_test/integration_test_driver.dart';


Future<void> main() async {

  await Process.run('C:/Users/ralph/AppData/Local/Android/Sdk/platform-tools/adb.exe' , ['shell' ,'pm', 'grant', 'com.example', 'android.permission.ACCESS_FINE_LOCATION']);
  await Process.run('C:/Users/ralph/AppData/Local/Android/Sdk/platform-tools/adb.exe' , ['shell' ,'pm', 'grant', 'com.example', 'android.permission.ACCESS_COARSE_LOCATION']);
  await integrationDriver();
}