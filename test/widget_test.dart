import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:travel/core/theme.dart';
import 'package:travel/data/repositories/destination_repository.dart';
import 'package:travel/ui/features/explore/view_models/explore_view_model.dart';
import 'package:travel/ui/features/explore/views/explore_screen.dart';

void main() {
  testWidgets('ExploreScreen renders header and seeded content',
      (tester) async {
    tester.view.physicalSize = const Size(500, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: ChangeNotifierProvider(
          create: (_) => ExploreViewModel(repository: DestinationRepository()),
          child: const ExploreScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Destinos populares'), findsOneWidget);
    expect(find.text('Rio de Janeiro'), findsOneWidget);
  });
}
