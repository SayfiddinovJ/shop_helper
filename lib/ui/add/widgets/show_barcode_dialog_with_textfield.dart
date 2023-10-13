import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_helper/ui/widgets/global_text_field.dart';

String showBarcodeDialogWithTextField(context) {
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
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                'blue',
                'Cancel',
                true,
                ScanMode.BARCODE,
              );
            },
          ),
          ListTile(
            title: const Text('QR Code'),
            onTap: () async {
              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                'blue',
                'Cancel',
                true,
                ScanMode.QR,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GlobalTextField(
              hintText: 'Barcode',
              keyboardType: TextInputType.number,
              onChanged: (value) => barcodeScanRes = value,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, barcodeScanRes);
            },
            child: const Text('OK')),
      ],
    ),
  );
  return barcodeScanRes;
}
