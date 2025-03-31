import 'package:diamond_selection/features/diamond/domain/entities/diamond.dart';
import 'package:hive/hive.dart';

part 'diamond_model.g.dart';

@HiveType(typeId: 0)
class DiamondModel extends Diamond {
  @HiveField(0)
  final String lotId;
  @HiveField(1)
  final String size;
  @HiveField(2)
  final double carat;
  @HiveField(3)
  final String lab;
  @HiveField(4)
  final String shape;
  @HiveField(5)
  final String color;
  @HiveField(6)
  final String clarity;
  @HiveField(7)
  final double discount;
  @HiveField(8)
  final double perCaratRate;
  @HiveField(9)
  final double finalAmount;
  @HiveField(10)
  final String cut;
  @HiveField(11)
  final String polish;
  @HiveField(12)
  final String symmetry;
  @HiveField(13)
  final String fluorescence;
  @HiveField(14)
  final String keyToSymbol;
  @HiveField(15)
  final String? labComment;

  const DiamondModel({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.keyToSymbol,
    required this.labComment,
  }) : super(
          lotId: lotId,
          size: size,
          carat: carat,
          lab: lab,
          shape: shape,
          color: color,
          clarity: clarity,
          finalAmount: finalAmount,
          discount: discount,
          perCaratRate: perCaratRate,
          cut: cut,
          polish: polish,
          symmetry: symmetry,
          fluorescence: fluorescence,
          keyToSymbol: keyToSymbol,
          labComment: labComment,
        );

  factory DiamondModel.fromJson(Map<String, dynamic> json) {
    return DiamondModel(
      lotId: json['lotId'],
      size: json['size'],
      carat: (json['carat'] as num).toDouble(),
      lab: json['lab'],
      shape: json['shape'],
      color: json['color'],
      clarity: json['clarity'],
      discount: (json['discount'] as num).toDouble(),
      perCaratRate: (json['perCaratRate'] as num).toDouble(),
      finalAmount: (json['finalAmount'] as num).toDouble(),
      cut: json['cut'],
      polish: json['polish'],
      symmetry: json['symmetry'],
      fluorescence: json['fluorescence'],
      keyToSymbol: json['keyToSymbol'],
      labComment: json['labComment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lotId': lotId,
      'carat': carat,
      'lab': lab,
      'shape': shape,
      'color': color,
      'clarity': clarity,
      'discount': discount,
      'perCaratRate': perCaratRate,
      'finalAmount': finalAmount,
      'cut': cut,
      'polish': polish,
      'symmetry': symmetry,
      'fluorescence': fluorescence,
      'keyToSymbol': keyToSymbol,
      'labComment': labComment,
    };
  }
}
