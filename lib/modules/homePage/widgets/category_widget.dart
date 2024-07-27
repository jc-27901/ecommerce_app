part of 'package:ecommerce_app/modules/homePage/home_page.dart';

class CategoriesRow extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoriesRow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                NavigationService.navigateTo(RouteConstants.searchListing);
              },
              child: CategoryItem(
                name: category['name'],
                icon: category['icon'],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const CategoryItem({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 4),
        Text(name),
      ],
    );
  }
}
