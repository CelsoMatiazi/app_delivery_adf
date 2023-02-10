import 'package:flutter/material.dart';
import 'package:vakinha_burguer/core/ui/helpers/size_extensions.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';

import '../../core/ui/widgets/delivery_button.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: context.percentHeight(.2),),
              Image.asset('assets/images/logo_rounded.png'),
              const SizedBox(height: 10),
              Text("Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido",
                textAlign: TextAlign.center,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 40),
              DeliveryButton(
                width: context.percentWidth(.8),
                label: "FECHAR",
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
