import 'package:flutter/material.dart';
import 'package:frontend/models/meme_tempale.dart';
import 'package:frontend/service/template_service.dart';
import 'edit_meme_page.dart';

class MemePage extends StatefulWidget {
  const MemePage({super.key});

  @override
  State<MemePage> createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  // Список для зберігання готових мемів (поки що зберігаємо просто URL-адреси)
  final List<String> _savedMemesUrls = [];

  final List<MemeTemplate> _templates = TemplateService.getAvailableTemplates();

  Future<void> _openEditor(MemeTemplate template) async {
    
    final String? generatedMemeUrl = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMemePage(template: template),
      ),
    );

    if (generatedMemeUrl != null) {
      setState(() {
        _savedMemesUrls.insert(0, generatedMemeUrl);
      });
    }

    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ви обрали шаблон: ${template.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('TG Meme Pro'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // БЛОК 1: Збережені меми (показуємо, тільки якщо масив не пустий)
            if (_savedMemesUrls.isNotEmpty) ...[
              const Text(
                'Ваші готові меми:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSavedMemesList(),
              const Divider(height: 40, thickness: 2),
            ],

            // БЛОК 2: Заголовок для сітки шаблонів
            const Center(
              child: Text(
                'Виберіть свій перший шаблон для створення мему',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // БЛОК 3: Сама сітка шаблонів
            _buildTemplatesGrid(),
          ],
        ),
      ),
    );
  }

  // Винесений віджет для побудови сітки (Clean UI)
  Widget _buildTemplatesGrid() {
    return GridView.builder(
      shrinkWrap: true, // Дозволяє GridView розтягнутися під свій контент
      physics:
          const NeverScrollableScrollPhysics(), // Вимикаємо скрол самої сітки
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Робимо 3 колонки
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio:
            0.75, // Висота трохи більша за ширину (щоб влізла кнопка)
      ),
      itemCount: _templates.length,
      itemBuilder: (context, index) {
        final template = _templates[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Картинка займає весь вільний простір (Expanded)
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: Image.network(
                    template.imageUrl,
                    fit: BoxFit
                        .cover, // Обрізає краї, якщо пропорції не співпадають
                  ),
                ),
              ),
              // Кнопка
              ElevatedButton(
                onPressed: () => _openEditor(template),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // <-- КОЛІР КНОПКИ
                  foregroundColor: Colors.white, // <-- КОЛІР ТЕКСТУ
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Text('Вибрати', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }

  // Віджет для списку збережених мемів
  Widget _buildSavedMemesList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _savedMemesUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _savedMemesUrls[index],
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
