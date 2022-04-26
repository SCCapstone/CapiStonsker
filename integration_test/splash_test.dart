import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capi_stonsker/main.dart' as app;
import 'dart:io' show Platform, sleep;

import 'dart:io' show Process;

void splash_test() {

  group('end-to-end test', () {
    testWidgets('Ensure splash screen started',
            (WidgetTester tester) async {

          //run the main app of capistonsker
          app.main();
          await tester.pump(Duration(seconds: 10));

          // Should open up the splash screen
          expect(find.byKey(Key("splash")), findsOneWidget);


        });
  });
}