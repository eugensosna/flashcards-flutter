import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A flashcard that flips around its vertical axis when tapped.
class FlipCard extends StatelessWidget {
  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.isFlipped,
    required this.onTap,
    this.hint,
  });

  final String front;
  final String back;
  final bool isFlipped;
  final VoidCallback onTap;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: isFlipped
          ? 'Flashcard back. $back'
          : 'Flashcard front. $front. Tap to reveal the answer.',
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: isFlipped ? 1 : 0),
              duration: const Duration(milliseconds: 380),
              curve: Curves.easeInOutCubic,
              builder: (context, value, _) {
                final angle = value * math.pi;
                final showBack = angle >= math.pi / 2;
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0012)
                    ..rotateY(angle),
                  child: showBack
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(math.pi),
                          child: _CardSide(
                            label: 'Back',
                            text: back,
                            accent: theme.colorScheme.tertiary,
                            hint: hint,
                          ),
                        )
                      : _CardSide(
                          label: 'Front',
                          text: front,
                          accent: theme.colorScheme.primary,
                          hint: hint,
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CardSide extends StatelessWidget {
  const _CardSide({
    required this.label,
    required this.text,
    required this.accent,
    this.hint,
  });

  final String label;
  final String text;
  final Color accent;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hint != null) ...[
              const SizedBox(height: 24),
              Text(
                hint!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
