import 'package:flutter/foundation.dart';

import '../../../../data/repositories/destination_repository.dart';
import '../../../../data/repositories/hotel_repository.dart';
import '../../../../domain/models/destination.dart';
import '../../../../domain/models/hotel.dart';
import '../../../../domain/models/review.dart';

/// Owns the destination detail screen state.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately.
class DestinationDetailViewModel extends ChangeNotifier {
  DestinationDetailViewModel({
    required DestinationRepository destinationRepository,
    required HotelRepository hotelRepository,
    String? destinationId,
  }) {
    final all = destinationRepository.seed();
    _destination = (destinationId == null
            ? null
            : destinationRepository.findById(destinationId)) ??
        all.first;
    _reviews = destinationRepository.reviews();
    _hotels = hotelRepository.seed().take(3).toList();
    _favorite = false;
  }

  late final Destination _destination;
  late final List<Review> _reviews;
  late final List<Hotel> _hotels;
  bool _favorite = false;

  Destination get destination => _destination;
  List<Review> get reviews => List.unmodifiable(_reviews);
  List<Hotel> get hotels => List.unmodifiable(_hotels);
  bool get favorite => _favorite;

  void toggleFavorite() {
    _favorite = !_favorite;
    notifyListeners();
  }
}
