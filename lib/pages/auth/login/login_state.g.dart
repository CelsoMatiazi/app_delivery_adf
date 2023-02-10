// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LoginStatusMatch on LoginStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() login,
      required T Function() success,
      required T Function() error,
      required T Function() loginError}) {
    final v = this;
    if (v == LoginStatus.initial) {
      return initial();
    }

    if (v == LoginStatus.login) {
      return login();
    }

    if (v == LoginStatus.success) {
      return success();
    }

    if (v == LoginStatus.error) {
      return error();
    }

    if (v == LoginStatus.loginError) {
      return loginError();
    }

    throw Exception('LoginStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? login,
      T Function()? success,
      T Function()? error,
      T Function()? loginError}) {
    final v = this;
    if (v == LoginStatus.initial && initial != null) {
      return initial();
    }

    if (v == LoginStatus.login && login != null) {
      return login();
    }

    if (v == LoginStatus.success && success != null) {
      return success();
    }

    if (v == LoginStatus.error && error != null) {
      return error();
    }

    if (v == LoginStatus.loginError && loginError != null) {
      return loginError();
    }

    return any();
  }
}
