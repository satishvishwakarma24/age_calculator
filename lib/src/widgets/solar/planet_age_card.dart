import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
// import '../common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  PlanetAgeCard
//  Single row card showing planet name, symbol,
//  and the user's equivalent age on that planet.
// ─────────────────────────────────────────────

class PlanetAgeCard extends StatelessWidget {
  final PlanetAgeData data;
  final VoidCallback? onTap;

  const PlanetAgeCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.gapSm),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: data.color.withOpacity(0.04),
          border: Border.all(color: data.color.withOpacity(0.18)),
          borderRadius: BorderRadius.circular(AppDimens.radiusCard),
        ),
        child: Row(
          children: [
            // ── Planet icon bubble ─────────────────────
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: data.color.withOpacity(0.35)),
                boxShadow: [
                  BoxShadow(
                    color: data.color.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(data.symbol, style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 14),

            // ── Name + description ─────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name.toUpperCase(), style: AppText.planetName),
                  const SizedBox(height: 2),
                  Text(
                    data.description,
                    style: AppText.statLabel.copyWith(fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // ── Age value ─────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.formattedAge,
                  style: AppText.planetAge.copyWith(color: data.color),
                ),
                Text('yrs', style: AppText.statLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PlanetAgeData — pure data model for the widget
// ─────────────────────────────────────────────

class PlanetAgeData {
  final String name;
  final String symbol;
  final String description;   // e.g. "1 Earth yr = 0.24 yrs"
  final String formattedAge;  // e.g. "137.4"
  final Color color;

  const PlanetAgeData({
    required this.name,
    required this.symbol,
    required this.description,
    required this.formattedAge,
    required this.color,
  });
}