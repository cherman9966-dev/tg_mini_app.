import 'package:flutter/material.dart';
import 'package:frontend/models/mem_text_item.dart';
import 'dart:math';

class MemeCanvas extends StatelessWidget {
  final String imageUrl;
  final List<MemeTextItem> textItems;
  final String? selectedItemId;
  final bool isFlipped;
  final Function(String) onSelectText;
  final VoidCallback onTextUpdated;

  const MemeCanvas({
    super.key,
    required this.imageUrl,
    required this.textItems,
    required this.selectedItemId,
    required this.isFlipped,
    required this.onSelectText,
    required this.onTextUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Додаємо красиві відступи від країв екрана
      child: AspectRatio(
        aspectRatio: 1.0, // Пропорція 1:1 (Квадрат). Якщо шаблони прямокутні, можна змінити на 4/3 або 16/9
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Дізнаємося реальну ширину і висоту, яку нам виділив Flutter на цьому екрані
            final canvasWidth = constraints.maxWidth;
            final canvasHeight = constraints.maxHeight;

            return Container(
              width: canvasWidth,
              height: canvasHeight,
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. АДАПТИВНИЙ ФОН
                  Transform(
                    alignment: Alignment.center,
                    transform: isFlipped ? Matrix4.rotationY(pi) : Matrix4.identity(),
                    child: Image.network(
                      imageUrl, 
                      width: canvasWidth, 
                      height: canvasHeight, 
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // 2. ТЕКСТИ З ДИНАМІЧНИМИ КОРДОНАМИ
                  ...textItems.map((item) {
                    return DraggableTextWidget(
                      item: item,
                      isSelected: item.id == selectedItemId,
                      canvasWidth: canvasWidth,   // <-- Передаємо реальну ширину для захисту
                      canvasHeight: canvasHeight, // <-- Передаємо реальну висоту для захисту
                      onSelect: () => onSelectText(item.id),
                      onUpdate: onTextUpdated,
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DraggableTextWidget extends StatefulWidget {
  final MemeTextItem item;
  final bool isSelected;
  final double canvasWidth;  // Отримуємо ширину полотна
  final double canvasHeight; // Отримуємо висоту полотна
  final VoidCallback onSelect;
  final VoidCallback onUpdate;

  const DraggableTextWidget({
    super.key, 
    required this.item, 
    required this.isSelected, 
    required this.canvasWidth,
    required this.canvasHeight,
    required this.onSelect, 
    required this.onUpdate,
  });

  @override
  State<DraggableTextWidget> createState() => _DraggableTextWidgetState();
}

class _DraggableTextWidgetState extends State<DraggableTextWidget> {
  double _baseScale = 1.0;
  double _baseRotation = 0.0;

  @override
  Widget build(BuildContext context) {
    String displayText = widget.item.isUppercase ? widget.item.text.toUpperCase() : widget.item.text;

    return Positioned(
      left: widget.item.position.dx,
      top: widget.item.position.dy,
      child: GestureDetector(
        onScaleStart: (details) {
          widget.onSelect();
          _baseScale = widget.item.scale;
          _baseRotation = widget.item.rotation;
        },
        onScaleUpdate: (details) {
          setState(() {
            // Рахуємо нові координати
            double newX = widget.item.position.dx + details.focalPointDelta.dx;
            double newY = widget.item.position.dy + details.focalPointDelta.dy;

            // ДИНАМІЧНИЙ ЗАХИСТ ВІД ВИЛЬОТУ ЗА ЕКРАН
            // Замість жорстких 250.0 ми віднімаємо ~50 пікселів від реальної ширини
            newX = newX.clamp(0.0, widget.canvasWidth - 50.0);
            newY = newY.clamp(0.0, widget.canvasHeight - 50.0);

            widget.item.position = Offset(newX, newY);
            widget.item.scale = _baseScale * details.scale;
            widget.item.rotation = _baseRotation + details.rotation;
          });
          widget.onUpdate();
        },
        child: Transform.scale(
          scale: widget.item.scale,
          child: Transform.rotate(
            angle: widget.item.rotation,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: widget.isSelected ? Border.all(color: Colors.blueAccent, width: 2) : null,
              ),
              child: _buildMemeText(displayText, widget.item.color),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemeText(String text, Color color) {
    return Stack(
      children: [
        Text(text, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, foreground: Paint()..style = PaintingStyle.stroke..strokeWidth = 5..color = Colors.black)),
        Text(text, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}