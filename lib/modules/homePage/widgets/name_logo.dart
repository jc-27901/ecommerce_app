part of 'package:ecommerce_app/modules/homePage/home_page.dart';

class NameLogo extends StatelessWidget {
  const NameLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/homePage/stylishLogo.png'),
        const SizedBox(width: 8.0),
        const Text(
          'Stylish',
          style: TextStyle(color: Color(0xff4392F9)),
        )
      ],
    );
  }
}