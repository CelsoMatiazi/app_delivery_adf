import 'package:flutter/material.dart';
import 'package:vakinha_burguer/core/global/global_context.dart';
import 'package:vakinha_burguer/core/provider/application_binding.dart';
import 'package:vakinha_burguer/core/ui/theme/theme_config.dart';

import 'package:vakinha_burguer/pages/auth/login/login_router.dart';
import 'package:vakinha_burguer/pages/auth/register/register_router.dart';
import 'package:vakinha_burguer/pages/home/home_router.dart';
import 'package:vakinha_burguer/pages/order/order_completed_page.dart';
import 'package:vakinha_burguer/pages/order/order_router.dart';
import 'package:vakinha_burguer/pages/product_detail/product_detail_router.dart';
import 'package:vakinha_burguer/pages/splash/splash_page.dart';
import 'core/config/env/env.dart';

void main() async {
  await Env.i.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _navKey = GlobalKey<NavigatorState>();

  MyApp({super.key}){
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBiding(
      child: MaterialApp(
        title: 'Delivery App',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        routes: {
          '/' : (context) => const SplashPage(),
          '/home' : (context) => HomeRouter.page,
          '/product_detail' : (context) => ProductDetailRouter.page,
          '/login' : (context) =>  LoginRouter.page,
          '/register' : (context) =>  RegisterRouter.page,
          '/order' : (context) =>  OrderRouter.page,
          '/order/completed' : (context) =>  const OrderCompletedPage(),
        },
      ),
    );
  }
}


