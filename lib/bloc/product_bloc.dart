import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/bloc/product_state.dart';
import 'package:shop_helper/data/local/sqflite.dart';
import 'package:shop_helper/data/model/product_model.dart';
import 'package:shop_helper/data/model/status.dart';
import 'package:shop_helper/data/model/universal_data.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc()
      : super(
          const ProductState(
            status: FormStatus.pure,
            users: [],
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
        users: [
          ...state.users,
          event.newProduct,
        ],
      ),
    );
  }

  _isExist(ExistProduct event, Emitter<ProductState> emit) async {
    debugPrint('Exist product bloc');
    emit(state.copyWith(
        status: FormStatus.loading, statusText: 'Checking new product...'));
    bool result = await LocalDatabase.checkValueExists(event.barcode);
    emit(
      state.copyWith(status: FormStatus.success, isExists: result),
    );
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
          users: [...state.users, ...userModel],
        ),
      );
    } else {
      emit(
        state.copyWith(
          statusText: 'Product arrived',
          status: FormStatus.success,
          users: [...userModel],
        ),
      );
    }
  }

  _updateUser(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(
        status: FormStatus.loading, statusText: 'Updating user...'));
    UniversalData data =
        await LocalDatabase.updateProduct(barcode: event.barcode, count: event.count);
    List<ProductModel> userModel = await LocalDatabase.getAllProducts();

    if (data.error.isEmpty) {
      emit(
        state.copyWith(
          statusText: 'Product updated',
          status: FormStatus.success,
          users: userModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          statusText: 'Product deleting error: ${data.error}',
          status: FormStatus.error,
        ),
      );
    }
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
        users: userModel,
      ),
    );
  }
}
