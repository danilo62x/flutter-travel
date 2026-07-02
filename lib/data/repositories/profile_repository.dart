import '../../domain/models/user_profile.dart';

/// In-memory repository for the signed-in traveller.
class ProfileRepository {
  /// Instant, offline data used to render content immediately.
  UserProfile seed() {
    return const UserProfile(
      name: 'Danilo Quinelato',
      email: 'danilo@viagem.com',
      initials: 'DQ',
      memberSince: 'Membro desde 2021',
      tier: 'Explorer Gold',
      points: 11250,
      miles: 48600,
      tripsCount: 12,
      countriesCount: 7,
      reviewsCount: 34,
      favorites: <String>[
        'Rio de Janeiro',
        'Lisboa',
        'Fernando de Noronha',
        'Santiago',
      ],
    );
  }
}
