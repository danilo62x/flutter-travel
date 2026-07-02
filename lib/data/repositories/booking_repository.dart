import '../../domain/models/booking.dart';
import '../../domain/models/hotel.dart';

/// Builds booking drafts and confirmed reservations from a chosen hotel.
class BookingRepository {
  /// A fresh, editable draft anchored on [hotel] (or a sensible default).
  Booking draftFor(Hotel hotel) {
    final room = hotel.rooms.isNotEmpty
        ? hotel.rooms.first
        : const RoomType(
            name: 'Quarto Standard',
            description: '',
            pricePerNight: 0,
            capacity: 2,
            beds: '1 cama queen',
          );
    return Booking(
      hotelName: hotel.name,
      location: hotel.location,
      roomName: room.name,
      checkIn: DateTime(2026, 7, 18),
      checkOut: DateTime(2026, 7, 23),
      guests: 2,
      rooms: 1,
      nightlyRate: room.pricePerNight,
      guestName: 'Danilo Quinelato',
    );
  }

  /// Marks a draft as confirmed with a generated reservation code.
  Booking confirm(Booking draft) {
    return draft.copyWith(confirmed: true, code: _codeFor(draft));
  }

  String _codeFor(Booking draft) {
    final hash = (draft.hotelName.hashCode ^ draft.nightlyRate).abs();
    final block = hash.toRadixString(36).toUpperCase().padLeft(4, '0');
    return 'TRV-${block.substring(0, 4)}';
  }
}
