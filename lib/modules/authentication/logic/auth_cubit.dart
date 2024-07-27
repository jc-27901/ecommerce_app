import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instanceFor(app: Firebase.app());
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthCubit() : super(AuthInitial());

  Future<void> checkExistingAuth() async {
    try {
      emit(AuthLoading());
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        // User is already signed in
        emit(AuthAuthenticated(user));
      } else {
        // No user is signed in
        emit(const AuthUnauthenticated('Unauthenticated User'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(const AuthUnauthenticated('Unauthenticated User'));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // You can make an HTTP request here if needed
        // Example: final response = await http.get(Uri.parse('https://api.example.com/user/${user.uid}'));

        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated('Unauthenticated User'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      emit(const AuthUnauthenticated('Unauthenticated User'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
