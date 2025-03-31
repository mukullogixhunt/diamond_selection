import 'package:diamond_selection/features/diamond/presentation/bloc/diamond/diamond_bloc.dart';
import 'package:diamond_selection/features/diamond/presentation/pages/cart_screen.dart';
import 'package:diamond_selection/features/diamond/presentation/pages/result_screen.dart';
import 'package:diamond_selection/features/diamond/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  static const path = '/';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double minCarat = 0.0, maxCarat = 10.0;
  String? selectedLab, selectedShape, selectedColor, selectedClarity;

  late TextEditingController minController;
  late TextEditingController maxController;

  @override
  void initState() {
    context.read<DiamondBloc>().add(LoadDiamondsEvent());

    minController = TextEditingController(text: minCarat.toString());
    maxController = TextEditingController(text: maxCarat.toString());
    super.initState();
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  void updateRangeFromText() {
    setState(() {
      double? newMin = double.tryParse(minController.text);
      double? newMax = double.tryParse(maxController.text);

      if (newMin != null && newMin >= 0.0 && newMin <= 10.0) {
        minCarat = newMin;
      }
      if (newMax != null && newMax >= 0.0 && newMax <= 10.0) {
        maxCarat = newMax;
      }
    });
  }

  void updateTextFromRange() {
    minController.text = minCarat.toStringAsFixed(2);
    maxController.text = maxCarat.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Diamonds"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.push(CartScreen.path),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Carat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Min",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (_) => updateRangeFromText(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Max",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (_) => updateRangeFromText(),
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(minCarat, maxCarat),
              min: 0.0,
              max: 10.0,
              labels: RangeLabels(minCarat.toString(), maxCarat.toString()),
              onChanged: (values) {
                setState(() {
                  minCarat = values.start;
                  maxCarat = values.end;
                  updateTextFromRange();
                });
              },
            ),
            Divider(),
            CustomDropdown(
              hint: "Select Lab",
              items: ["GIA", "In-House", "HRD"],
              onChanged: (value) => selectedLab = value,
            ),
            CustomDropdown(
              hint: "Select Shape",
              items: ["BR", "CU", "EM", "HS", "MQ", "OV", "PR", "PS", "RAD"],
              onChanged: (value) => selectedShape = value,
            ),
            CustomDropdown(
              hint: "Select Color",
              items: ["D", "E", "F", "G", "H", "I", "J", "K", "L", "M"],
              onChanged: (value) => selectedColor = value,
            ),
            CustomDropdown(
              hint: "Select Clarity",
              items: [
                "FL",
                "I1",
                "IF",
                "SI1",
                "SI2",
                "VS1",
                "VS2",
                "VVS1",
                "VVS2"
              ],
              onChanged: (value) => selectedClarity = value,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                onPressed: () {
                  final filters = {
                    'caratFrom': minCarat,
                    'caratTo': maxCarat,
                    'lab': selectedLab,
                    'shape': selectedShape,
                    'color': selectedColor,
                    'clarity': selectedClarity,
                  };

                  context.push(ResultScreen.path, extra: filters);
                },
                child: Text(
                  "Search",style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
