part of 'package:ecommerce_app/modules/homePage/home_page.dart';

class CategoriesRow extends StatelessWidget {
  final List<CategoryDm> categories;

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
                NavigationService.navigateTo(RouteConstants.searchListing,
                    arguments: category);
              },
              child: CategoryItem(
                name: category.name,
                icon: _getCategoryIcon(category.name),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    // You can define a mapping of category names to icons here
    switch (categoryName.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'fashion':
        return Icons.checkroom;
      default:
        return Icons.category;
    }
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
