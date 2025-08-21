import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_frontend/main.dart';
import 'package:grocery_frontend/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ApiClient mockApiClient;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    mockApiClient = ApiClient(
      baseUrl: 'http://localhost:8080/api',
      prefs: prefs,
    );
  });

  testWidgets('App displays welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(apiClient: mockApiClient));

    // Find Scaffold widget to verify Material components are being used
    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);

    // Find AppBar to verify Material widgets
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);

    // Verify welcome message text using Text widgets
    final welcomeTextFinder = find.text('Welcome to Grocery Store');
    expect(welcomeTextFinder, findsOneWidget);
    
    final subtitleTextFinder = find.text('Your one-stop shop for fresh groceries');
    expect(subtitleTextFinder, findsOneWidget);

    // Verify text styles are from Material design
    final Text welcomeText = tester.widget(welcomeTextFinder);
    expect(welcomeText.style?.fontSize, 24);
    expect(welcomeText.style?.fontWeight, FontWeight.bold);
  });

  testWidgets('App bar has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(apiClient: mockApiClient));

    // Find AppBar title
    final titleFinder = find.widgetWithText(AppBar, 'Grocery Store');
    expect(titleFinder, findsOneWidget);
  });
}
