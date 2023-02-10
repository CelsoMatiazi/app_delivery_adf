import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer/core/extensions/formatter_extension.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_burguer/dto/order_product_dto.dart';
import 'package:vakinha_burguer/models/payment_type_model.dart';
import 'package:vakinha_burguer/pages/order/order_controller.dart';
import 'package:vakinha_burguer/pages/order/order_state.dart';
import 'package:vakinha_burguer/pages/order/widget/order_field.dart';
import 'package:vakinha_burguer/pages/order/widget/order_product_tile.dart';
import 'package:vakinha_burguer/pages/order/widget/payment_types_field.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/base_state/base_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {


  final _formKey = GlobalKey<FormState>();
  final _addressCtrl = TextEditingController();
  final _documentCtrl = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    super.onReady();
    final products = ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Deseja excluir o produto ${state.orderProduct.product.name}?"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    controller.cancelDeleteProcess();
                  },
                  child: Text('Cancelar',
                    style: context.textStyles.textBold.copyWith(color: Colors.red),
                  )
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    controller.decrementProduct(state.index);

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
    return BlocListener<OrderController, OrderState>(
      listener: (context, state){
        state.status.matchAny(
            any: ()=> hideLoader(),
            loading: () => showLoader(),
            error: (){
              hideLoader();
              showError(state.errorMessage ?? 'Erro não informado');
            },
            confirmRemoveProduct: (){
              hideLoader();
              if(state is OrderConfirmDeleteProductState){
                _showConfirmProductDialog(state);
              }
            },
            emptyBag: () {
              showInfo("Sua sacola esta vazia, por favor selecione um produto para realizar seu pedido");
              Navigator.of(context).pop(<OrderProductDto>[]);
            },
            success: (){
              hideLoader();
              Navigator.of(context).popAndPushNamed('/order/completed', result: <OrderProductDto>[]);
            }
        );

      },
      child: WillPopScope(
        onWillPop: () async{
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
            appBar: DeliveryAppBar(),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: CustomScrollView(
                  slivers: [

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text("Carinho", style: context.textStyles.textTitle,),
                            IconButton(
                                onPressed: () => controller.emptyBag(),
                                icon: Image.asset("assets/images/trashRegular.png")
                            )
                          ],
                        ),
                      ),
                    ),

                    BlocSelector<OrderController, OrderState, List<OrderProductDto> >(
                      selector: (state) => state.orderProducts,
                      builder: (context, orderProducts) {
                        return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                    childCount: orderProducts.length,
                                    (context, index){
                                      final orderProduct = orderProducts[index];
                                      return Column(
                                        children: [
                                          OrderProductTile(
                                              index: index,
                                              orderProduct: orderProduct
                                          ),
                                          const Divider()
                                        ],
                                      );
                                    }
                            )
                        );
                      }
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total do pedido",
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 16),
                                ),
                                BlocSelector<OrderController, OrderState, double>(
                                  selector: (state) => state.totalOrder,
                                  builder: (context, totalOrder) {
                                    return Text(totalOrder.currencyPTBR,
                                      style: context.textStyles.textExtraBold
                                          .copyWith(fontSize: 20),
                                    );
                                  }
                                )
                              ],
                            ),
                          ),

                          const Divider(),


                          const SizedBox(height: 10,),
                          OrderField(
                            title: "Endereço de entrega",
                            controller: _addressCtrl,
                            validator: Validatorless.required("Endereço obrigatorio"),
                            hintText: "Digite um endereço",
                          ),

                          const SizedBox(height: 10,),
                          OrderField(
                            title: "CPF",
                            controller: _documentCtrl,
                            validator: Validatorless.required("CPF Obrigatorio"),
                            hintText: "Digite o CPF",
                          ),

                          const SizedBox(height: 20,),
                          BlocSelector<OrderController, OrderState, List<PaymentTypeModel>>(
                            selector: (state) => state.paymentTypes,
                            builder: (context, paymentTypes) {
                              return ValueListenableBuilder(
                                valueListenable: paymentTypeValid,
                                builder: (_, paymentTypeValidValue, child) {
                                  return PaymentTypesField(
                                      paymentTypes: paymentTypes,
                                      valueChange: (value){
                                        paymentTypeId = value;
                                      },
                                      valid: paymentTypeValidValue,
                                      valueSelected: paymentTypeId.toString(),
                                  );
                                }
                              );
                            }
                          ),

                        ],
                      ),
                    ),


                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DeliveryButton(
                                width: double.infinity,
                                height: 48,
                                label: "Finalizar",
                                onPressed: (){
                                  final valid = _formKey.currentState?.validate() ?? false;
                                  final paymentTypeSelected = paymentTypeId != null;
                                  paymentTypeValid.value = paymentTypeSelected;

                                  if(valid && paymentTypeSelected){
                                    controller.saveOrder(
                                        address: _addressCtrl.text,
                                        document: _documentCtrl.text,
                                        paymentMethodId: paymentTypeId!
                                    );
                                  }
                                }
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      )

    );
  }


}
