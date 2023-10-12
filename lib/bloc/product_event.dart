import 'package:equatable/equatable.dart';
import 'package:shop_helper/data/model/product_model.dart';

abstract class ProductEvent extends Equatable {}

class AddProduct extends ProductEvent {
  AddProduct({required this.newProduct});

  final ProductModel newProduct;

  @override
  List<Object?> get props => [newProduct];
}

class GetProduct extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class ExistProduct extends ProductEvent {
  final String barcode;

  ExistProduct({required this.barcode});

  @override
  List<Object?> get props => [barcode];
}

class UpdateProduct extends ProductEvent {
  UpdateProduct({required this.barcode, required this.count});

  final String barcode;
  final String count;

  @override
  List<Object?> get props => [count, barcode];
}

class DeleteProduct extends ProductEvent {
  DeleteProduct({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
