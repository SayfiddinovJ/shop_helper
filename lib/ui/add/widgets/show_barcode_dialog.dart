import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

String showBarcodeDialog(context) {
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
        ],
      ),
    ),
  );
  return barcodeScanRes;
}
