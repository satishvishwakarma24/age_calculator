import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/section_card.dart';
import '../age/age_controller.dart';
import 'planets_controller.dart';

/// Planets tab: shows the person's age on each planet.
class PlanetsScreen extends StatelessWidget {
  const PlanetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dob = context.watch<AgeController>().dob;
    if (dob == null) {
      return const SectionCard(child: Text('Calculate your age first.'));
    }
    final ages = context.read<PlanetsController>().agesOn(dob);

    return Column(children: [
      for (final entry in ages)
        SectionCard(
          child: Row(children: [
            const Icon(Icons.public, color: Color(0xFF5CE1E6)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.planet.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Year = ${entry.planet.earthYearsPerOrbit} Earth years'),
                  LinearProgressIndicator(value: entry.progress),
                ],
              ),
            ),
            Text(entry.years.toStringAsFixed(2)),
          ]),
        ),
    ]);
  }
}
