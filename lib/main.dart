import 'package:ecommerce_app/modules/authentication/authentication_page.dart';
import 'package:ecommerce_app/modules/get_started.dart';
import 'package:ecommerce_app/modules/homePage/home_page.dart';
import 'package:ecommerce_app/modules/onBoarding/onboarding_steps.dart';
import 'package:ecommerce_app/modules/searchListing/search_listing.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:ecommerce_app/utils/firebase_options.dart';
import 'package:ecommerce_app/utils/navigation_service.dart';
import 'package:ecommerce_app/utils/route_constants.dart';
import 'package:ecommerce_app/utils/sharedpref_singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefSingleton.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: _initialScreen,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteConstants.onBoarding:
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case RouteConstants.signIn:
            return MaterialPageRoute(
                builder: (_) => const AuthenticationPage());
          case RouteConstants.getStarted:
            return MaterialPageRoute(builder: (_) => const GetStarted());
          case RouteConstants.homePage:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case RouteConstants.searchListing:
            return MaterialPageRoute(builder: (_) => const SearchListing());
          default:
            return MaterialPageRoute(
                builder: (_) => const AuthenticationPage());
        }
      },
    );
  }

  StatefulWidget get _initialScreen {
    return (SharedPrefSingleton.getData(SharedPrefKeyConstant.onBoarding) ??
            true)
        ? const OnboardingScreen()
        : const AuthenticationPage();
  }
}
