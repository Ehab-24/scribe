import 'package:flutter/material.dart';

class Styles {
  static TextStyle b4([Color backgroundColor = Colors.transparent]) => TextStyle(
    color: const Color.fromRGBO(238, 238, 238, 1),
    fontSize: 14,
    background: Paint()
    ..color = backgroundColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 19.0
    ..strokeJoin = StrokeJoin.round
  );
  static const TextStyle b4i = TextStyle(
    color: Color.fromRGBO(238, 238, 238, 1),
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );
  static TextStyle b6([Color backgroundColor = Colors.transparent]) => TextStyle(
    color: Colors.white,
    fontSize: 12,
    letterSpacing: 1.5,
    background: Paint()
    ..color = backgroundColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 17.0
    ..strokeJoin = StrokeJoin.round
  );
}
