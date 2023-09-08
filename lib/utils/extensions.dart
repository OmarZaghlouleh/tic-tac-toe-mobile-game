import 'package:flutter/material.dart';

extension SizedboxExtension on num {
  SizedBox space() => SizedBox(width: toDouble(), height: toDouble());
}
