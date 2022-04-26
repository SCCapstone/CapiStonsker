import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capi_stonsker/main.dart' as app;
import 'dart:io' show Platform, sleep;

import 'dart:io' show Process;

void plan_route() {
  group('end-to-end test', () {
    testWidgets('Go to the plan route page',
            (WidgetTester tester) async {

          app.main();
          await tester.pump(Duration(seconds: 10));

          // Finds the menu button to open the drawer.
          final Finder menu = find.byKey(Key('menuview'));

          // Emulate a tap on the floating action button.
          await tester.tap(menu);
          await tester.pumpAndSettle();

          //drawer is open, thus click on plan_route
          final Finder plan_route = find.byKey(Key('plan_route'));

          await tester.tap(plan_route);
          await tester.pumpAndSettle();

          //look to see if plan route page of main is activated
          expect(find.byKey(const Key('plan_route')), findsOneWidget);

        });
  });
}