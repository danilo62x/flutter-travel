import 'package:flutter/foundation.dart';

import '../../../../data/repositories/booking_repository.dart';
import '../../../../data/repositories/hotel_repository.dart';
import '../../../../domain/models/booking.dart';

/// Holds the confirmed reservation shown on the voucher screen.
///
/// Uses the [booking] passed on navigation, or seeds a confirmed reservation
/// SYNCHRONOUSLY so screenshots always render populated content.
class VoucherViewModel extends ChangeNotifier {
  VoucherViewModel({
    required HotelRepository hotelRepository,
    required BookingRepository bookingRepository,
    Booking? booking,
  }) {
    if (booking != null) {
      _booking = booking.confirmed
          ? booking
          : bookingRepository.confirm(booking);
    } else {
      final hotel = hotelRepository.seed().first;
      _booking = bookingRepository.confirm(bookingRepository.draftFor(hotel));
    }
  }

  late final Booking _booking;

  Booking get booking => _booking;
}
