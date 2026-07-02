import 'package:flutter/foundation.dart';

import '../../../../data/repositories/hotel_repository.dart';
import '../../../../domain/models/hotel.dart';
import '../../../../domain/models/review.dart';

/// Owns the hotel detail screen state.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately.
class HotelDetailViewModel extends ChangeNotifier {
  HotelDetailViewModel({
    required HotelRepository repository,
    String? hotelId,
  }) {
    _hotel = (hotelId == null ? null : repository.findById(hotelId)) ??
        repository.seed().first;
    _reviews = repository.reviews();
    _selectedRoom = _hotel.rooms.isNotEmpty ? 0 : -1;
  }

  late final Hotel _hotel;
  late final List<Review> _reviews;
  int _selectedRoom = 0;

  Hotel get hotel => _hotel;
  List<Review> get reviews => List.unmodifiable(_reviews);
  int get selectedRoom => _selectedRoom;

  void selectRoom(int index) {
    _selectedRoom = index;
    notifyListeners();
  }
}
