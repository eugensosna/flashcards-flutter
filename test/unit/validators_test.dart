import 'package:flashcards/core/errors/app_exception.dart';
import 'package:flashcards/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('deck names', () {
    test('rejects empty and blank names', () {
      expect(Validators.deckName(null), isNotNull);
      expect(Validators.deckName(''), isNotNull);
      expect(Validators.deckName('   '), isNotNull);
    });

    test('rejects names above the maximum length', () {
      expect(Validators.deckName('a' * 121), isNotNull);
      expect(Validators.deckName('a' * 120), isNull);
    });

    test('accepts trimmed valid names', () {
      expect(Validators.deckName('  Spanish  '), isNull);
      expect(Validators.requireDeckName('  Spanish  '), 'Spanish');
    });

    test('requireDeckName throws a validation exception', () {
      expect(
        () => Validators.requireDeckName('  '),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('card content', () {
    test('rejects empty content for both sides', () {
      expect(Validators.cardContent('', label: 'front'), isNotNull);
      expect(Validators.cardContent('   ', label: 'back'), isNotNull);
      expect(Validators.cardContent('hola', label: 'front'), isNull);
    });

    test('names the offending side in the message', () {
      expect(Validators.cardContent('', label: 'back'), contains('back'));
    });

    test('requireCardContent trims valid input', () {
      expect(
        Validators.requireCardContent('  answer ', label: 'back'),
        'answer',
      );
    });
  });

  group('optional text', () {
    test('turns blank input into null', () {
      expect(Validators.optionalText(null), isNull);
      expect(Validators.optionalText('   '), isNull);
    });

    test('trims non-blank input', () {
      expect(Validators.optionalText('  notes  '), 'notes');
    });
  });
}
