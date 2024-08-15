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
    return  Padding(
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
          ],
        ),
      );
  }
}

