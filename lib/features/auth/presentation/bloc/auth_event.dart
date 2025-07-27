import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;
  final String? phoneNumber;
  final String? address;
  final String? sector;

  const AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.displayName,
    this.phoneNumber,
    this.address,
    this.sector,
  });

  @override
  List<Object?> get props => [email, password, displayName, phoneNumber, address, sector];
}

class AuthGoogleSignInRequested extends AuthEvent {}

class AuthPhoneVerificationRequested extends AuthEvent {
  final String phoneNumber;

  const AuthPhoneVerificationRequested({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class AuthPhoneCodeVerificationRequested extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const AuthPhoneCodeVerificationRequested({
    required this.verificationId,
    required this.smsCode,
  });

  @override
  List<Object> get props => [verificationId, smsCode];
}

class AuthSignOutRequested extends AuthEvent {}

class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  const AuthPasswordResetRequested({required this.email});

  @override
  List<Object> get props => [email];
}