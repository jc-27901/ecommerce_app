import 'package:ecommerce_app/modules/authentication/logic/auth_cubit.dart';
import 'package:ecommerce_app/utils/navigation_service.dart';
import 'package:ecommerce_app/utils/route_constants.dart';
import 'package:ecommerce_app/utils/sharedpref_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part './widgets/name_logo.dart';
part './widgets/search_field.dart';
part './widgets/filter_buttons.dart';
part './widgets/category_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFDFDFD),
        appBar: AppBar(
          backgroundColor: const Color(0xffFDFDFD),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          centerTitle: true,
          title: const NameLogo(),
          actions: const [UserAccount()],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              const SearchField(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Featured',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      FilterButton(
                          name: 'Sort', icon: Icons.sort, onTap: () {}),
                      const SizedBox(width: 10.0),
                      FilterButton(
                          name: 'Filter',
                          icon: Icons.filter_alt_outlined,
                          onTap: () {}),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                    // color: Colors.grey,
                    borderRadius: BorderRadius.circular(6.0)),
                child: const CategoriesRow(
                  categories: [
                    {'name': 'Beauty', 'icon': Icons.face},
                    {'name': 'Fashion', 'icon': Icons.checkroom},
                    {'name': 'Kids', 'icon': Icons.child_care},
                    {'name': 'Men', 'icon': Icons.man},
                    {'name': 'Women', 'icon': Icons.woman},
                    {'name': 'Bags', 'icon': Icons.shopping_bag},
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// at present this widget is responsible for singing out user.
class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  late AuthCubit authCubit;

  @override
  void initState() {
    authCubit = AuthCubit();
    super.initState();
  }

  @override
  void dispose() {
    authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, final AuthState state) {
        if (state is AuthUnauthenticated) {
          SharedPrefSingleton.clearAll();
          NavigationService.navigateToAndRemoveUntil(RouteConstants.onBoarding);
        }
      },
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.account_circle),
        offset: const Offset(0, 30),
        onSelected: (String value) {
          authCubit.signOut();
        },
        initialValue: 'first',
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<String>(
              value: 'signout', // Set a value for this item
              child: Text('Sign out'),
            ),
          ];
        },
      )
      ,
    );
  }
}
