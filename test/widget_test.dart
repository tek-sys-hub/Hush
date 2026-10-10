import 'package:flutter_test/flutter_test.dart';
import 'package:hush/main.dart';

void main() {
  testWidgets('HushApp launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const HushApp());
    expect(find.text('Hush'), findsOneWidget);
    expect(find.text('Keep your apps private'), findsOneWidget);
  });
}
