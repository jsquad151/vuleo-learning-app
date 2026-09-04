import 'package:flutter/material.dart';

/// Mutable — a teacher adds/removes students from a group during the
/// session. There's no persistence yet, so this only lives in memory.
class StudentGroup {
  StudentGroup({
    required this.id,
    required this.name,
    required this.color,
    List<String>? studentIds,
  }) : studentIds = studentIds ?? [];

  final String id;
  final String name;
  final Color color;
  final List<String> studentIds;
}
