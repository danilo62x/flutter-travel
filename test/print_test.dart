import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:travel/core/theme.dart';
import 'package:travel/data/repositories/booking_repository.dart';
import 'package:travel/data/repositories/destination_repository.dart';
import 'package:travel/data/repositories/hotel_repository.dart';
import 'package:travel/data/repositories/profile_repository.dart';
import 'package:travel/data/repositories/trip_repository.dart';
import 'package:travel/ui/features/booking/view_models/booking_view_model.dart';
import 'package:travel/ui/features/booking/view_models/voucher_view_model.dart';
import 'package:travel/ui/features/booking/views/booking_screen.dart';
import 'package:travel/ui/features/booking/views/voucher_screen.dart';
import 'package:travel/ui/features/destination/view_models/destination_detail_view_model.dart';
import 'package:travel/ui/features/destination/views/destination_detail_screen.dart';
import 'package:travel/ui/features/explore/view_models/explore_view_model.dart';
import 'package:travel/ui/features/explore/views/explore_screen.dart';
import 'package:travel/ui/features/hotels/view_models/hotel_detail_view_model.dart';
import 'package:travel/ui/features/hotels/view_models/hotels_view_model.dart';
import 'package:travel/ui/features/hotels/views/hotel_detail_screen.dart';
import 'package:travel/ui/features/hotels/views/hotels_screen.dart';
import 'package:travel/ui/features/profile/view_models/profile_view_model.dart';
import 'package:travel/ui/features/profile/views/profile_screen.dart';
import 'package:travel/ui/features/trips/view_models/trips_view_model.dart';
import 'package:travel/ui/features/trips/views/trips_screen.dart';

import 'golden_utils.dart';

typedef PageBuilder = Widget Function();

void main() {
  final destinationRepository = DestinationRepository();
  final hotelRepository = HotelRepository();
  final tripRepository = TripRepository();
  final profileRepository = ProfileRepository();
  final bookingRepository = BookingRepository();

  final pages = <(String, PageBuilder)>[
    (
      'Explorar',
      () => ChangeNotifierProvider(
            create: (_) =>
                ExploreViewModel(repository: destinationRepository),
            child: const ExploreScreen(),
          ),
    ),
    (
      'Destino',
      () => ChangeNotifierProvider(
            create: (_) => DestinationDetailViewModel(
              destinationRepository: destinationRepository,
              hotelRepository: hotelRepository,
              destinationId: 'rio',
            ),
            child: const DestinationDetailScreen(),
          ),
    ),
    (
      'Hotéis',
      () => ChangeNotifierProvider(
            create: (_) => HotelsViewModel(repository: hotelRepository),
            child: const HotelsScreen(),
          ),
    ),
    (
      'Hotel',
      () => ChangeNotifierProvider(
            create: (_) => HotelDetailViewModel(
              repository: hotelRepository,
              hotelId: 'mirante',
            ),
            child: const HotelDetailScreen(),
          ),
    ),
    (
      'Reserva',
      () => ChangeNotifierProvider(
            create: (_) => BookingViewModel(
              hotelRepository: hotelRepository,
              bookingRepository: bookingRepository,
              hotelId: 'mirante',
            ),
            child: const BookingScreen(),
          ),
    ),
    (
      'Voucher',
      () => ChangeNotifierProvider(
            create: (_) => VoucherViewModel(
              hotelRepository: hotelRepository,
              bookingRepository: bookingRepository,
            ),
            child: const VoucherScreen(),
          ),
    ),
    (
      'Viagens',
      () => ChangeNotifierProvider(
            create: (_) => TripsViewModel(repository: tripRepository),
            child: const TripsScreen(),
          ),
    ),
    (
      'Perfil',
      () => ChangeNotifierProvider(
            create: (_) => ProfileViewModel(repository: profileRepository),
            child: const ProfileScreen(),
          ),
    ),
  ];

  testWidgets('travel screenshots (claro + escuro)', (tester) async {
    await loadGoldenFonts();
    await initializeDateFormatting('pt_BR', null);
    tester.binding.focusManager.highlightStrategy =
        FocusHighlightStrategy.alwaysTouch;
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    var idx = 0;
    for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
      for (final page in pages) {
        final key = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: page.$2(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 600));

        await tester.runAsync(() async {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 3.0);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final suffix = idx == 0 ? '' : '-${idx + 1}';
          final file = File('screenshots/travel$suffix.png');
          await file.create(recursive: true);
          await file.writeAsBytes(bytes!.buffer.asUint8List());
        });
        idx++;
      }
    }
  });
}
