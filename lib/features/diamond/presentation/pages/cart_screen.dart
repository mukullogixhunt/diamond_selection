// import 'package:diamond_selection/features/diamond/presentation/bloc/cart/cart_bloc.dart';
// import 'package:diamond_selection/features/diamond/presentation/widgets/diamond_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   static const path = '/cart';
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//
//   @override
//   void initState() {
//     context.read<CartBloc>().add(LoadCartEvent());
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Cart')),
//       body: BlocBuilder<CartBloc, CartState>(
//         builder: (context, state) {
//           if (state is CartLoaded) {
//             return ListView.builder(
//               itemCount: state.cartDiamonds.length,
//               itemBuilder: (context, index) {
//                 final diamond = state.cartDiamonds[index];
//                 return state.cartDiamonds.isNotEmpty
//                     ? DiamondCard(diamond: diamond,isCart: true,)
//                     : Center(child: Text('Your cart is empty'));
//               },
//             );
//           } else {
//             return const Center(child: Text('Your cart is empty'));
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:diamond_selection/features/diamond/presentation/bloc/cart/cart_bloc.dart';
import 'package:diamond_selection/features/diamond/presentation/widgets/diamond_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const path = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(LoadCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final diamonds = state.cartDiamonds;

            if (diamonds.isEmpty) {
              return const Center(child: Text('Your cart is empty'));
            }

            // Calculate Summary
            final totalCarat = diamonds.fold(0.0, (sum, d) => sum + d.carat);
            final totalPrice =
            diamonds.fold(0.0, (sum, d) => sum + d.finalAmount);
            final double avgPricePerCarat = totalCarat > 0 ? totalPrice / totalCarat : 0;
            final avgDiscount =
                diamonds.fold(0.0, (sum, d) => sum + d.discount) / diamonds.length;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: diamonds.length,
                    itemBuilder: (context, index) {
                      return DiamondCard(diamond: diamonds[index], isCart: true);
                    },
                  ),
                ),
                _buildCartSummary(
                  totalCarat: totalCarat,
                  totalPrice: totalPrice,
                  avgPricePerCarat: avgPricePerCarat,
                  avgDiscount: avgDiscount,
                ),
              ],
            );
          }
          return const Center(child: Text('Your cart is empty'));
        },
      ),
    );
  }

  Widget _buildCartSummary({
    required double totalCarat,
    required double totalPrice,
    required double avgPricePerCarat,
    required double avgDiscount,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow("Total Carat", "${totalCarat.toStringAsFixed(2)} ct"),
          _buildSummaryRow("Total Price", "\$${totalPrice.toStringAsFixed(2)}"),
          _buildSummaryRow(
              "Avg. Price/Carat", "\$${avgPricePerCarat.toStringAsFixed(2)}"),
          _buildSummaryRow(
              "Avg. Discount", "${avgDiscount.toStringAsFixed(1)}%"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
