import 'package:flutter/foundation.dart';

import '../../../../data/repositories/booking_repository.dart';
import '../../../../data/repositories/hotel_repository.dart';
import '../../../../domain/models/booking.dart';
import '../../../../domain/models/hotel.dart';

/// Owns the editable booking draft.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately.
class BookingViewModel extends ChangeNotifier {
  BookingViewModel({
    required HotelRepository hotelRepository,
    required BookingRepository bookingRepository,
    String? hotelId,
  }) : _bookingRepository = bookingRepository {
    _hotel = (hotelId == null ? null : hotelRepository.findById(hotelId)) ??
        hotelRepository.seed().first;
    _booking = _bookingRepository.draftFor(_hotel);
  }

  final BookingRepository _bookingRepository;

  late final Hotel _hotel;
  late Booking _booking;

  Hotel get hotel => _hotel;
  Booking get booking => _booking;

  void setGuests(int delta) {
    final next = _booking.guests + delta;
    if (next < 1 || next > 8) return;
    _booking = _booking.copyWith(guests: next);
    notifyListeners();
  }

  void setRooms(int delta) {
    final next = _booking.rooms + delta;
    if (next < 1 || next > 5) return;
    _booking = _booking.copyWith(rooms: next);
    notifyListeners();
  }

  void selectRoomType(String name, int nightlyRate) {
    _booking = _booking.copyWith(roomName: name, nightlyRate: nightlyRate);
    notifyListeners();
  }

  void setDates(DateTime checkIn, DateTime checkOut) {
    _booking = _booking.copyWith(checkIn: checkIn, checkOut: checkOut);
    notifyListeners();
  }

  /// Confirms the draft and returns the resulting reservation.
  Booking confirm() => _bookingRepository.confirm(_booking);
}
