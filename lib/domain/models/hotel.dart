/// Amenities a stay can offer. Pure domain enum — the UI layer maps each value
/// to a Material icon so the domain stays free of Flutter dependencies.
enum Amenity {
  wifi,
  pool,
  breakfast,
  parking,
  gym,
  spa,
  restaurant,
  airConditioning,
  beachAccess,
  petFriendly,
  bar,
  roomService,
}

extension AmenityLabel on Amenity {
  String get label {
    switch (this) {
      case Amenity.wifi:
        return 'Wi-Fi grátis';
      case Amenity.pool:
        return 'Piscina';
      case Amenity.breakfast:
        return 'Café da manhã';
      case Amenity.parking:
        return 'Estacionamento';
      case Amenity.gym:
        return 'Academia';
      case Amenity.spa:
        return 'Spa';
      case Amenity.restaurant:
        return 'Restaurante';
      case Amenity.airConditioning:
        return 'Ar-condicionado';
      case Amenity.beachAccess:
        return 'Acesso à praia';
      case Amenity.petFriendly:
        return 'Aceita pets';
      case Amenity.bar:
        return 'Bar';
      case Amenity.roomService:
        return 'Serviço de quarto';
    }
  }
}

/// A bookable room category within a hotel.
class RoomType {
  const RoomType({
    required this.name,
    required this.description,
    required this.pricePerNight,
    required this.capacity,
    required this.beds,
  });

  final String name;
  final String description;
  final int pricePerNight;
  final int capacity;
  final String beds;

  String get priceLabel => 'R\$ ${pricePerNight.toString()}';
}

/// A place to stay: hotel, resort, guest house, etc.
class Hotel {
  const Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.pricePerNight,
    required this.stars,
    required this.kind,
    required this.distanceLabel,
    this.description = '',
    this.amenities = const <Amenity>[],
    this.rooms = const <RoomType>[],
  });

  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviewCount;
  final int pricePerNight;
  final int stars;

  /// e.g. "Resort", "Hotel", "Pousada", "Flat".
  final String kind;

  /// e.g. "1,2 km do centro".
  final String distanceLabel;
  final String description;
  final List<Amenity> amenities;
  final List<RoomType> rooms;

  String get priceLabel => 'R\$ ${pricePerNight.toString()}';

  String get ratingWord {
    if (rating >= 4.8) return 'Excepcional';
    if (rating >= 4.5) return 'Maravilhoso';
    if (rating >= 4.0) return 'Muito bom';
    return 'Bom';
  }
}
