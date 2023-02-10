
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer/core/extensions/formatter_extension.dart';
import 'package:vakinha_burguer/core/ui/helpers/size_extensions.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_increment_decremente_button.dart';
import 'package:vakinha_burguer/dto/order_product_dto.dart';
import 'package:vakinha_burguer/models/product_model.dart';
import 'package:vakinha_burguer/pages/product_detail/product_detail_controller.dart';

import '../../core/ui/base_state/base_state.dart';

class ProductDetailPage extends StatefulWidget {

  final ProductModel product;
  final OrderProductDto? order;

  const ProductDetailPage({
    super.key,
    required this.product,
    this.order,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {

  @override
  void initState() {
    super.initState();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirmDelete(int amount){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: const Text("Deseja excluir o produto?"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar',
                    style: context.textStyles.textBold.copyWith(color: Colors.red),
                  )
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.of(context).pop(
                      OrderProductDto(
                          product: widget.product,
                          amount: amount
                      )
                    );
                  },
                  child: Text('Confirmar',
                    style: context.textStyles.textBold,
                  )
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: DeliveryAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: context.screenWidth,
              height: context.percentHeight(.4),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.image),
                  fit: BoxFit.cover
                )
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.product.name, style: context.textStyles.textExtraBold.copyWith(fontSize: 22),),
            ),

            const SizedBox(height: 10,),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                    child: Text(widget.product.description, style: context.textStyles.textRegular.copyWith(fontSize: 17),)
                ),
              ),
            ),


            const Divider(),
            SizedBox(
              height: 68,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<ProductDetailController, int>(
                          builder: (context, amount) {
                            return DeliveryIncrementDecrementButton(
                              amount: amount,
                              incrementTap: (){ controller.increment(); },
                              decrementTap: (){ controller.decrement(); },
                            );
                          }
                        ),
                      )
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<ProductDetailController, int>(
                        builder: (context, amount) {
                          return ElevatedButton(
                              style: amount == 0
                                  ? ElevatedButton.styleFrom(backgroundColor: Colors.red)
                                  : null,
                              onPressed: (){

                                if(amount ==0){
                                  _showConfirmDelete(amount);
                                }else{
                                  Navigator.of(context).pop(
                                      OrderProductDto(
                                          product: widget.product,
                                          amount: amount
                                      )
                                  );
                                }



                              },
                              child: FittedBox(
                                child: Visibility(
                                  visible: amount > 0,
                                  replacement: Text('Excluir Produto', style: context.textStyles.textExtraBold,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text("Adicionar", style: context.textStyles.textExtraBold.copyWith(fontSize: 15),),
                                      const SizedBox(width: 10,),
                                      Text(
                                        (widget.product.price * amount).currencyPTBR,
                                        style: context.textStyles.textExtraBold.copyWith(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          );
                        }
                      ),
                    ),
                  )
                ],
              ),
            )


          ],
        ),
      )
    );
  }
}
