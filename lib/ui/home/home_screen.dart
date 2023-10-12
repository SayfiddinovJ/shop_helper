import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_helper/bloc/product_bloc.dart';
import 'package:shop_helper/bloc/product_event.dart';
import 'package:shop_helper/ui/add/add_screen.dart';
import 'package:shop_helper/ui/home/widget/select_buttons.dart';
import 'package:shop_helper/ui/sell/sell_screen.dart';

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
          SelectButtons(
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
          ),
          SelectButtons(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddScreen()));
            },
            text: 'Add',
            iconData: Icons.add,
          ),
        ],
      ),
    );
  }
}
