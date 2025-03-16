import 'package:equatable/equatable.dart';
import 'package:pettrove/models/pets.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}

//--------------------------------------------------

// register_event.dart
abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  List<Pet> pets;

  RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.pets
  });
}

class VerificationCompleted extends RegisterEvent {} // ✅ New event

class ResetVerificationStatus extends RegisterEvent {}
