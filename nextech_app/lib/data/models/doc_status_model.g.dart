// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocStatusAdapter extends TypeAdapter<DocStatus> {
  @override
  final int typeId = 0;

  @override
  DocStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocStatus(
      fields[0] as Status,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DocStatus obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.docStatus)
      ..writeByte(1)
      ..write(obj.docName);
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

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 1;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.green;
      case 1:
        return Status.red;
      case 2:
        return Status.yellow;
      default:
        return Status.green;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.green:
        writer.writeByte(0);
        break;
      case Status.red:
        writer.writeByte(1);
        break;
      case Status.yellow:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
