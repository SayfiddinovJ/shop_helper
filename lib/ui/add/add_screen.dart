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
import 'package:shop_helper/ui/sell/sell_screen.dart';
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
      appBar: AppBar(
        title: const Text('Add'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellScreen(),
                ),
              );
            },
            icon: const Icon(Icons.import_export),
          ),
        ],
      ),
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
                      String barcodeScanRes =
                          await FlutterBarcodeScanner.scanBarcode(
                        'blue',
                        'Cancel',
                        true,
                        ScanMode.BARCODE,
                      );
                      barcodeController.text = barcodeScanRes;
                      debugPrint('Barcode: $barcodeScanRes');
                    },
                    icon: const Icon(Icons.barcode_reader),
                  ),
                ),
                24.ph,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          countController.text.isNotEmpty &&
                          barcodeController.text.isNotEmpty) {
                        context
                            .read<ProductBloc>()
                            .add(ExistProduct(barcode: barcodeController.text));
                        if (state.isExists) {
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
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Fields are not filled')));
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
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Product added')));
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
