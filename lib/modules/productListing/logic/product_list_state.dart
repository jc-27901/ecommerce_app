part of 'product_list_cubit.dart';

@immutable
sealed class ProductListState {}

final class ProductListInitial extends ProductListState {}

final class ProductListLoading extends ProductListState {}

final class ProductListLoaded extends ProductListState {
  final List<ProductDm> products;

  ProductListLoaded({required this.products});
}

final class ProductListFailed extends ProductListState {}