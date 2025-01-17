
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState.initial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, isFailure: false));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, isFailure: false));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));

      try {
        final isSuccess = await authRepository.authenticate(
          email: state.email,
          password: state.password,
        );
        if (isSuccess) {
          print("Bloc: Emitting LoginSuccess State");
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } else {
          print("Bloc: Emitting LoginFailure State");
          emit(state.copyWith(isSubmitting: false, isFailure: true));
        }
      } catch (_) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
// register_bloc.dart
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterState.initial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));

      try {
        final isSuccess = await authRepository.register(
          name: event.name,
          email: event.email,
          password: event.password,
          phone: event.phone,
        );

        if (isSuccess) {
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } else {
          emit(state.copyWith(isSubmitting: false, isFailure: true));
        }
      } catch (_) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
