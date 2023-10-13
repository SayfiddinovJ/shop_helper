import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/bloc/product_state.dart';
import 'package:shop_helper/ui/add/widgets/show_count_dialog.dart';

showSellBarcodeDialog(context) {
  String barcodeScanRes = '';
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Barcode'),
                onTap: () async {
                  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    'blue',
                    'Cancel',
                    true,
                    ScanMode.BARCODE,
                  );
                  if (context.mounted) {
                    context
                        .read<ProductBloc>()
                        .add(ExistProduct(barcode: barcodeScanRes));
                    if (state.isExists) {
                      Navigator.pop(context);
                      showCountDialog(context, int.parse(state.product!.count),
                          state.product!.id ?? 0);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'This barcode is not found',
                        backgroundColor: Colors.blue,
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  }
                },
              ),
              ListTile(
                title: const Text('QR Code'),
                onTap: () async {
                  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    'blue',
                    'Cancel',
                    true,
                    ScanMode.BARCODE,
                  );
                  if (context.mounted) {
                    context
                        .read<ProductBloc>()
                        .add(ExistProduct(barcode: barcodeScanRes));
                    if (state.isExists) {
                      Navigator.pop(context);
                      showCountDialog(context, int.parse(state.product!.count),
                          state.product!.id ?? 0);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'This barcode is not found',
                        backgroundColor: Colors.blue,
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}
