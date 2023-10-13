import 'package:equatable/equatable.dart';
import 'package:shop_helper/data/model/product_model.dart';
import 'package:shop_helper/data/model/status.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.status,
    required this.products,
    this.product,
    required this.isExists,
    required this.statusText,
    required this.id,
  });

  final FormStatus status;
  final List<ProductModel> products;
  final ProductModel? product;
  final String statusText;
  final bool isExists;
  final int id;

  ProductState copyWith({
    FormStatus? status,
    List<ProductModel>? products,
    ProductModel? product,
    String? statusText,
    bool? isExists,
    int? id,
  }) =>
      ProductState(
        id: id ?? this.id,
        status: status ?? this.status,
        products: products ?? this.products,
        isExists: isExists ?? this.isExists,
        statusText: statusText ?? this.statusText,
        product: product ?? this.product,
      );

  @override
  List<Object?> get props =>
      [status, products, statusText, isExists, id, product];
}
