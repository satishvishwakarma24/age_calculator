// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String? ?? '👤',
      birthDate: const DateOnlyConverter().fromJson(json['birthDate']),
      isPinned: json['isPinned'] as bool? ?? false,
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'birthDate': const DateOnlyConverter().toJson(instance.birthDate),
      'isPinned': instance.isPinned,
    };
