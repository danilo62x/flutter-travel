/// A stay reservation — used as an editable draft on the booking screen and as
/// a confirmed record on the voucher screen.
class Booking {
  const Booking({
    required this.hotelName,
    required this.location,
    required this.roomName,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.rooms,
    required this.nightlyRate,
    required this.guestName,
    this.code = '',
    this.confirmed = false,
  });

  final String hotelName;
  final String location;
  final String roomName;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final int rooms;
  final int nightlyRate;
  final String guestName;
  final String code;
  final bool confirmed;

  int get nights {
    final diff = checkOut.difference(checkIn).inDays;
    return diff <= 0 ? 1 : diff;
  }

  int get subtotal => nightlyRate * nights * rooms;

  /// Simple service fee used for the price breakdown.
  int get serviceFee => (subtotal * 0.08).round();

  int get taxes => (subtotal * 0.05).round();

  int get total => subtotal + serviceFee + taxes;

  Booking copyWith({
    String? hotelName,
    String? location,
    String? roomName,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
    int? rooms,
    int? nightlyRate,
    String? guestName,
    String? code,
    bool? confirmed,
  }) {
    return Booking(
      hotelName: hotelName ?? this.hotelName,
      location: location ?? this.location,
      roomName: roomName ?? this.roomName,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      guests: guests ?? this.guests,
      rooms: rooms ?? this.rooms,
      nightlyRate: nightlyRate ?? this.nightlyRate,
      guestName: guestName ?? this.guestName,
      code: code ?? this.code,
      confirmed: confirmed ?? this.confirmed,
    );
  }
}
