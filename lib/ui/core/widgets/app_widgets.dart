import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/destination.dart';
import '../../../domain/models/hotel.dart';

/// Switches between the four primary tabs from the shared bottom navigation.
void goToTab(BuildContext context, int index) {
  switch (index) {
    case 1:
      context.go('/search');
    case 2:
      context.go('/trips');
    case 3:
      context.go('/profile');
    default:
      context.go('/');
  }
}

/// Deterministic gradient derived from a seed string so each card looks
/// distinct without any network images.
LinearGradient gradientFor(String seed, ColorScheme scheme) {
  final base = <List<Color>>[
    <Color>[const Color(0xFF0E7490), const Color(0xFF22D3EE)],
    <Color>[const Color(0xFF7C3AED), const Color(0xFFEC4899)],
    <Color>[const Color(0xFFEA580C), const Color(0xFFF59E0B)],
    <Color>[const Color(0xFF059669), const Color(0xFF34D399)],
    <Color>[const Color(0xFF2563EB), const Color(0xFF60A5FA)],
    <Color>[const Color(0xFFBE123C), const Color(0xFFFB7185)],
  ];
  final pair = base[seed.hashCode.abs() % base.length];
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: pair,
  );
}

/// Material icon for each amenity (kept in the UI layer so the domain stays
/// free of Flutter dependencies).
IconData amenityIcon(Amenity amenity) {
  switch (amenity) {
    case Amenity.wifi:
      return Icons.wifi_rounded;
    case Amenity.pool:
      return Icons.pool_rounded;
    case Amenity.breakfast:
      return Icons.free_breakfast_rounded;
    case Amenity.parking:
      return Icons.local_parking_rounded;
    case Amenity.gym:
      return Icons.fitness_center_rounded;
    case Amenity.spa:
      return Icons.spa_rounded;
    case Amenity.restaurant:
      return Icons.restaurant_rounded;
    case Amenity.airConditioning:
      return Icons.ac_unit_rounded;
    case Amenity.beachAccess:
      return Icons.beach_access_rounded;
    case Amenity.petFriendly:
      return Icons.pets_rounded;
    case Amenity.bar:
      return Icons.local_bar_rounded;
    case Amenity.roomService:
      return Icons.room_service_rounded;
  }
}

/// Icon used for a destination banner/thumbnail.
IconData iconForDestination(Destination destination) {
  if (destination.kind == DestinationKind.experience) {
    return Icons.hiking_rounded;
  }
  return Icons.location_city_rounded;
}

/// Small pill showing a star rating on a translucent background.
class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating, this.onDark = false});

  final double rating;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = onDark ? Colors.white : theme.colorScheme.onSurface;
    final bg = onDark
        ? Colors.black.withValues(alpha: 0.35)
        : theme.colorScheme.surfaceContainerHighest;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFACC15)),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: theme.textTheme.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row of five star icons reflecting [rating] (supports half stars).
class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 18});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (index) {
        final filled = rating >= index + 1;
        final half = !filled && rating > index + 0.25;
        return Icon(
          half
              ? Icons.star_half_rounded
              : (filled ? Icons.star_rounded : Icons.star_outline_rounded),
          size: size,
          color: const Color(0xFFFACC15),
        );
      }),
    );
  }
}

/// Section title with an optional trailing action label.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

/// Reusable gradient hero used at the top of detail screens.
class GradientBanner extends StatelessWidget {
  const GradientBanner({
    super.key,
    required this.seed,
    required this.icon,
    this.height = 240,
    this.child,
  });

  final String seed;
  final IconData icon;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: gradientFor(seed, theme.colorScheme),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            right: -40,
            bottom: -30,
            child: Icon(
              icon,
              size: 220,
              color: Colors.white.withValues(alpha: 0.14),
            ),
          ),
          Positioned(
            left: -30,
            top: -20,
            child: Icon(
              icon,
              size: 120,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          if (child != null) Padding(padding: const EdgeInsets.all(20), child: child),
        ],
      ),
    );
  }
}

/// Compact stat: icon + big value + caption. Used on profile and detail views.
class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Large highlighted destination card (~220x280) with a colorful gradient.
class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination, this.onTap});

  final Destination destination;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        height: 280,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: gradientFor(destination.id, theme.colorScheme),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -30,
              bottom: -20,
              child: Icon(
                Icons.travel_explore_rounded,
                size: 160,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RatingBadge(rating: destination.rating, onDark: true),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    destination.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.place_rounded,
                        size: 16,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination.country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      destination.priceLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF0E7490),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vertical experience row: gradient thumbnail + title, location, rating/price.
class ExperienceTile extends StatelessWidget {
  const ExperienceTile({super.key, required this.destination, this.onTap});

