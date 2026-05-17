import 'package:flutter/material.dart';

/// UI-ready member row derived from a stored [Member].
class MemberData {
  final String id;
  final String name;
  final String avatar;
  final String dobFormatted;
  final String ageLabel;
  final Color accentColor;
  final bool isPinned;
  final String? birthdayIn;

  const MemberData({
    required this.id,
    required this.name,
    required this.avatar,
    required this.dobFormatted,
    required this.ageLabel,
    required this.accentColor,
    this.isPinned = false,
    this.birthdayIn,
  });
}
