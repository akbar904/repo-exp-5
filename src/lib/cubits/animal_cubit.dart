
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:animal_switcher/models/animal_model.dart';

class AnimalCubit extends Cubit<Animal> {
	AnimalCubit() : super(Animal(name: 'Cat', icon: Icons.access_time));

	void toggleAnimal() {
		if (state.name == 'Cat') {
			emit(Animal(name: 'Dog', icon: Icons.person));
		} else {
			emit(Animal(name: 'Cat', icon: Icons.access_time));
		}
	}
}
