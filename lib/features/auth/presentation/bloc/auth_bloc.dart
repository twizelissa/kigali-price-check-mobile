import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/firebase_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthGoogleSignInRequested>(_onAuthGoogleSignInRequested);
    on<AuthPhoneVerificationRequested>(_onAuthPhoneVerificationRequested);
    on<AuthPhoneCodeVerificationRequested>(_onAuthPhoneCodeVerificationRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);

    // Listen to auth state changes
    FirebaseService.authStateChanges.listen((user) {
      if (user != null) {
        add(AuthCheckRequested());
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = FirebaseService.currentUser;
      if (user != null) {
        final userEntity = await FirebaseService.getUserDocument(user.uid);
        if (userEntity != null) {
          emit(AuthAuthenticated(user: userEntity));
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await FirebaseService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // Auth state change will trigger AuthCheckRequested
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseService.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (credential.user != null) {
        await FirebaseService.createOrUpdateUserDocument(
          credential.user!,
          displayName: event.displayName,
          phoneNumber: event.phoneNumber,
          address: event.address,
          sector: event.sector,
        );
      }
      // Auth state change will trigger AuthCheckRequested
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await FirebaseService.signInWithGoogle();
      // Auth state change will trigger AuthCheckRequested
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthPhoneVerificationRequested(
    AuthPhoneVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await FirebaseService.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification completed
          emit(AuthPhoneVerificationCompleted());
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(message: e.message ?? 'Phone verification failed'));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthPhoneVerificationCodeSent(
            verificationId: verificationId,
            phoneNumber: event.phoneNumber,
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthPhoneCodeVerificationRequested(
    AuthPhoneCodeVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final currentUser = FirebaseService.currentUser;
      
      if (currentUser != null) {
        // Link phone number to existing account
        await FirebaseService.linkPhoneNumber(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
      } else {
        // Sign in with phone credential
        await FirebaseService.signInWithPhoneCredential(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
      }
      // Auth state change will trigger AuthCheckRequested
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await FirebaseService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await FirebaseService.sendPasswordResetEmail(event.email);
      emit(AuthPasswordResetEmailSent());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}