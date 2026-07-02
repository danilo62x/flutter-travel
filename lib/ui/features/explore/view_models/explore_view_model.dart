import 'package:flutter/foundation.dart';

import '../../../../data/repositories/destination_repository.dart';
import '../../../../domain/models/destination.dart';

/// ChangeNotifier that owns the Explore screen state.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately, while [refresh] demonstrates the async path.
class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({required DestinationRepository repository})
      : _repository = repository {
    _items = _repository.seed();
  }

  final DestinationRepository _repository;

  List<Destination> _items = const <Destination>[];
  bool _loading = false;

  List<Destination> get items => List.unmodifiable(_items);
  bool get loading => _loading;

  List<Destination> get places =>
      _items.where((d) => d.kind == DestinationKind.place).toList();

  List<Destination> get experiences =>
      _items.where((d) => d.kind == DestinationKind.experience).toList();

  Future<void> refresh() async {
    _loading = true;
    notifyListeners();
    _items = await _repository.fetch();
    _loading = false;
    notifyListeners();
  }
}
