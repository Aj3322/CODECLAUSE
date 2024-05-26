// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 4;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      messageId: fields[0] as String,
      senderId: fields[1] as String,
      receiverId: fields[2] as String,
      groupId: fields[3] as String?,
      senderUsername: fields[4] as String,
      receiverUsername: fields[5] as String?,
      content: (fields[6] as List).cast<String>(),
      contentTypes: (fields[7] as List).cast<MessageType>(),
      timestamp: fields[8] as DateTime,
      isRead: fields[9] as bool,
      isDelivered: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.messageId)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.receiverId)
      ..writeByte(3)
      ..write(obj.groupId)
      ..writeByte(4)
      ..write(obj.senderUsername)
      ..writeByte(5)
      ..write(obj.receiverUsername)
      ..writeByte(6)
      ..write(obj.content)
      ..writeByte(7)
      ..write(obj.contentTypes)
      ..writeByte(8)
      ..write(obj.timestamp)
      ..writeByte(9)
      ..write(obj.isRead)
      ..writeByte(10)
      ..write(obj.isDelivered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
