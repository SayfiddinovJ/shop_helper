import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';

void showMyDialog(context, int id) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: const Text('Are you sure to delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<ProductBloc>().add(GetProduct());
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<ProductBloc>().add(DeleteProduct(id: id));
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ));
}
