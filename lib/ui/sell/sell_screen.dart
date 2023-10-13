import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_state.dart';
import 'package:shop_helper/data/model/status.dart';
import 'package:shop_helper/ui/add/add_screen.dart';
import 'package:shop_helper/ui/add/widgets/show_count_dialog.dart';
import 'package:shop_helper/ui/sell/widgets/show_dialog.dart';
import 'package:shop_helper/ui/sell/widgets/show_sell_barcode_dialog.dart';
import 'package:shop_helper/utils/extension.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        actions: [
          IconButton(
            onPressed: () async {
             showSellBarcodeDialog(context);
            },
            icon: const Icon(Icons.barcode_reader),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == FormStatus.error) {
            return const Center(child: Text('Error'));
          }
          return state.products.isEmpty
              ? const Center(child: Text('There are no products here yet'))
              : ListView(
                  children: [
                    ...List.generate(
                      state.products.length,
                      (index) {
                        return ListTile(
                          title: Text(state.products[index].name.capitalize()),
                          subtitle:
                              Text('Count: ${state.products[index].count}'),
                          trailing: IconButton(
                            onPressed: () {
                              showCountDialog(
                                context,
                                int.parse(state.products[index].count),
                                state.products[index].id!,
                              );
                            },
                            icon: const Icon(
                              Icons.sell,
                              color: Colors.blue,
                            ),
                          ),
                          onLongPress: () {
                            showMyDialog(context, state.products[index].id!);
                          },
                        );
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }
}
