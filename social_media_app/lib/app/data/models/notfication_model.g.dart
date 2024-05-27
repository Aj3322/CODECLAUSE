// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notfication_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 3;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      notificationId: fields[0] as String,
      userId: fields[1] as String,
      content: fields[2] as String,
      timestamp: fields[3] as DateTime,
      seen: fields[4] as bool,
      type: fields[5] as String,
      postId: fields[6] as String?,
      senderId: fields[7] as String,
      postContent: fields[8] as String?,
      postType: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.notificationId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.seen)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.postId)
      ..writeByte(7)
      ..write(obj.senderId)
      ..writeByte(8)
      ..write(obj.postContent)
      ..writeByte(9)
      ..write(obj.postType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
