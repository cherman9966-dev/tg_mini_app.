import 'package:flutter/material.dart';

class MemeToolbar extends StatelessWidget {
  final TextEditingController textController;
  final bool hasSelectedText;
  final bool isSelectedTextUppercase; // Чи ввімкнено CAPS для вибраного тексту
  final bool isFlipped; // Чи перевернуто фон
  
  // Функції управління
  final VoidCallback onAddText;
  final VoidCallback onAddEmoji;
  final Function(Color) onChangeColor;
  final VoidCallback onToggleCaps;
  final VoidCallback onToggleFlip;

  const MemeToolbar({
    super.key,
    required this.textController,
    required this.hasSelectedText,
    required this.isSelectedTextUppercase,
    required this.isFlipped,
    required this.onAddText,
    required this.onAddEmoji,
    required this.onChangeColor,
    required this.onToggleCaps,
    required this.onToggleFlip,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [Colors.white, Colors.black, Colors.yellow, Colors.red, Colors.green, Colors.blue];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ВЕРХНІЙ РЯД: Додавання елементів та глобальні налаштування
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: onAddText,
                icon: const Icon(Icons.title),
                label: const Text('Текст'),
              ),
              ElevatedButton.icon(
                onPressed: onAddEmoji,
                icon: const Icon(Icons.emoji_emotions),
                label: const Text('Емодзі'),
              ),
              IconButton(
                icon: Icon(isFlipped ? Icons.flip_to_back : Icons.flip),
                onPressed: onToggleFlip,
                tooltip: 'Віддзеркалити картинку',
              ),
            ],
          ),
          const SizedBox(height: 10),

          // НИЖНІЙ РЯД: Налаштування вибраного тексту (з'являється тільки якщо вибрано текст)
          if (hasSelectedText) ...[
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Редагувати текст / емодзі',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Кнопка CAPS
                FilterChip(
                  label: const Text('CAPS'),
                  selected: isSelectedTextUppercase,
                  onSelected: (_) => onToggleCaps(),
                ),
                // Палітра кольорів
                Row(
                  children: colors.map((color) {
                    return GestureDetector(
                      onTap: () => onChangeColor(color),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 30, height: 30,
                        decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade400)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}