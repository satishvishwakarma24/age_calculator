/// A planet and its metadata.
class Planet {
  final String name;
  final double earthYearsPerOrbit;
  final String description;
  final String diameter;
  final String mass;
  final String distance;
  final String temperature;

  const Planet({
    required this.name,
    required this.earthYearsPerOrbit,
    required this.description,
    required this.diameter,
    required this.mass,
    required this.distance,
    required this.temperature,
  });
}

/// Planets in the solar system with their orbital periods and metadata.
const List<Planet> planets = [
  Planet(
    name: 'Mercury',
    earthYearsPerOrbit: 0.2408467,
    description: 'The smallest and innermost planet in the Solar System.',
    diameter: '4,879 km',
    mass: '3.285 × 10^23 kg',
    distance: '57.9 million km',
    temperature: '167°C',
  ),
  Planet(
    name: 'Venus',
    earthYearsPerOrbit: 0.61519726,
    description: 'Second planet from the Sun. It is the hottest planet in our solar system.',
    diameter: '12,104 km',
    mass: '4.867 × 10^24 kg',
    distance: '108.2 million km',
    temperature: '464°C',
  ),
  Planet(
    name: 'Earth',
    earthYearsPerOrbit: 1.0,
    description: 'Our home planet and the only place we know of so far that’s inhabited by living things.',
    diameter: '12,742 km',
    mass: '5.972 × 10^24 kg',
    distance: '149.6 million km',
    temperature: '15°C',
  ),
  Planet(
    name: 'Mars',
    earthYearsPerOrbit: 1.8808158,
    description: 'A dusty, cold, desert world with a very thin atmosphere.',
    diameter: '6,779 km',
    mass: '6.39 × 10^23 kg',
    distance: '227.9 million km',
    temperature: '-65°C',
  ),
  Planet(
    name: 'Jupiter',
    earthYearsPerOrbit: 11.862615,
    description: 'More than twice as massive as the other planets of our solar system combined.',
    diameter: '139,820 km',
    mass: '1.898 × 10^27 kg',
    distance: '778.5 million km',
    temperature: '-110°C',
  ),
  Planet(
    name: 'Saturn',
    earthYearsPerOrbit: 29.447498,
    description: 'Adorned with a dazzling, complex system of icy rings.',
    diameter: '116,460 km',
    mass: '5.683 × 10^26 kg',
    distance: '1.4 billion km',
    temperature: '-140°C',
  ),
  Planet(
    name: 'Uranus',
    earthYearsPerOrbit: 84.016846,
    description: 'The first planet found with the aid of a telescope.',
    diameter: '50,724 km',
    mass: '8.681 × 10^25 kg',
    distance: '2.9 billion km',
    temperature: '-195°C',
  ),
  Planet(
    name: 'Neptune',
    earthYearsPerOrbit: 164.79132,
    description: 'Dark, cold, and whipped by supersonic winds.',
    diameter: '49,244 km',
    mass: '1.024 × 10^26 kg',
    distance: '4.5 billion km',
    temperature: '-201°C',
  ),
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
