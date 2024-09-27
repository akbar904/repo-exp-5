
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/widgets/animal_widget.dart';

// Mock classes
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalWidget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			// Arrange
			final animal = Animal(name: 'Cat', icon: Icons.access_time);
			when(() => animalCubit.state).thenReturn(animal);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalWidget(),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after toggle', (WidgetTester tester) async {
			// Arrange
			final initialAnimal = Animal(name: 'Cat', icon: Icons.access_time);
			final toggledAnimal = Animal(name: 'Dog', icon: Icons.person);
			whenListen(
				animalCubit,
				Stream.fromIterable([initialAnimal, toggledAnimal]),
				initialState: initialAnimal,
			);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalWidget(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
