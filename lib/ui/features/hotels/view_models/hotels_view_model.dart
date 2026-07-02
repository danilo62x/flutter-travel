import 'package:flutter/foundation.dart';

import '../../../../data/repositories/hotel_repository.dart';
import '../../../../domain/models/hotel.dart';

enum HotelSort { recommended, priceAsc, priceDesc, rating }

extension HotelSortLabel on HotelSort {
  String get label {
    switch (this) {
      case HotelSort.recommended:
        return 'Recomendados';
      case HotelSort.priceAsc:
        return 'Menor preço';
      case HotelSort.priceDesc:
        return 'Maior preço';
      case HotelSort.rating:
        return 'Melhor avaliados';
    }
  }
}

/// Owns the hotel results screen: the full list plus the active filters.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately.
class HotelsViewModel extends ChangeNotifier {
  HotelsViewModel({required HotelRepository repository})
      : _repository = repository {
    _all = _repository.seed();
  }

  final HotelRepository _repository;

  List<Hotel> _all = const <Hotel>[];
  HotelSort _sort = HotelSort.recommended;
  int _minStars = 0;
  double _maxPrice = 2000;

  HotelSort get sort => _sort;
  int get minStars => _minStars;
  double get maxPrice => _maxPrice;
  int get total => results.length;

  List<Hotel> get results {
    final filtered = _all
        .where((h) => h.stars >= _minStars && h.pricePerNight <= _maxPrice)
        .toList();
    switch (_sort) {
      case HotelSort.recommended:
        break;
      case HotelSort.priceAsc:
        filtered.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
      case HotelSort.priceDesc:
        filtered.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
      case HotelSort.rating:
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return List.unmodifiable(filtered);
  }

  void setSort(HotelSort value) {
    _sort = value;
    notifyListeners();
  }

  void setMinStars(int value) {
    _minStars = _minStars == value ? 0 : value;
    notifyListeners();
  }

  void setMaxPrice(double value) {
    _maxPrice = value;
    notifyListeners();
  }
}
