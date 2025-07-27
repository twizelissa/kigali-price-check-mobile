import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthPhoneVerificationCodeSent extends AuthState {
  final String verificationId;
  final String phoneNumber;

  const AuthPhoneVerificationCodeSent({
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [verificationId, phoneNumber];
}

class AuthPhoneVerificationCompleted extends AuthState {}

class AuthPasswordResetEmailSent extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}