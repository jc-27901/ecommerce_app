part of 'package:ecommerce_app/modules/homePage/home_page.dart';

class FilterButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
                color: const Color(0xffBBBBBB).withOpacity(0.6),
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: .3),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(width: 4.0),
            Icon(icon, color: Colors.black, size: 18),
          ],
        ),
      ),
    );
  }
}
