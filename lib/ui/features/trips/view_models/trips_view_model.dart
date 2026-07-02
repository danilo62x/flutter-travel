import 'package:flutter/foundation.dart';

import '../../../../data/repositories/trip_repository.dart';
import '../../../../domain/models/trip.dart';

/// Owns the "My trips" screen state.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately.
class TripsViewModel extends ChangeNotifier {
  TripsViewModel({required TripRepository repository})
      : _repository = repository {
    final all = _repository.seed();
    _upcoming = all.where((t) => t.status == TripStatus.upcoming).toList();
    _past = all.where((t) => t.status == TripStatus.past).toList();
  }

  final TripRepository _repository;

  List<Trip> _upcoming = const <Trip>[];
  List<Trip> _past = const <Trip>[];

  List<Trip> get upcoming => List.unmodifiable(_upcoming);
  List<Trip> get past => List.unmodifiable(_past);
}
