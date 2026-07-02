import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/booking_repository.dart';
import '../data/repositories/destination_repository.dart';
import '../data/repositories/hotel_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/trip_repository.dart';
import '../domain/models/booking.dart';
import '../ui/features/booking/view_models/booking_view_model.dart';
import '../ui/features/booking/view_models/voucher_view_model.dart';
import '../ui/features/booking/views/booking_screen.dart';
import '../ui/features/booking/views/voucher_screen.dart';
import '../ui/features/destination/view_models/destination_detail_view_model.dart';
import '../ui/features/destination/views/destination_detail_screen.dart';
import '../ui/features/explore/view_models/explore_view_model.dart';
import '../ui/features/explore/views/explore_screen.dart';
import '../ui/features/hotels/view_models/hotel_detail_view_model.dart';
import '../ui/features/hotels/view_models/hotels_view_model.dart';
import '../ui/features/hotels/views/hotel_detail_screen.dart';
import '../ui/features/hotels/views/hotels_screen.dart';
import '../ui/features/profile/view_models/profile_view_model.dart';
import '../ui/features/profile/views/profile_screen.dart';
import '../ui/features/trips/view_models/trips_view_model.dart';
import '../ui/features/trips/views/trips_screen.dart';

/// Declarative routing with go_router. The four primary tabs live at the
/// top level (Explorar, Buscar, Viagens, Perfil); detail flows are pushed
/// on top (destino, hotel, reserva, voucher).
GoRouter createRouter({
  required DestinationRepository destinationRepository,
  required HotelRepository hotelRepository,
  required TripRepository tripRepository,
  required ProfileRepository profileRepository,
  required BookingRepository bookingRepository,
}) {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => ChangeNotifierProvider<ExploreViewModel>(
          create: (_) => ExploreViewModel(repository: destinationRepository),
          child: const ExploreScreen(),
        ),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => ChangeNotifierProvider<HotelsViewModel>(
          create: (_) => HotelsViewModel(repository: hotelRepository),
          child: const HotelsScreen(),
        ),
      ),
      GoRoute(
        path: '/trips',
        builder: (context, state) => ChangeNotifierProvider<TripsViewModel>(
          create: (_) => TripsViewModel(repository: tripRepository),
          child: const TripsScreen(),
        ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ChangeNotifierProvider<ProfileViewModel>(
          create: (_) => ProfileViewModel(repository: profileRepository),
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: '/destination/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return ChangeNotifierProvider<DestinationDetailViewModel>(
            create: (_) => DestinationDetailViewModel(
              destinationRepository: destinationRepository,
              hotelRepository: hotelRepository,
              destinationId: id,
            ),
            child: const DestinationDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: '/hotel/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return ChangeNotifierProvider<HotelDetailViewModel>(
            create: (_) => HotelDetailViewModel(
              repository: hotelRepository,
              hotelId: id,
            ),
            child: const HotelDetailScreen(),
          );
        },
      ),
      GoRoute(
        path: '/booking',
        builder: (context, state) => ChangeNotifierProvider<BookingViewModel>(
          create: (_) => BookingViewModel(
            hotelRepository: hotelRepository,
            bookingRepository: bookingRepository,
          ),
          child: const BookingScreen(),
        ),
      ),
      GoRoute(
        path: '/voucher',
        builder: (context, state) {
          final booking = state.extra is Booking ? state.extra as Booking : null;
          return ChangeNotifierProvider<VoucherViewModel>(
            create: (_) => VoucherViewModel(
              hotelRepository: hotelRepository,
              bookingRepository: bookingRepository,
              booking: booking,
            ),
            child: const VoucherScreen(),
          );
        },
      ),
    ],
  );
}
