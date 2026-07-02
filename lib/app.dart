import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/router.dart';
import 'core/theme.dart';
import 'data/repositories/booking_repository.dart';
import 'data/repositories/destination_repository.dart';
import 'data/repositories/hotel_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/trip_repository.dart';

class TravelApp extends StatefulWidget {
  const TravelApp({super.key});

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  late final DestinationRepository _destinationRepository =
      DestinationRepository();
  late final HotelRepository _hotelRepository = HotelRepository();
  late final TripRepository _tripRepository = TripRepository();
  late final ProfileRepository _profileRepository = ProfileRepository();
  late final BookingRepository _bookingRepository = BookingRepository();

  late final GoRouter _router = createRouter(
    destinationRepository: _destinationRepository,
    hotelRepository: _hotelRepository,
    tripRepository: _tripRepository,
    profileRepository: _profileRepository,
    bookingRepository: _bookingRepository,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Travel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: _router,
    );
  }
}
