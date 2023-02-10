
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burguer/core/extensions/formatter_extension.dart';
import 'package:vakinha_burguer/core/ui/helpers/size_extensions.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer/pages/home/home_controller.dart';

import '../../../dto/order_product_dto.dart';


class ShoppingBagWidget extends StatelessWidget {

  final List<OrderProductDto> bag;

  const ShoppingBagWidget({
    super.key,
    required this.bag
  });

  @override
  Widget build(BuildContext context) {

    var totalBag = bag.fold<double>(0.0, (total, element) => total += element.totalPrice).currencyPTBR;

    Future<void> goOrder(context) async {
        final navigator = Navigator.of(context);
        final controller = Provider.of<HomeController>(context, listen: false);
        final sp = await SharedPreferences.getInstance();
        if(!sp.containsKey('accessToken')){
          final loginResult = await navigator.pushNamed('/login');
          if(loginResult == null || loginResult == false){
            return;
          }
        }

        final updateBag = await navigator.pushNamed('/order', arguments: bag);
        controller.updateBag(updateBag as List<OrderProductDto>);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      width: context.screenWidth,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ]
      ),
      child: ElevatedButton(
        onPressed: (){
          goOrder(context);
        },
        child: Stack(
          children:  [
            const Align(
              alignment: Alignment.centerLeft,
                child: Icon(Icons.shopping_cart_outlined)
            ),

            Align(
              alignment: Alignment.center,
                child: Text('Ver Sacola', style: context.textStyles.textExtraBold.copyWith(fontSize: 14),)
            ),

            Align(
                alignment: Alignment.centerRight,
                child: Text(totalBag, style: context.textStyles.textExtraBold.copyWith(fontSize: 11),)
            )
          ],
        ),
      ),
    );
  }
}
