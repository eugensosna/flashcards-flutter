import 'package:flashcards/features/study/presentation/widgets/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the front and then the back when flipped', (tester) async {
    var flipped = false;
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return FlipCard(
                front: 'Question',
                back: 'Answer',
                isFlipped: flipped,
                onTap: () {
                  taps++;
                  setState(() => flipped = !flipped);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Question'), findsOneWidget);
    expect(find.text('Answer'), findsNothing);
    expect(find.text('Front'), findsOneWidget);

    await tester.tap(find.byType(FlipCard));
    await tester.pumpAndSettle();

    expect(taps, 1);
    expect(find.text('Question'), findsNothing);
    expect(find.text('Answer'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });

  testWidgets('renders long content without overflowing', (tester) async {
    final longText = 'Very long content. ' * 40;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlipCard(
            front: longText,
            back: longText,
            isFlipped: false,
            onTap: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
