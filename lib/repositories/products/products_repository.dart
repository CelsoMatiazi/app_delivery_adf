import 'package:vakinha_burguer/models/product_model.dart';

abstract class ProductsRepository{
  Future<List<ProductModel>> findAllProducts();
}