// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diamond_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiamondModelAdapter extends TypeAdapter<DiamondModel> {
  @override
  final int typeId = 0;

  @override
  DiamondModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiamondModel(
      lotId: fields[0] as String,
      size: fields[1] as String,
      carat: fields[2] as double,
      lab: fields[3] as String,
      shape: fields[4] as String,
      color: fields[5] as String,
      clarity: fields[6] as String,
      discount: fields[7] as double,
      perCaratRate: fields[8] as double,
      finalAmount: fields[9] as double,
      cut: fields[10] as String,
      polish: fields[11] as String,
      symmetry: fields[12] as String,
      fluorescence: fields[13] as String,
      keyToSymbol: fields[14] as String,
      labComment: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DiamondModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.lotId)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.carat)
      ..writeByte(3)
      ..write(obj.lab)
      ..writeByte(4)
      ..write(obj.shape)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.clarity)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.perCaratRate)
      ..writeByte(9)
      ..write(obj.finalAmount)
      ..writeByte(10)
      ..write(obj.cut)
      ..writeByte(11)
      ..write(obj.polish)
      ..writeByte(12)
      ..write(obj.symmetry)
      ..writeByte(13)
      ..write(obj.fluorescence)
      ..writeByte(14)
      ..write(obj.keyToSymbol)
      ..writeByte(15)
      ..write(obj.labComment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiamondModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
