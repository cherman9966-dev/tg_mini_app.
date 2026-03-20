import 'package:flutter/material.dart';

class MemeTextItem {
  final String id;        // Унікальний ідентифікатор
  String text;            // Сам текст
  Offset position;        // Координати X та Y
  double scale;           // Розмір (масштаб)
  double rotation;        // Кут обертання
  Color color;  
  bool isUppercase;          // Колір тексту

  MemeTextItem({
    required this.id,
    this.text = 'Новий текст',
    this.position = const Offset(50, 50),
    this.scale = 1.0,
    this.rotation = 0.0,
    this.color = Colors.white,
    this.isUppercase = false,
  });
}