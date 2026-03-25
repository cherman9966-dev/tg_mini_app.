import 'package:flutter/material.dart';
import 'package:frontend/models/mem_text_item.dart';
import 'package:frontend/models/meme_tempale.dart';
import 'package:frontend/ui/widgets/meme_canvas.dart';
import 'package:frontend/ui/widgets/meme_toolbar.dart';

class EditMemePage extends StatefulWidget {
  final MemeTemplate template;

  const EditMemePage({super.key, required this.template});

  @override
  State<EditMemePage> createState() => _EditMemePageState();
}

class _EditMemePageState extends State<EditMemePage> {
  final TextEditingController _textController = TextEditingController();

  final List<MemeTextItem> _items = [];

  String? _selectedItemId;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      if (_selectedItemId != null) {
        setState(() {
          final item = _items.firstWhere((i) => i.id == _selectedItemId);
          item.text = _textController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addNewText({String text = 'Новий текст'}) {
    setState(() {
      final newItem = MemeTextItem(id: DateTime.now().toString(), text: text);
      _items.add(newItem);
      _selectItem(newItem.id);
    });
  }

  void _selectItem(String id) {
    setState(() {
      _selectedItemId = id;
      final item = _items.firstWhere((i) => i.id == id);
      _textController.text = item.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    MemeTextItem? selectedItem;
    if (_selectedItemId != null) {
      selectedItem = _items.firstWhere((i) => i.id == _selectedItemId);
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Редактор мему'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Тут можна реалізувати логіку збереження мему
              // Наприклад, згенерувати зображення та повернути URL назад на попередній екран
              Navigator.pop(context, 'https://example.com/generated_meme.jpg');
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _selectedItemId = null;
            _textController.clear();
          });
        },
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: MemeCanvas(
                  imageUrl: widget.template.imageUrl,
                  textItems: _items,
                  selectedItemId: _selectedItemId,
                  isFlipped: _isFlipped,
                  onSelectText: _selectItem,
                  onTextUpdated: () => setState(() {}),
                  onDeleteItem: (String p1) {},
                ),
              ),
            ),

            MemeToolbar(
              textController: _textController,
              hasSelectedText: _selectedItemId != null,
              isSelectedTextUppercase: selectedItem?.isUppercase ?? false,
              isFlipped: _isFlipped,
              onAddText: () => _addNewText(),
              onAddEmoji: () => _addNewText(text: '😎'),
              onToggleFlip: () => setState(() => _isFlipped = !_isFlipped),
              onToggleCaps: () {
                if (selectedItem != null) {
                  setState(
                    () =>
                        selectedItem!.isUppercase = !selectedItem!.isUppercase,
                  );
                }
              },
              onChangeColor: (color) {
                if (selectedItem != null) {
                  setState(() => selectedItem!.color = color);
                }
              },

              onDeleteText: () {
                if (_selectedItemId != null) {
                  setState(() {
                    _items.removeWhere((item) => item.id == _selectedItemId);
                    _selectedItemId = null;
                    _textController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
