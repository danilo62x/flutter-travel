/// The signed-in traveller shown on the profile screen.
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.initials,
    required this.memberSince,
    required this.tier,
    required this.points,
    required this.miles,
    required this.tripsCount,
    required this.countriesCount,
    required this.reviewsCount,
    this.favorites = const <String>[],
  });

  final String name;
  final String email;
  final String initials;
  final String memberSince;

  /// Loyalty tier, e.g. "Explorer Gold".
  final String tier;
  final int points;
  final int miles;
  final int tripsCount;
  final int countriesCount;
  final int reviewsCount;

  /// Favorited destination names.
  final List<String> favorites;

  /// Progress (0..1) toward the next loyalty tier.
  double get tierProgress {
    const target = 15000;
    final value = points / target;
    if (value < 0) return 0;
    if (value > 1) return 1;
    return value;
  }

  int get pointsToNextTier {
    const target = 15000;
    final remaining = target - points;
    return remaining < 0 ? 0 : remaining;
  }
}
