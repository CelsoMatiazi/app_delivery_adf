
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burguer/core/exceptions/repository_exceptions.dart';
import 'package:vakinha_burguer/core/rest_client/custom_dio.dart';
import 'package:vakinha_burguer/dto/order_dto.dart';
import 'package:vakinha_burguer/models/payment_type_model.dart';
import 'package:vakinha_burguer/repositories/order/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository{

  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async  {
    try {
      final result = await dio.auth().get('/payment-types');
      return result.data.map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p)).toList();
    } on DioError catch (e,s) {
      log("Erro ao buscar forma de pagamento", error: e, stackTrace: s);
      throw RepositoryException(message:  "Erro ao buscar forma de pagamento");
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {

    try {
      await dio.auth().post('/orders', data: {
        'products' : order.products.map((e) => {
          'id' : e.product.id,
          'amount' : e.amount,
          'total_price' : e.totalPrice
        }).toList(),
        'user_id' : '#userAuthRef',
        'address' : order.address,
        'CPF' : order.document,
        'payment_method_id' : order.paymentMethodId
      });
    } on DioError catch (e,s) {
      log("Erro ao registrar o pedido", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao registrar o pedido");
    }
  }


}