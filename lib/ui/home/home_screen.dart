import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/ui/add/add_screen.dart';
import 'package:shop_helper/ui/home/widget/global_button.dart';
import 'package:shop_helper/ui/sell/sell_screen.dart';
import 'package:shop_helper/utils/extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop helper')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlobalButton(
            onTap: () {
              context.read<ProductBloc>().add(GetProduct());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellScreen(),
                ),
              );
            },
            text: 'Sell',
            iconData: Icons.sell,
            color: Colors.red,
          ),
          24.ph,
          GlobalButton(
            onTap: () {
              context.read<ProductBloc>().add(GetProduct());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddScreen()));
            },
            text: 'Add',
            iconData: Icons.add,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
