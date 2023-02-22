import 'package:atak_searchapp/config/initial_bindings.dart';
import 'package:atak_searchapp/main.dart';
import 'package:atak_searchapp/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testing app\'s search engines.',
      (WidgetTester widgetTester) async {
    WidgetsFlutterBinding.ensureInitialized();
    InitialBindings().dependencies();
    await widgetTester.pumpWidget(const MyApp());
    await widgetTester.pump(const Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    await widgetTester.enterText(find.byType(TextField), 'Maringá');
    await widgetTester.tap(find.byTooltip('Pesquisar com Cheerio'));
    await widgetTester.pump(const Duration(seconds: 5));
    expect(find.byTooltip('Resultado da Pesquisa com cheerio'),
        findsAtLeastNWidgets(3));

    await widgetTester.tap(find.byTooltip('Pesquisar com Puppeteer'));
    await widgetTester.pump(const Duration(seconds: 10));
    expect(find.byTooltip('Resultado da Pesquisa com puppeteer'),
        findsAtLeastNWidgets(3));
  });
}
