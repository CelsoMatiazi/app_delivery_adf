import 'package:flutter/material.dart';
import 'package:vakinha_burguer/core/ui/helpers/size_extensions.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_button.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ColoredBox(
        color: const Color(0xff140E0E),
        child: Stack(
          children: [
            
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                  child: Image.asset('assets/images/lanche.png',
                    fit: BoxFit.cover,
                  )
              ),
            ),
            
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: context.percentHeight(.30),
                  ),
                  
                  Image.asset('assets/images/logo.png'),

                  const SizedBox(height: 80,),
                  DeliveryButton(
                      width: context.percentWidth(.6),
                      height: 40,
                      label: "ACESSAR",
                      onPressed: (){
                        Navigator.of(context).popAndPushNamed('/home');
                      }
                  )
                ],
              ),
            )
            
            
          ],
        ),
      ),
    );
  }
}
