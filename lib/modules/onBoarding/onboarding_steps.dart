import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:ecommerce_app/utils/navigation_service.dart';
import 'package:ecommerce_app/utils/route_constants.dart';
import 'package:ecommerce_app/utils/sharedpref_singleton.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    _pageController = PageController();
    _currentPage = 0;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _setOnBoardingDone,
                  child: const Text('Skip'),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: OnboardingPage.values.length,
                itemBuilder: (context, index) {
                  final OnboardingPage page = OnboardingPage.values[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        page.imagePath,
                        height: 260,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        page.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _currentPage > 0 ? 1 : 0,
                  child: TextButton(
                      onPressed: _prevPage, child: const Text('Prev')),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    OnboardingPage.values.length,
                    (index) => AnimatedIndicator(
                      isSelected: index == _currentPage,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _currentPage == OnboardingPage.values.length - 1
                      ? _setOnBoardingDone
                      : _nextPage,
                  child: Text(_currentPage == OnboardingPage.values.length - 1
                      ? 'Done'
                      : 'Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
//--------------------- Class Methods -----------------------------------------

  void _setOnBoardingDone() {
    SharedPrefSingleton.setData(
        SharedPrefKeyConstant.onBoarding, false);
    NavigationService.navigateToAndRemoveUntil(RouteConstants.signIn);
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < OnboardingPage.values.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

}

// Keep the AnimatedIndicator class as it was before

class AnimatedIndicator extends StatelessWidget {
  final bool isSelected;

  const AnimatedIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 10,
        width: isSelected ? 60 : 10,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}

enum OnboardingPage {
  first(
    title: 'Choose Products',
    imagePath: 'assets/images/onBoarding/chooseProducts.png',
    description: 'Discover amazing features that will make your life easier.',
  ),
  second(
    title: 'Make Payment',
    imagePath: 'assets/images/onBoarding/getOrder.png',
    description: 'Our intuitive interface ensures a smooth user experience.',
  ),
  third(
    title: 'Get Your Order',
    imagePath: 'assets/images/onBoarding/makePayment.png',
    description: 'Ready to begin? Let\'s dive in and explore the app!',
  );

  final String title;
  final String imagePath;
  final String description;

  const OnboardingPage({
    required this.title,
    required this.imagePath,
    required this.description,
  });
}
