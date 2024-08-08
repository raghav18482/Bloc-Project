import 'package:bloc_project/features/home/bloc/home_bloc.dart';
import 'package:bloc_project/features/home/models/home_product_data_model.dart';
import 'package:bloc_project/features/home/ui/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  testWidgets('ProductTileWidget displays correctly and triggers event on button tap', (WidgetTester tester) async {
    // Arrange
    final mockHomeBloc = MockHomeBloc();
    final productDataModel = ProductDataModel(
      name: 'Test Product',
      description: 'This is a test product description.',
      price: 99.99,
      imageUrl: 'https://static1.smartbear.co/smartbearbrand/media/images/blog/api-design-first-workflow.png', id: '2',
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductTileWidget(
            productDataModel: productDataModel,
            homeBloc: mockHomeBloc,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('This is a test product description.'), findsOneWidget);
    expect(find.text('\$99.99'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.task_outlined), findsOneWidget);

    // Tap the IconButton and verify that the correct event is dispatched
    await tester.tap(find.byKey(Key('cartButton')));
    await tester.pumpAndSettle(); // Ensures the UI updates

    // Verify the event
    verify(mockHomeBloc.add(HomeInitialEvent())).called(1);
  });
}

