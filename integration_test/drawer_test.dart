import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capi_stonsker/main.dart' as app;
import 'dart:io' show Platform, sleep;

import 'dart:io' show Process;

void drawer_test() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on icon button and open drawer',
            (WidgetTester tester) async {

          //run the main app of capistonsker
          app.main();
          await tester.pump(Duration(seconds: 10));

          await tester.pumpAndSettle();

          // Finds the menu button to exit tutorial.
          final Finder menu = find.byTooltip('menuview');

          // Emulate a tap on the icon button twice to open the drawer.
          await tester.tap(menu);
          await tester.pumpAndSettle();

          await tester.tap(menu);
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('drawer')), findsOneWidget);


        });
  });
}