/// A planet and how many Earth years one of its orbits takes.
class Planet {
  final String name;
  final double earthYearsPerOrbit;

  const Planet(this.name, this.earthYearsPerOrbit);
}

/// Planets in the solar system with their orbital periods.
const List<Planet> planets = [
  Planet('Mercury', .2408467),
  Planet('Venus', .61519726),
  Planet('Earth', 1.0),
  Planet('Mars', 1.8808158),
  Planet('Jupiter', 11.862615),
  Planet('Saturn', 29.447498),
  Planet('Uranus', 84.016846),
  Planet('Neptune', 164.79132),
];

/// A person's age on a single planet.
class PlanetAge {
  final Planet planet;

  /// Age measured in that planet's years.
  final double years;

  /// Progress value (0..1) used for the linear indicator.
  final double progress;

  const PlanetAge({
    required this.planet,
    required this.years,
    required this.progress,
  });
}
