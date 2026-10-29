import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/section_card.dart';
import '../age/age_controller.dart';
import 'planets_controller.dart';
import 'planets_model.dart';

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
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: () => _showPlanetDetails(context, entry.planet, entry.years),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getPlanetColor(entry.planet.name).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/planets/${entry.planet.name.toLowerCase()}.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.public,
                      color: _getPlanetColor(entry.planet.name),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.planet.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: entry.progress,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.accentTeal),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),

                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Optimized container offering robust layouts without overflow risks
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple
                        .withAlpha(25), // Soft, subtle background tint
                    borderRadius:
                        BorderRadius.circular(20), // Modern pill-shaped badge
                  ),
                  child: Text(
                    '${entry.years.toStringAsFixed(2)} y',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.w600, // Medium-bold for premium feel
                      fontSize: 14,
                      color: AppColors
                          .primaryPurple, // Content color aligns with background
                      fontFeatures: [
                        FontFeature.tabularFigures()
                      ], // Keeps numbers perfectly aligned
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline,
                      color: AppColors.textSub, size: 24),
                  onPressed: () =>
                      _showPlanetDetails(context, entry.planet, entry.years),
                ),
              ]),
            ),
          ),
        ),
    ]);
  }

  void _showPlanetDetails(
      BuildContext context, Planet planet, double ageOnPlanet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _PlanetDetailSheet(planet: planet, ageOnPlanet: ageOnPlanet),
    );
  }

  Color _getPlanetColor(String name) {
    switch (name.toLowerCase()) {
      case 'mercury':
        return AppColors.mercury;
      case 'venus':
        return AppColors.venus;
      case 'earth':
        return AppColors.earth;
      case 'mars':
        return AppColors.mars;
      case 'jupiter':
        return AppColors.jupiter;
      case 'saturn':
        return AppColors.saturn;
      case 'uranus':
        return AppColors.uranus;
      case 'neptune':
        return AppColors.neptune;
      default:
        return Colors.grey;
    }
  }
}

class _PlanetDetailSheet extends StatelessWidget {
  final Planet planet;
  final double ageOnPlanet;

  const _PlanetDetailSheet({required this.planet, required this.ageOnPlanet});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                planet.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/planets/${planet.name.toLowerCase()}.png',
                width: 48,
                height: 48,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.public,
                  color: AppColors.primaryPurple,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            planet.description,
            style: const TextStyle(
                fontSize: 16, color: AppColors.textSub, height: 1.5),
          ),
          const SizedBox(height: 24),
          _InfoRow(label: 'Diameter', value: planet.diameter),
          _InfoRow(label: 'Mass', value: planet.mass),
          _InfoRow(label: 'Distance from Sun', value: planet.distance),
          _InfoRow(label: 'Average Temp', value: planet.temperature),
          _InfoRow(
              label: 'Orbital Period',
              value: '${planet.earthYearsPerOrbit} Earth years'),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: AppColors.primaryPurple.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                const Text(
                  'Your age on this planet',
                  style: TextStyle(fontSize: 14, color: AppColors.textSub),
                ),
                const SizedBox(height: 8),
                Text(
                  '${ageOnPlanet.toStringAsFixed(2)} years',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: AppColors.textSub, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
