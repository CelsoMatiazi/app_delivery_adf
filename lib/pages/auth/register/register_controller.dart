

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:vakinha_burguer/pages/auth/register/register_state.dart';
import 'package:vakinha_burguer/pages/home/home_state.dart';
import '../../../repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState>{

  final AuthRepository _authRepository;

  RegisterController(this._authRepository) : super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {

    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authRepository.register(name, email, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, s) {
      log("Erro ao registrar o usuario",error: e, stackTrace: s );
      emit(state.copyWith(status: RegisterStatus.error));
    }

  }

}