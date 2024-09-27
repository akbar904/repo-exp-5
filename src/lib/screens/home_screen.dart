
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/widgets/animal_widget.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Animal Switcher'),
			),
			body: Center(
				child: BlocBuilder<AnimalCubit, Animal>(
					builder: (context, state) {
						return GestureDetector(
							onTap: () => context.read<AnimalCubit>().toggleAnimal(),
							child: AnimalWidget(animal: state),
						);
					},
				),
			),
		);
	}
}