  final Destination destination;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: gradientFor(destination.id, theme.colorScheme),
                ),
                child: const Icon(
                  Icons.hiking_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      destination.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.place_rounded,
                          size: 15,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            destination.country,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.star_rounded,
                          size: 17,
                          color: Color(0xFFFACC15),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination.rating.toStringAsFixed(1),
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          destination.priceLabel,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A traveller review card (author avatar, stars, comment).
class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.author,
    required this.initials,
    required this.rating,
    required this.date,
    required this.comment,
    this.trip = '',
  });

  final String author;
  final String initials;
  final double rating;
  final String date;
  final String comment;
  final String trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  initials,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      author,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      trip.isEmpty ? date : '$trip · $date',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              RatingStars(rating: rating, size: 15),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            comment,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Row of the price breakdown; [emphasize] renders the total in bold/primary.
class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = emphasize
        ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)
        : theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          );
    final valueStyle = emphasize
        ? theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          )
        : theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

/// Bottom navigation shared by the four primary tabs.
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onSelect,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded),
          label: 'Explorar',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search_rounded),
          label: 'Buscar',
        ),
        NavigationDestination(
          icon: Icon(Icons.card_travel_outlined),
          selectedIcon: Icon(Icons.card_travel_rounded),
          label: 'Viagens',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Perfil',
        ),
      ],
    );
  }
}

/// Hand-drawn city map used on the hotel detail screen (no network tiles).
class MapSketch extends StatelessWidget {
  const MapSketch({super.key, this.height = 180});

  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CustomPaint(painter: _MapPainter(scheme)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 40,
                    color: scheme.primary,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.surface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Você está aqui',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  _MapPainter(this.scheme);

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = scheme.surfaceContainerHighest;
    canvas.drawRect(Offset.zero & size, bg);

    // Park / green block.
    final park = Paint()..color = scheme.primary.withValues(alpha: 0.16);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.08, size.height * 0.1,
            size.width * 0.3, size.height * 0.32),
        const Radius.circular(12),
      ),
      park,
    );
    // Water block.
    final water = Paint()..color = scheme.tertiary.withValues(alpha: 0.18);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.62, size.height * 0.55,
            size.width * 0.42, size.height * 0.5),
        const Radius.circular(16),
      ),
      water,
    );

    // Street grid.
    final street = Paint()
      ..color = scheme.outlineVariant.withValues(alpha: 0.7)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    for (var i = 1; i < 4; i++) {
      final dy = size.height * i / 4;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), street);
    }
    for (var i = 1; i < 5; i++) {
      final dx = size.width * i / 5;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), street);
    }

    // Highlighted avenue (diagonal).
    final avenue = Paint()
      ..color = scheme.primary.withValues(alpha: 0.55)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.2),
      avenue,
    );
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

/// Hand-drawn QR-style code used on the voucher screen (deterministic).
class QrSketch extends StatelessWidget {
  const QrSketch({super.key, required this.data, this.size = 168});

  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CustomPaint(painter: _QrPainter(data)),
    );
  }
}

class _QrPainter extends CustomPainter {
  _QrPainter(this.data);

  final String data;

  @override
  void paint(Canvas canvas, Size size) {
    const modules = 25;
    final cell = size.width / modules;
    final paint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;
    final seed = data.hashCode;

    for (var r = 0; r < modules; r++) {
      for (var c = 0; c < modules; c++) {
        if (_inFinder(r, c, modules)) continue;
        final v = (r * 49297 + c * 233280 + seed) % 100;
        if (v.abs() < 48) {
          canvas.drawRect(
            Rect.fromLTWH(c * cell, r * cell, cell, cell),
            paint,
          );
        }
      }
    }

    _drawFinder(canvas, cell, 0, 0);
    _drawFinder(canvas, cell, 0, modules - 7);
    _drawFinder(canvas, cell, modules - 7, 0);
  }

  bool _inFinder(int r, int c, int modules) {
    bool box(int or, int oc) =>
        r >= or && r < or + 8 && c >= oc && c < oc + 8;
    return box(0, 0) || box(0, modules - 8) || box(modules - 8, 0);
  }

  void _drawFinder(Canvas canvas, double cell, int or, int oc) {
    final dark = Paint()..color = const Color(0xFF0F172A);
    final light = Paint()..color = Colors.white;
    void square(int r, int c, int span, Paint p) {
      canvas.drawRect(
        Rect.fromLTWH(
          (oc + c) * cell,
          (or + r) * cell,
          span * cell,
          span * cell,
        ),
        p,
      );
    }

    square(0, 0, 7, dark);
    square(1, 1, 5, light);
    square(2, 2, 3, dark);
  }

  @override
  bool shouldRepaint(covariant _QrPainter oldDelegate) =>
      oldDelegate.data != data;
}
