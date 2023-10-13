import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/ui/widgets/global_text_field.dart';

showCountDialog(context, int productCount, int id) {
  int count = 0;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GlobalTextField(
              hintText: 'Count',
              keyboardType: TextInputType.number,
              onChanged: (value) => count = int.parse(value),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (count <= productCount && 0 < count && context.mounted) {
              context.read<ProductBloc>().add(
                    UpdateProduct(
                      id: id,
                      count: '${productCount - count}',
                    ),
                  );
            } else if (count > 0) {
              Fluttertoast.showToast(
                msg: 'You can not sell more than the count',
                backgroundColor: Colors.blue,
              );
            }
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
