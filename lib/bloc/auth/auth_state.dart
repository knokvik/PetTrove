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
class RegisterState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const RegisterState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  // Factory constructor for initial state
  factory RegisterState.initial() {
    return const RegisterState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  // Copy with method to modify state values
  RegisterState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
