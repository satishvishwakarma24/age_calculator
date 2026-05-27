import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_display.freezed.dart';

/// UI-ready member row derived from a stored
@freezed
class MemberData with _$MemberData {
  const factory MemberData({
    required String id,
    required String name,
    required String avatar,
    required String dobFormatted,
    required String ageLabel,
    required Color accentColor,
    @Default(false) bool isPinned,
    String? birthdayIn,
  }) = _MemberData;
}
