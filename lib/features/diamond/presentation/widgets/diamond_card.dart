// import 'package:diamond_selection/features/diamond/presentation/bloc/cart/cart_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../domain/entities/diamond.dart';
//
// class DiamondCard extends StatelessWidget {
//   final Diamond diamond;
//   final bool isCart;
//
//   const DiamondCard({super.key, required this.diamond, this.isCart = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       child: ListTile(
//         title: Text("${diamond.shape} - ${diamond.carat} ct"),
//         subtitle:
//             Text("${diamond.lab} | ${diamond.color} | ${diamond.clarity}"),
//         trailing: isCart
//             ? IconButton(
//                 icon: Icon(Icons.delete, color: Colors.red),
//                 onPressed: () {
//                   context.read<CartBloc>().add(RemoveFromCartEvent(diamond));
//                 },
//               )
//             : IconButton(
//                 icon: Icon(Icons.add_shopping_cart, color: Colors.green),
//                 onPressed: () {
//                   context.read<CartBloc>().add(AddToCartEvent(diamond));
//                 },
//               ),
//       ),
//     );
//   }
// }


import 'package:diamond_selection/features/diamond/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/diamond.dart';

class DiamondCard extends StatelessWidget {
  final Diamond diamond;
  final bool isCart;

  const DiamondCard({super.key, required this.diamond, this.isCart = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Diamond Shape & Carat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${diamond.shape} - ${diamond.carat} ct",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    diamond.lab,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Color, Clarity, Cut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoBadge("Color", diamond.color),
                _buildInfoBadge("Clarity", diamond.clarity),
                _buildInfoBadge("Cut", diamond.cut),
              ],
            ),
            const SizedBox(height: 8),

            // Price, Discount & Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price & Discount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${diamond.finalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Text(
                      "${diamond.discount.toStringAsFixed(1)}% Off",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700),
                    ),
                  ],
                ),

                // Add/Remove Button (Properly Aligned)
                IconButton(
                  icon: Icon(
                    isCart ? Icons.delete : Icons.add_shopping_cart,
                    color: isCart ? Colors.red : Colors.green,
                    size: 24, // Adjusted Size
                  ),
                  onPressed: () {
                    final cartBloc = context.read<CartBloc>();
                    isCart
                        ? cartBloc.add(RemoveFromCartEvent(diamond))
                        : cartBloc.add(AddToCartEvent(diamond));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBadge(String title, String value) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}


