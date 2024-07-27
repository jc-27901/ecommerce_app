import 'package:ecommerce_app/modules/homePage/home_page.dart';
import 'package:flutter/material.dart';

class SearchListing extends StatefulWidget {
  const SearchListing({super.key});

  @override
  State<SearchListing> createState() => _SearchListingState();
}

class _SearchListingState extends State<SearchListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFD),
      appBar: AppBar(
        backgroundColor: const Color(0xffFDFDFD),
        automaticallyImplyLeading: false,
        title: const SearchField(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Featured',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    FilterButton(name: 'Sort', icon: Icons.sort, onTap: () {}),
                    const SizedBox(width: 10.0),
                    FilterButton(
                        name: 'Filter',
                        icon: Icons.filter_alt_outlined,
                        onTap: () {}),
                  ],
                )
              ],
            ),
            Expanded(child: ProductListingPage()),
          ],
        ),
      ),
    );
  }
}

class ProductListingPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Black Winter",
      description: "Autumn And Winter Casual cotton-padded jacket",
      price: 499,
      // imageUrl: "assets/black_winter.jpg",
      rating: 4.5,
      reviewCount: 6890,
    ),
    Product(
      name: "Mens Starry",
      description: "Mens Starry Sky Printed Shirt 100% Cotton Fabric",
      price: 399,
      // imageUrl: "assets/mens_starry.jpg",
      rating: 4.5,
      reviewCount: 152344,
    ),
    Product(
      name: "Black Dress",
      description: "Solid Black Dress for Women, Sexy Chain Shorts Ladi",
      price: 2000,
      // imageUrl: "assets/black_dress.jpg",
      rating: 4.5,
      reviewCount: 523456,
    ),
    Product(
      name: "Pink Embroide",
      description: "EARTHEN Rose Pink Embroidered Tiered Max",
      price: 1900,
      // imageUrl: "assets/pink_embroide.jpg",
      rating: 4.5,
      reviewCount: 45678,
    ),
  ];

  ProductListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

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
              child: product.imageUrl != null
                  ? Image.asset(
                      product.imageUrl!,
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
                  product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
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
                    StarRating(rating: product.rating),
                    const SizedBox(width: 4),
                    Text(
                      '${product.reviewCount}',
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

class Product {
  final String name;
  final String description;
  final int price;
  final String? imageUrl;
  final double rating;
  final int reviewCount;

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });
}
