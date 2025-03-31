import 'package:equatable/equatable.dart';

class Diamond extends Equatable {
  final String lotId;
  final String size;
  final double carat;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final double discount;
  final double perCaratRate;
  final double finalAmount;
  final String cut;
  final String polish;
  final String symmetry;
  final String fluorescence;
  final String keyToSymbol;
  final String? labComment;

  const Diamond({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.finalAmount,
    required this.discount,
    required this.perCaratRate,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.keyToSymbol,
    required this.labComment,
  });

  @override
  List<Object?> get props =>
      [lotId,size, carat, lab, shape, color, clarity, finalAmount];
}
