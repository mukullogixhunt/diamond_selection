import 'package:diamond_selection/features/diamond/domain/entities/diamond.dart';
import 'package:diamond_selection/features/diamond/presentation/bloc/diamond/diamond_bloc.dart';
import 'package:diamond_selection/features/diamond/presentation/pages/cart_screen.dart';
import 'package:diamond_selection/features/diamond/presentation/widgets/diamond_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.filters});

  static const path = '/result';

  final Map<String, dynamic> filters;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Diamond> diamonds = [];
  String _selectedSort = 'price_asc';

  @override
  void initState() {
    super.initState();
    context.read<DiamondBloc>().add(FilterDiamondsEvent(widget.filters));
  }

  void _sortDiamonds() {
    diamonds.sort((a, b) {
      switch (_selectedSort) {
        case 'price_asc':
          return a.perCaratRate.compareTo(b.perCaratRate);
        case 'price_desc':
          return b.perCaratRate.compareTo(a.perCaratRate);
        case 'carat_asc':
          return a.carat.compareTo(b.carat);
        case 'carat_desc':
          return b.carat.compareTo(a.carat);
        default:
          return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diamond Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.push(CartScreen.path),
          )
        ],
      ),
      body: Column(
        children: [
          // Sorting Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              value: _selectedSort,

              isExpanded: true,
              items: const [
                DropdownMenuItem(
                    value: 'price_asc', child: Text('Price: Low to High')),
                DropdownMenuItem(
                    value: 'price_desc', child: Text('Price: High to Low')),
                DropdownMenuItem(
                    value: 'carat_asc', child: Text('Carat: Low to High')),
                DropdownMenuItem(
                    value: 'carat_desc', child: Text('Carat: High to Low')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSort = value!;
                  _sortDiamonds();
                });
              },
            ),
          ),

          // Diamonds List
          Expanded(
            child: BlocBuilder<DiamondBloc, DiamondState>(
              builder: (context, state) {
                if (state is DiamondLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DiamondLoaded) {
                  diamonds = List.from(state.diamonds); // Copy list
                  _sortDiamonds();
                  return diamonds.isNotEmpty
                      ? ListView.builder(
                          itemCount: diamonds.length,
                          itemBuilder: (context, index) {
                            return DiamondCard(diamond: diamonds[index]);
                          },
                        )
                      : const Center(child: Text('No diamonds found'));
                } else {
                  return const Center(child: Text('No diamonds found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
