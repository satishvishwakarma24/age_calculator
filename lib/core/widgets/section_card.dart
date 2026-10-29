import 'package:flutter/material.dart';

/// Standard padded card used to group content on every feature screen.
class SectionCard extends StatelessWidget {
  final Widget child;

  const SectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(padding: const EdgeInsets.all(18), child: child),
      );
}
