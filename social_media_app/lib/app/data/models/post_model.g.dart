// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 2;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      postId: fields[0] as String,
      uid: fields[1] as String,
      username: fields[2] as String,
      profilePicUrl: fields[3] as String,
      content: (fields[4] as List).cast<String>(),
      caption: fields[5] as String,
      likes: (fields[6] as List).cast<String>(),
      comments: (fields[7] as List).cast<String>(),
      createdAt: fields[8] as DateTime,
      location: fields[9] as String?,
      tags: (fields[10] as List?)?.cast<String>(),
      postTypeIndex: fields[11] as int,
      privacy: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.postId)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.profilePicUrl)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.caption)
      ..writeByte(6)
      ..write(obj.likes)
      ..writeByte(7)
      ..write(obj.comments)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.tags)
      ..writeByte(11)
      ..write(obj.postTypeIndex)
      ..writeByte(12)
      ..write(obj.privacy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
