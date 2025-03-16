import 'dart:ffi';

import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [email, password, isSubmitting, isSuccess, isFailure];
}

// register_state.dart
class RegisterState{
  final bool isVerifying;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isVerified; // ✅ Add this

  const RegisterState({
    required this.isVerifying,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isVerified, // ✅ Initialize
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isVerifying: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isVerified: false, // ✅ Set default false
    );
  }

  RegisterState copyWith({
    bool? isVerifying,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isVerified, // ✅ Allow updating verified state
  }) {
    return RegisterState(
      isVerifying: isVerifying ?? this.isVerifying,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isVerified: isVerified ?? this.isVerified, // ✅ Keep or update verification status
    );
  }
}