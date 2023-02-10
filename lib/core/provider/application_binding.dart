
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer/repositories/auth/auth_repository.dart';

import '../../repositories/auth/auth_repository_impl.dart';

class ApplicationBiding extends StatelessWidget {

  final Widget child;

  const ApplicationBiding({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => CustomDio()),
          Provider<AuthRepository>(create: (context) => AuthRepositoryImpl(dio: context.read() )),
        ],
        child: child,
    );
  }
}
