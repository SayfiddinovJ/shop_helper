import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/bloc/product_state.dart';
import 'package:shop_helper/data/local/sqflite.dart';
import 'package:shop_helper/data/model/product_model.dart';
import 'package:shop_helper/data/model/status.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc()
      : super(
          const ProductState(
            status: FormStatus.pure,
            products: [],
            statusText: '',
            isExists: false,
            id: 0,
          ),
        ) {
    on<AddProduct>(_addUser);
    on<ExistProduct>(_isExist);
    on<GetProduct>(_getUser);
    on<UpdateProduct>(_updateUser);
    on<DeleteProduct>(_deleteUser);
  }

  _addUser(AddProduct event, Emitter<ProductState> emit) async {
    debugPrint('Add product bloc');
    emit(state.copyWith(
        status: FormStatus.loading, statusText: 'Adding new product...'));
    await LocalDatabase.insertProduct(event.newProduct);
    emit(
      state.copyWith(
        statusText: 'Product added',
        status: FormStatus.success,
        products: [
          ...state.products,
          event.newProduct,
        ],
      ),
    );
  }

  _isExist(ExistProduct event, Emitter<ProductState> emit) {
    bool isBarcodeFound = false;
    ProductModel? productModel;
    state.products;
    for (ProductModel product in state.products) {
      if (product.barcode == event.barcode) {
        isBarcodeFound = true;
        productModel = product;
        break;
      }
    }
    debugPrint('Event barcode: ${event.barcode}');

    if (isBarcodeFound) {
      debugPrint('The given barcode is found in the products.');
      emit(state.copyWith(
          isExists: true, status: FormStatus.pure, product: productModel));
    } else {
      debugPrint('The given barcode is not found in the products.');
      emit(state.copyWith(isExists: false, status: FormStatus.pure));
    }
  }

  _getUser(GetProduct event, Emitter<ProductState> emit) async {
    debugPrint('Getting product bloc');
    emit(state.copyWith(
        status: FormStatus.loading, statusText: 'Getting products...'));
    List<ProductModel> userModel = await LocalDatabase.getAllProducts();
    if (userModel.isEmpty) {
      emit(
        state.copyWith(
          statusText: 'Product is empty',
          status: FormStatus.success,
          products: [...state.products, ...userModel],
        ),
      );
    } else {
      emit(
        state.copyWith(
          statusText: 'Product arrived',
          status: FormStatus.success,
          products: [...userModel],
        ),
      );
    }
  }

  _updateUser(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(
        status: FormStatus.loading, statusText: 'Updating product...'));
    await LocalDatabase.updateProduct(
      id: event.id,
      count: event.count,
    );
    List<ProductModel> userModel = await LocalDatabase.getAllProducts();
    emit(
      state.copyWith(
        statusText: 'Product updated',
        status: FormStatus.success,
        products: userModel,
      ),
    );
  }

  _deleteUser(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        statusText: 'Product deleting...',
        status: FormStatus.loading,
      ),
    );
    await LocalDatabase.deleteProduct(event.id);
    List<ProductModel> userModel = await LocalDatabase.getAllProducts();
    emit(
      state.copyWith(
        statusText: 'Product deleted',
        status: FormStatus.success,
        products: userModel,
      ),
    );
  }
}
