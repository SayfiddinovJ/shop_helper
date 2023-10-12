import 'package:equatable/equatable.dart';
import 'package:shop_helper/data/model/product_model.dart';
import 'package:shop_helper/data/model/status.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.status,
    required this.users,
    required this.isExists,
    required this.statusText,
    required this.id,
  });

  final FormStatus status;
  final List<ProductModel> users;
  final String statusText;
  final bool isExists;
  final int id;

  ProductState copyWith({
    FormStatus? status,
    List<ProductModel>? users,
    String? statusText,
    bool? isExists,
    int? id,
  }) =>
      ProductState(
        id: id ?? this.id,
        status: status ?? this.status,
        users: users ?? this.users,
        isExists: isExists ?? this.isExists,
        statusText: statusText ?? this.statusText,
      );

  @override
  List<Object?> get props => [status, users, statusText, isExists, id];
}
