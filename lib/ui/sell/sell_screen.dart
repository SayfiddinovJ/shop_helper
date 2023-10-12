import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/bloc/product_state.dart';
import 'package:shop_helper/data/model/status.dart';
import 'package:shop_helper/ui/add/add_screen.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        actions: [
          IconButton(
            onPressed: () async{
              String barcodeScanRes =
                  await FlutterBarcodeScanner.scanBarcode(
                'blue',
                'Cancel',
                true,
                ScanMode.BARCODE,
              );
              if(context.mounted){
                context.read<ProductBloc>().add(
                    UpdateProduct(barcode: barcodeScanRes, count: '1'));
              }
            },
            icon: const Icon(Icons.barcode_reader),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddScreen(),
                ),
              );
            },
            icon: const Icon(Icons.import_export),
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
          return ListView(
            children: [
              ...List.generate(
                state.users.length,
                (index) {
                  return Dismissible(
                    key: Key('$index'),
                    background: Container(
                      padding: EdgeInsets.only(right: 10.w),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (dismissDirection) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: const Text('Are you sure to delete?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<ProductBloc>()
                                          .add(GetProduct());
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<ProductBloc>()
                                          .add(DeleteProduct(id: index));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ));
                    },
                    child: ListTile(
                      title: Text(state.users[index].name),
                      subtitle: Text(state.users[index].barcode),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.sell,
                          color: Colors.blue,
                        ),
                      ),
                    ),
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
