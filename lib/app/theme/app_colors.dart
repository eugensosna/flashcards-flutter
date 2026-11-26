import 'package:flutter/material.dart';

/// Brand colors and the palette offered when creating decks.
abstract final class AppColors {
  static const Color seed = Color(0xFF4F46E5);

  /// Preset deck colors shown in the deck editor.
  static const List<Color> deckPalette = [
    Color(0xFF4F46E5),
    Color(0xFF0EA5E9),
    Color(0xFF14B8A6),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
  ];

  static const Color again = Color(0xFFEF4444);
  static const Color hard = Color(0xFFF59E0B);
  static const Color good = Color(0xFF10B981);
  static const Color easy = Color(0xFF3B82F6);

  /// Parses `#RRGGBB` or `RRGGBB`; returns `null` for unknown formats.
  static Color? parseHex(String? hex) {
    if (hex == null) {
      return null;
    }
    final cleaned = hex.replaceFirst('#', '').trim();
    if (cleaned.length != 6) {
      return null;
    }
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) {
      return null;
    }
    return Color(0xFF000000 | value);
  }

  /// Formats a color as `#RRGGBB` for storage.
  static String toHex(Color color) {
    final rgb = color.toARGB32() & 0xFFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
