import '../../domain/models/destination.dart';

/// API-facing model with MANUAL json mapping + mapping to the domain layer.
class DestinationApiModel {
  const DestinationApiModel({
    required this.id,
    required this.name,
    required this.country,
    required this.rating,
    required this.price,
    required this.kind,
  });

  final String id;
  final String name;
  final String country;
  final double rating;
  final num price;
  final String kind;

  factory DestinationApiModel.fromJson(Map<String, dynamic> json) {
    return DestinationApiModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      country: json['country'] as String? ?? '',
      rating: (json['rating'] as num? ?? 0).toDouble(),
      price: json['price'] as num? ?? 0,
      kind: json['kind'] as String? ?? 'place',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'country': country,
      'rating': rating,
      'price': price,
      'kind': kind,
    };
  }

  Destination toDomain() {
    return Destination(
      id: id,
      name: name,
      country: country,
      rating: rating,
      priceLabel: 'R\$ ${price.toStringAsFixed(0)}',
      kind: kind == 'experience'
          ? DestinationKind.experience
          : DestinationKind.place,
      description: '',
      tags: const <String>[],
    );
  }
}
