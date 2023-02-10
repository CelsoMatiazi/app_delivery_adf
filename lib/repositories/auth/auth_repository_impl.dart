
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burguer/core/exceptions/repository_exceptions.dart';
import 'package:vakinha_burguer/core/exceptions/unauthorized_exception.dart';
import 'package:vakinha_burguer/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer/models/auth_model.dart';
import 'package:vakinha_burguer/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  final CustomDio dio;

  const AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String email, String password) async {

    try {
      final result = await dio.unAuth().post("/auth", data: {
        'email' : email,
        'password' : password
      });
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {

      if(e.response?.statusCode == 403){
        log('permissão negada', stackTrace: s, error: e);
        throw UnauthorizedException();
      }


      log('erro ao realizar login', stackTrace: s, error: e);
      throw RepositoryException(message: "erro ao realizar login");
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {

    try{
      await dio.unAuth().post('/users', data: {
        'name' : name,
        'email' : email,
        'password' : password
      });
    }on DioError catch (e, s){
      log('erro ao registrar usuario', stackTrace: s, error: e);
      throw RepositoryException(message: "erro ao registrar o usuario");

    }



  }


}