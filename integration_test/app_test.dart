import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capi_stonsker/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on icon button and open drawer',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle(Duration(seconds: 10));

          // Finds the menu button to open the drawer.
          final Finder menu = find.byTooltip('Open Menu');

          // Emulate a tap on the floating action button.
          await tester.tap(menu);
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('drawer')), findsOneWidget);

        });
  });
}