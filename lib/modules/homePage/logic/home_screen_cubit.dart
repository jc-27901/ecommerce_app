import 'package:ecommerce_app/models/category_dm.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  void fetchCategories() async {
    emit(HomeScreenLoading());
    try {
      final DatabaseEvent event = await _database.ref('categories').once();
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        final Map<dynamic, dynamic> categoriesData = snapshot.value as Map<dynamic, dynamic>;
        final List<CategoryDm> categories = List.empty(growable: true);

        // Iterate through the map and build the categories list
        categoriesData.forEach((key, value) {
          categories.add(CategoryDm.fromMap(key, value));
        });

        emit(HomeScreenLoaded(categories));

      }
    } catch (e) {
      emit(HomeScreenError());
    }
  }

}
