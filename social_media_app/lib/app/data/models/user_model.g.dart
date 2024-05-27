// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      uid: fields[0] as String,
      username: fields[1] as String,
      email: fields[2] as String,
      profilePicUrl: fields[3] as String,
      bio: fields[4] as String,
      followers: (fields[5] as List).cast<String>(),
      following: (fields[6] as List).cast<String>(),
      posts: (fields[7] as List).cast<String>(),
      createdAt: fields[8] as DateTime,
      lastActiveAt: fields[9] as DateTime,
      isVerified: fields[10] as bool,
      contactNumber: fields[11] as String?,
      location: fields[12] as String?,
      website: fields[13] as String?,
      preferences: (fields[14] as Map?)?.cast<String, dynamic>(),
      notificationToken: fields[15] as String?,
      isOnline: fields[16] as bool,
      accountType: fields[17] as String?,
      birthdate: fields[18] as DateTime?,
      gender: fields[19] as String?,
      status: fields[20] as String?,
      chatUserIds: (fields[21] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.profilePicUrl)
      ..writeByte(4)
      ..write(obj.bio)
      ..writeByte(5)
      ..write(obj.followers)
      ..writeByte(6)
      ..write(obj.following)
      ..writeByte(7)
      ..write(obj.posts)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.lastActiveAt)
      ..writeByte(10)
      ..write(obj.isVerified)
      ..writeByte(11)
      ..write(obj.contactNumber)
      ..writeByte(12)
      ..write(obj.location)
      ..writeByte(13)
      ..write(obj.website)
      ..writeByte(14)
      ..write(obj.preferences)
      ..writeByte(15)
      ..write(obj.notificationToken)
      ..writeByte(16)
      ..write(obj.isOnline)
      ..writeByte(17)
      ..write(obj.accountType)
      ..writeByte(18)
      ..write(obj.birthdate)
      ..writeByte(19)
      ..write(obj.gender)
      ..writeByte(20)
      ..write(obj.status)
      ..writeByte(21)
      ..write(obj.chatUserIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
