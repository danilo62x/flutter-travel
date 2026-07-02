/// Whether a trip is still ahead or already completed.
enum TripStatus { upcoming, past }

/// A booked journey shown on the "My trips" screen.
class Trip {
  const Trip({
    required this.id,
    required this.destination,
    required this.location,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.price,
    required this.code,
    required this.status,
    this.rating,
  });

  final String id;
  final String destination;
  final String location;
  final String hotelName;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final int price;
  final String code;
  final TripStatus status;

  /// Rating the traveller left (past trips only).
  final double? rating;

  int get nights {
    final diff = checkOut.difference(checkIn).inDays;
    return diff <= 0 ? 1 : diff;
  }

  String get priceLabel => 'R\$ ${price.toString()}';
}
