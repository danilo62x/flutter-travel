/// Clean domain model for a travel destination.
class Destination {
  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.rating,
    required this.priceLabel,
    required this.kind,
    this.description = '',
    this.tags = const <String>[],
    this.reviewCount = 0,
  });

  final String id;
  final String name;
  final String country;
  final double rating;
  final String priceLabel;

  /// Distinguishes a headline "destination" card from an "experience" tile.
  final DestinationKind kind;

  /// Long-form copy used on the destination detail screen.
  final String description;

  /// Short highlight tags (e.g. "Praia", "Cultura").
  final List<String> tags;

  /// Number of traveller reviews backing [rating].
  final int reviewCount;

  Destination copyWith({
    String? id,
    String? name,
    String? country,
    double? rating,
    String? priceLabel,
    DestinationKind? kind,
    String? description,
    List<String>? tags,
    int? reviewCount,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      rating: rating ?? this.rating,
      priceLabel: priceLabel ?? this.priceLabel,
      kind: kind ?? this.kind,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}

enum DestinationKind { place, experience }
