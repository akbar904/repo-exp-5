
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/main.dart';

class MockAnimalCubit extends MockCubit<String> implements AnimalCubit {}

void main() {
	group('Main', () {
		testWidgets('Initial setup and HomeScreen rendering', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(MyApp());
			
			// Act
			await tester.pumpAndSettle();
			
			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		blocTest<MockAnimalCubit, String>(
			'Initial state is "Cat"',
			build: () => mockAnimalCubit,
			verify: (_) {
				expect(mockAnimalCubit.state, 'Cat');
			},
		);

		blocTest<MockAnimalCubit, String>(
			'Emits "Dog" when toggleAnimal is called',
			build: () => mockAnimalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => ['Dog'],
		);
	});

	group('HomeScreen', () {
		// Test to verify initial state and widget layout
		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			// Arrange
			final mockAnimalCubit = MockAnimalCubit();
			when(() => mockAnimalCubit.state).thenReturn('Cat');
			
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		// Test to verify state change on tapping the text
		testWidgets('displays Dog with person icon when text is tapped', (WidgetTester tester) async {
			// Arrange
			final mockAnimalCubit = MockAnimalCubit();
			when(() => mockAnimalCubit.state).thenReturn('Cat');
			
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			// Act
			// Simulate the toggleAnimal method call inside the cubit
			whenListen(mockAnimalCubit, Stream.fromIterable(['Dog']));
			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
