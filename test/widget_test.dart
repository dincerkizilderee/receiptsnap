import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receiptsnap/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ReceiptSnapApp()),
    );
    // App should render the bottom navigation
    expect(find.text('Tara'), findsOneWidget);
    expect(find.text('Harcamalar'), findsOneWidget);
  });
}
