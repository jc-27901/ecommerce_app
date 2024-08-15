import 'package:ecommerce_app/models/ProductDm.dart';
import 'package:ecommerce_app/models/category_dm.dart';
import 'package:ecommerce_app/modules/homePage/home_page.dart';
import 'package:ecommerce_app/modules/productListing/logic/product_list_cubit.dart';
import 'package:ecommerce_app/modules/searchListing/search_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListingPage extends StatefulWidget {
  final CategoryDm? selectedCat;

  const ProductListingPage({super.key, this.selectedCat});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  late final CategoryDm? category;

  late final ProductListCubit cubit;

  late List<ProductDm> productList;

  @override
  void initState() {
    category = widget.selectedCat;
    cubit = ProductListCubit();
    productList = List.empty(growable: true);
    cubit.fetchProducts();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFD),
      appBar: AppBar(
        backgroundColor: const Color(0xffFDFDFD),
        automaticallyImplyLeading: false,
        title: const SearchField(),
      ),
      body: BlocConsumer<ProductListCubit, ProductListState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ProductListLoaded) {
            setState(() => productList = state.products);
          }
        },
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Column(
            children: [
              const SearchListing(),
              Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: productList[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductDm product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
              color: const Color(0xffBBBBBB).withOpacity(0.6),
              offset: const Offset(0, 2),
              blurRadius: 2,
              spreadRadius: .3)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
              child: product.images != null
                  ? Image.network(
                      product.images!.first.images,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.lightBlue,
                      height: 120,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description ?? '',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${product.price}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StarRating(
                        rating:
                            product.ratings?.averageRating?.toDouble() ?? 0),
                    const SizedBox(width: 4),
                    Text(
                      '${product.reviews?.length}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(index < rating.floor() ? Icons.star : Icons.star_border,
            color: Colors.amber, size: 16);
      }),
    );
  }
}
