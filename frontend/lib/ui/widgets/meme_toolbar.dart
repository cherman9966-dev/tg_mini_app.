import 'package:flutter/material.dart';

class MemeToolbar extends StatelessWidget {
  final TextEditingController textController;
  final bool hasSelectedText;
  final bool isSelectedTextUppercase;
  final bool isFlipped;

  final VoidCallback onAddText;
  final VoidCallback onAddEmoji;
  final Function(Color) onChangeColor;
  final VoidCallback onToggleCaps;
  final VoidCallback onToggleFlip;
  final VoidCallback onDeleteText;

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
    required this.onDeleteText,
  });

  // Універсальна функція для створення однакових красивих кнопок
  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    Color? foregroundColor,
    Color? backgroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        elevation: 0, // Робимо кнопки плоскими та сучасними
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [Colors.white, Colors.black, Colors.yellow, Colors.red, Colors.green, Colors.blue];
    
    // 🎛 ПАРАМЕТР ВІДСТУПІВ: Змінюй цю цифру (наприклад, 8.0, 16.0, 24.0), щоб розсунути кнопки!
    const double buttonSpacing = 12.0; 

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
          // ВЕРХНІЙ РЯД КНОПОК
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // BouncingScrollPhysics додає приємний ефект "відтягування" при скролі, як на iPhone
            physics: const BouncingScrollPhysics(), 
            child: Row(
              children: [
                _buildToolButton(
                  icon: Icons.title,
                  label: 'Текст',
                  onPressed: onAddText,
                ),
                const SizedBox(width: buttonSpacing), // Застосовуємо наш відступ

                _buildToolButton(
                  icon: Icons.emoji_emotions,
                  label: 'Емодзі',
                  onPressed: onAddEmoji,
                ),
                const SizedBox(width: buttonSpacing),

                _buildToolButton(
                  icon: isFlipped ? Icons.flip_to_back : Icons.flip,
                  label: 'Фліп',
                  onPressed: onToggleFlip,
                  // Легка підсвітка, якщо віддзеркалення активне
                  backgroundColor: isFlipped ? Colors.deepPurple.shade50 : null,
                ),
                const SizedBox(width: buttonSpacing),

                _buildToolButton(
                  icon: Icons.keyboard_capslock,
                  label: 'CAPS',
                  onPressed: hasSelectedText ? onToggleCaps : null,
                  // Підсвітка для активного CAPS
                  backgroundColor: isSelectedTextUppercase ? Colors.deepPurple.shade50 : null,
                ),
                const SizedBox(width: buttonSpacing),

                _buildToolButton(
                  icon: Icons.delete_outline,
                  label: 'Видалити',
                  onPressed: hasSelectedText ? onDeleteText : null,
                  // Робимо кнопку видалення червоною для акценту (якщо вона активна)
                  foregroundColor: hasSelectedText ? Colors.red : null,
                  backgroundColor: hasSelectedText ? Colors.red.shade50 : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // НИЖНІЙ РЯД (Поле вводу та палітра)
          if (hasSelectedText) ...[
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Редагувати текст / емодзі',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () => onChangeColor(color),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}