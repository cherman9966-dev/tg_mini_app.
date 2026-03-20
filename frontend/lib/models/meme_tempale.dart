class MemeTemplate {
  final String id;        // Це ключ з твого config.js (наприклад, 'leo')
  final String name;      // Назва для користувача 
  final String imageUrl;  // Посилання на саму картинку з твого сервера

  MemeTemplate({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}