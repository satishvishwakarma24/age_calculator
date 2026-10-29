import '../../core/utils/date_utils.dart';
import 'planets_model.dart';

/// Computes a person's age on every planet in [planets].
class PlanetsController {
  const PlanetsController();

  List<PlanetAge> agesOn(DateTime dob, [DateTime? asOf]) {
    final earthYears = daysBetween(dob, asOf ?? now) / 365.25;
    return [
      for (final planet in planets)
        PlanetAge(
          planet: planet,
          years: earthYears / planet.earthYearsPerOrbit,
          progress: _progress(earthYears, planet),
        ),
    ];
  }

  double _progress(double earthYears, Planet planet) {
    if (earthYears == 0) return 0;
    if (planet.earthYearsPerOrbit == planets.first.earthYearsPerOrbit) return 1;
    return (planets.first.earthYearsPerOrbit / planet.earthYearsPerOrbit)
        .clamp(0.0, 1.0);
  }
}
