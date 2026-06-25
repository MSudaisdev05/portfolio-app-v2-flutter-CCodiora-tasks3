import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_app/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
  });
}