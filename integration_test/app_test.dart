import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capi_stonsker/main.dart' as app;

import 'drawer_test.dart';
import 'plan_route_test.dart';
import 'splash_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  app.main();
  //drawer_test();
  //plan_route();
  splash_test();

}