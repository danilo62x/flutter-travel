import '../../domain/models/trip.dart';

/// In-memory repository of the traveller's booked journeys.
class TripRepository {
  /// Instant, offline data used to render content immediately.
  List<Trip> seed() {
    return <Trip>[
      Trip(
        id: 't1',
        destination: 'Rio de Janeiro',
        location: 'Leme, Rio de Janeiro',
        hotelName: 'Mirante do Leme Resort',
        checkIn: DateTime(2026, 7, 18),
        checkOut: DateTime(2026, 7, 23),
        guests: 2,
        price: 4450,
        code: 'TRV-9F2A',
        status: TripStatus.upcoming,
      ),
      Trip(
        id: 't2',
        destination: 'Fernando de Noronha',
        location: 'Vila dos Remédios, Noronha',
        hotelName: 'Pousada Mar Azul',
        checkIn: DateTime(2026, 8, 9),
        checkOut: DateTime(2026, 8, 13),
        guests: 2,
        price: 4720,
        code: 'TRV-7C1D',
        status: TripStatus.upcoming,
      ),
      Trip(
        id: 't3',
        destination: 'Lisboa',
        location: 'Alfama, Lisboa',
        hotelName: 'Alfama Boutique Hotel',
        checkIn: DateTime(2026, 3, 4),
        checkOut: DateTime(2026, 3, 9),
        guests: 2,
        price: 3200,
        code: 'TRV-4B8E',
        status: TripStatus.past,
        rating: 4.8,
      ),
      Trip(
        id: 't4',
        destination: 'Santiago',
        location: 'Providencia, Santiago',
        hotelName: 'Andes Grand Hotel',
        checkIn: DateTime(2025, 12, 20),
        checkOut: DateTime(2025, 12, 27),
        guests: 3,
        price: 3640,
        code: 'TRV-2A5F',
        status: TripStatus.past,
        rating: 4.5,
      ),
    ];
  }

  List<Trip> upcoming() =>
      seed().where((t) => t.status == TripStatus.upcoming).toList();

  List<Trip> past() =>
      seed().where((t) => t.status == TripStatus.past).toList();
}
