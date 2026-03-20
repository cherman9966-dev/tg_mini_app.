import 'package:frontend/models/meme_tempale.dart';

class TemplateService {
  static List<MemeTemplate> getAvailableTemplates() {
    return [
      MemeTemplate(
        id: 'classic',
        name: 'Класичний',
        imageUrl: 'http://localhost:3000/assets/mem_template.png',
      ),
      MemeTemplate(
        id: 'leo',
        name: 'Лео',
        imageUrl: 'http://localhost:3000/assets/leo.png',
      ),
      MemeTemplate(
        id: 'bob',
        name: 'Губка Боб',
        imageUrl: 'http://localhost:3000/assets/bob.png',
      ),
      MemeTemplate(
        id: 'mens',
        name: 'Хлопці',
        imageUrl: 'http://localhost:3000/assets/mens.png',
      ),
      MemeTemplate(
        id: 'what',
        name: 'Що?',
        imageUrl: 'http://localhost:3000/assets/what.png',
      ),
      MemeTemplate(
        id: 'bob2',
        name: 'Боб 2',
        imageUrl: 'http://localhost:3000/assets/bob2.png',
      ),
    ];
  }
}