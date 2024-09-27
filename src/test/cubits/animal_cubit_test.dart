
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal_model.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Animal(name: "Cat", icon: Icons.access_time)', () {
			expect(animalCubit.state, Animal(name: 'Cat', icon: Icons.access_time));
		});

		blocTest<AnimalCubit, Animal>(
			'emits [Animal(name: "Dog", icon: Icons.person)] when toggleAnimal is called on initial state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: 'Dog', icon: Icons.person)],
		);

		blocTest<AnimalCubit, Animal>(
			'emits [Animal(name: "Cat", icon: Icons.access_time)] when toggleAnimal is called on Dog state',
			build: () {
				animalCubit.emit(Animal(name: 'Dog', icon: Icons.person));
				return animalCubit;
			},
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: 'Cat', icon: Icons.access_time)],
		);
	});
}
