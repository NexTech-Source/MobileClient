// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 3;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      fields[0] as String,
      fields[1] as DocStatus,
      fields[2] as String,
    )
      ..docName = fields[3] as String
      ..username = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tid)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.docName)
      ..writeByte(4)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DocStatusAdapter extends TypeAdapter<DocStatus> {
  @override
  final int typeId = 1;

  @override
  DocStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DocStatus.green;
      case 1:
        return DocStatus.red;
      case 2:
        return DocStatus.yellow;
      default:
        return DocStatus.green;
    }
  }

  @override
  void write(BinaryWriter writer, DocStatus obj) {
    switch (obj) {
      case DocStatus.green:
        writer.writeByte(0);
        break;
      case DocStatus.red:
        writer.writeByte(1);
        break;
      case DocStatus.yellow:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
