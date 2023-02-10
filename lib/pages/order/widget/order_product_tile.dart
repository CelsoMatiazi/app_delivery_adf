import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burguer/core/extensions/formatter_extension.dart';
import 'package:vakinha_burguer/core/ui/styles/colors_app.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_increment_decremente_button.dart';
import 'package:vakinha_burguer/dto/order_product_dto.dart';
import 'package:vakinha_burguer/pages/order/order_controller.dart';

class OrderProductTile extends StatelessWidget {

  final int index;
  final OrderProductDto orderProduct;

  const OrderProductTile({
    super.key,
    required this.index,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    final product = orderProduct.product;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(product.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                    style: context.textStyles.textRegular.copyWith(fontSize: 16),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((orderProduct.amount * product.price).currencyPTBR, style: context.textStyles.textMedium.copyWith(
                          fontSize: 14,
                          color: context.colors.secondary),
                      ),

                      DeliveryIncrementDecrementButton.compact(
                          amount: orderProduct.amount,
                          incrementTap: (){
                            context.read<OrderController>().incrementProduct(index);
                          },
                          decrementTap: (){
                            context.read<OrderController>().decrementProduct(index);
                          }
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
