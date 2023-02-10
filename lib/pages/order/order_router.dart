
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer/pages/order/order_controller.dart';
import 'package:vakinha_burguer/pages/order/order_page.dart';
import 'package:vakinha_burguer/repositories/order/order_reposiroty_impl.dart';
import 'package:vakinha_burguer/repositories/order/order_repository.dart';

class OrderRouter{

  OrderRouter._();

  static Widget get page => MultiProvider(
      providers: [
        Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(dio: context.read())
        ),
        Provider(
            create: (context) => OrderController(context.read())
        )
      ],
      child: const OrderPage(),
  );
}