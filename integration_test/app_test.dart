import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capi_stonsker/main.dart' as app;

import 'package:permission_handler/permission_handler.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on icon button and open drawer',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle(Duration(seconds: 3));
          
          // Finds the menu button to open the drawer.
          final Finder menu = find.byTooltip('Open Menu');
          // Emulate a tap on the floating action button.
          await tester.tap(menu);
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('drawer')), findsOneWidget);

          // Trigger a frame.
          //await tester.pumpAndSettle();

          // Finds the login button within drawer
          //final Finder login = find.byKey(const Key('login'));

          // Emulate a tap on the button.
          //await tester.tap(login);

          // Finds the gesture.
          //final Finder makeAccount = find.byKey(const Key('makeAccount'));

          // Emulate a tap on the gesture.
          //await tester.tap(makeAccount);

          // Finds the gesture.
          //final Finder emailSignUp = find.byKey(const Key('emailSignUp'));

          // Emulate a tap on the gesture.
          //await tester.tap(emailSignUp);




        });
  });
}