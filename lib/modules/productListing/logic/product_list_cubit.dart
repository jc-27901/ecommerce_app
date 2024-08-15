import 'package:ecommerce_app/models/ProductDm.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show immutable;

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> fetchProducts({String? categoryId}) async {
    emit(ProductListLoading());
    try {
      final DatabaseEvent event = await _database.ref('products').once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> productsData =
            snapshot.value as Map<dynamic, dynamic>;
        final List<ProductDm> products = [];

        productsData.forEach((key,value){
          products.add(ProductDm.fromJson(value));
        });

        emit(ProductListLoaded(products: products));
      } else {
        emit(ProductListFailed());
      }
    } catch (e) {
      emit(ProductListFailed());
    }
  }
}
