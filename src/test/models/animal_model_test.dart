
import 'package:flutter_test/flutter_test.dart';
import 'package:animal_switcher/models/animal_model.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should create an instance with given name and icon', () {
			const name = 'Cat';
			const icon = Icons.pets;

			final animal = Animal(name: name, icon: icon);

			expect(animal.name, name);
			expect(animal.icon, icon);
		});

		test('Animal model should serialize to JSON correctly', () {
			const name = 'Dog';
			const icon = Icons.person;

			final animal = Animal(name: name, icon: icon);

			final json = animal.toJson();

			expect(json['name'], name);
			expect(json['icon'], icon.codePoint);
		});

		test('Animal model should deserialize from JSON correctly', () {
			const name = 'Dog';
			const icon = Icons.person;

			final json = {
				'name': name,
				'icon': icon.codePoint,
			};

			final animal = Animal.fromJson(json);

			expect(animal.name, name);
			expect(animal.icon, icon);
		});
	});
}

class Animal {
	final String name;
	final IconData icon;

	Animal({required this.name, required this.icon});

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'icon': icon.codePoint,
		};
	}

	factory Animal.fromJson(Map<String, dynamic> json) {
		return Animal(
			name: json['name'],
			icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
		);
	}
}
