import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/bloc/product_state.dart';
import 'package:shop_helper/data/model/product_model.dart';
import 'package:shop_helper/data/model/status.dart';
import 'package:shop_helper/ui/widgets/global_text_field.dart';
import 'package:shop_helper/utils/extension.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add product')),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                GlobalTextField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                24.ph,
                GlobalTextField(
                  hintText: 'Count',
                  keyboardType: TextInputType.number,
                  controller: countController,
                ),
                24.ph,
                GlobalTextField(
                  hintText: 'Barcode',
                  keyboardType: TextInputType.number,
                  controller: barcodeController,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      String barcodeScanRes = '';
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text('Barcode'),
                                      onTap: () async {
                                        barcodeController.text =
                                            await FlutterBarcodeScanner
                                                .scanBarcode(
                                          'blue',
                                          'Cancel',
                                          true,
                                          ScanMode.BARCODE,
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('QR Code'),
                                      onTap: () async {
                                        barcodeController.text =
                                            await FlutterBarcodeScanner
                                                .scanBarcode(
                                          'blue',
                                          'Cancel',
                                          true,
                                          ScanMode.QR,
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ));
                      debugPrint('Barcode: $barcodeScanRes');
                    },
                    icon: const Icon(Icons.barcode_reader),
                  ),
                ),
                24.ph,
                SizedBox(
                  height: 56.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          countController.text.isNotEmpty &&
                          barcodeController.text.isNotEmpty) {
                        context
                            .read<ProductBloc>()
                            .add(ExistProduct(barcode: barcodeController.text));
                        debugPrint('Product: ${state.product}');
                        if (state.isExists) {
                          Fluttertoast.showToast(
                            msg: 'This barcode has already been entered',
                            backgroundColor: Colors.blue,
                          );
                        } else {
                          context.read<ProductBloc>().add(
                                AddProduct(
                                  newProduct: ProductModel(
                                    name: nameController.text,
                                    count: countController.text,
                                    barcode: barcodeController.text,
                                  ),
                                ),
                              );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Fields not filled",
                          backgroundColor: Colors.blue,
                        );
                      }
                    },
                    child: const Text("Add product"),
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) async {
          if (state.status == FormStatus.success) {
            Fluttertoast.showToast(
              msg: "Product added",
              backgroundColor: Colors.blue,
            );
          }
        },
      ),
    );
  }
}
