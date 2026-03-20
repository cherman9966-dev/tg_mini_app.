import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import '../models/meme_request.dart';

class MemeGeneratorPage extends StatefulWidget {
  const MemeGeneratorPage({super.key});

  @override
  State<MemeGeneratorPage> createState() => _MemeGeneratorPageState();
}

class _MemeGeneratorPageState extends State<MemeGeneratorPage> {
  final TextEditingController _topController = TextEditingController();
  final TextEditingController _bottomController = TextEditingController();

  String? _imageUrl;

  void _generateMeme() {
    setState(() {
      final request = MemeRequest(
        topText: _topController.text,
        bottomText: _bottomController.text,
      );
      _imageUrl = ApiService.buildMemeUrl(
        topText: request.topText,
        bottomText: request.bottomText,
        template: request.template,
        color: request.color,
       );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TG Meme Pro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputSection(),
            const SizedBox(height: 20),
            _buildGenerateButton(),
            const SizedBox(height: 30),
            if (_imageUrl != null) _buildImagePreview(),
          ],
        ),
      ),
    );
  }

  // Приклад винесення логічних блоків UI в окремі методи всередині файлу
  Widget _buildInputSection() {
    return Column(
      children: [
        TextField(
          controller: _topController,
          decoration: const InputDecoration(
            labelText: 'Верхній текст',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _bottomController,
          decoration: const InputDecoration(
            labelText: 'Нижній текст',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateButton() {
    return ElevatedButton(
      onPressed: _generateMeme,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Згенерувати мем'),
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        _imageUrl!,
        key: ValueKey(_imageUrl),
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : const CircularProgressIndicator(),
      ),
    );
  }
}
