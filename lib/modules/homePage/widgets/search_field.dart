part of 'package:ecommerce_app/modules/homePage/home_page.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

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
              spreadRadius: .3),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Search any Product..',
            hintStyle: const TextStyle(
                color: Color(0xffBBBBBB),
                fontSize: 16,
                fontWeight: FontWeight.w400),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xffBBBBBB),
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 0.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
}