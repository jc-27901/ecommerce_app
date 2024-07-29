import 'package:ecommerce_app/models/category_dm.dart';
import 'package:ecommerce_app/modules/authentication/logic/auth_cubit.dart';
import 'package:ecommerce_app/modules/homePage/logic/home_screen_cubit.dart';
import 'package:ecommerce_app/utils/navigation_service.dart';
import 'package:ecommerce_app/utils/route_constants.dart';
import 'package:ecommerce_app/utils/sharedpref_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part './widgets/name_logo.dart';
part './widgets/search_field.dart';
part './widgets/filter_buttons.dart';
part './widgets/category_widget.dart';
part './widgets/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeScreenCubit cubit;

  late List<CategoryDm> categoriesList;

  @override
  void initState() {
    cubit = HomeScreenCubit();
    categoriesList = List.empty(growable: true);
    cubit.fetchCategories();
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
          leading: IconButton(
            onPressed: () {
              cubit.fetchCategories();
            },
            icon: const Icon(Icons.menu),
          ),
          centerTitle: true,
          title: const NameLogo(),
          actions: const [UserAccount()],
        ),
        body: BlocConsumer<HomeScreenCubit, HomeScreenState>(
          bloc: cubit,
          listener: (context, final HomeScreenState state) {
            if (state is HomeScreenLoaded) {
              setState(() => categoriesList = state.categories);
            }
          },
          builder: (context, final HomeScreenState state) {
            if (state is HomeScreenLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchField(),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Featured',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
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
                  CategoriesRow(
                    categories: categoriesList,
                  )
                ],
              ),
            );
          },
        ));
  }
}
