import 'package:ecommerce_app/modules/authentication/logic/auth_cubit.dart';
import 'package:ecommerce_app/utils/navigation_service.dart';
import 'package:ecommerce_app/utils/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final AuthCubit cubit;

  @override
  void initState() {
    cubit = AuthCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.checkExistingAuth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: cubit,
        listener: (context, final AuthState state) {
          debugPrint('the states are $state');
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthAuthenticated) {
            // Navigate to home page or show success message
            NavigationService.navigateTo(RouteConstants.getStarted);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Use your google account to sign in',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 30.0),
              state is AuthLoading
                  ? const CircularProgressIndicator()
                  : FilledButton(
                      onPressed: () {
                        cubit.signInWithGoogle();
                      },
                      child: const Text('Google Sign In'),
                    )
            ],
          );
        },
      ),
    );
  }
}
