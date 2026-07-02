/// A single traveller review shown on destination and hotel detail screens.
class Review {
  const Review({
    required this.author,
    required this.initials,
    required this.rating,
    required this.date,
    required this.comment,
    this.trip = '',
  });

  final String author;
  final String initials;
  final double rating;
  final String date;
  final String comment;

  /// Optional context, e.g. "Viagem em família".
  final String trip;
}
