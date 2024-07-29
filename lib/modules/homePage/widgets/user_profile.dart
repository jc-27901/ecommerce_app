part of 'package:ecommerce_app/modules/homePage/home_page.dart';

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