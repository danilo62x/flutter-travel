import '../../domain/models/hotel.dart';

/// API-facing model with MANUAL json mapping + mapping to the domain layer.
class HotelApiModel {
  const HotelApiModel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.stars,
    required this.kind,
    required this.amenities,
  });

  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviewCount;
  final num price;
  final int stars;
  final String kind;
  final List<String> amenities;

  factory HotelApiModel.fromJson(Map<String, dynamic> json) {
    return HotelApiModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      location: json['location'] as String? ?? '',
      rating: (json['rating'] as num? ?? 0).toDouble(),
      reviewCount: (json['reviewCount'] as num? ?? 0).toInt(),
      price: json['price'] as num? ?? 0,
      stars: (json['stars'] as num? ?? 3).toInt(),
      kind: json['kind'] as String? ?? 'Hotel',
      amenities:
          (json['amenities'] as List<dynamic>? ?? const <dynamic>[])
              .map((dynamic e) => e.toString())
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': location,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'stars': stars,
      'kind': kind,
      'amenities': amenities,
    };
  }

  Hotel toDomain() {
    return Hotel(
      id: id,
      name: name,
      location: location,
      rating: rating,
      reviewCount: reviewCount,
      pricePerNight: price.toInt(),
      stars: stars,
      kind: kind,
      distanceLabel: '',
      amenities: amenities
          .map(_amenityFromKey)
          .whereType<Amenity>()
          .toList(),
    );
  }

  static Amenity? _amenityFromKey(String key) {
    for (final amenity in Amenity.values) {
      if (amenity.name == key) return amenity;
    }
    return null;
  }
}
