import 'package:flutter/material.dart';

class ToDoColor {
  final int colorIndex;

  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.blueGrey,
    Colors.purple,
    Colors.teal,
    Colors.orange,
  ];

  Color get color => predefinedColors[colorIndex];

  ToDoColor({required this.colorIndex});
}