class ApiService {
  // Базовий URL (зручно змінити в одному місці)
  static const String _baseUrl = 'http://localhost:3000/generate';

  static String buildMemeUrl({
    required String topText,
    required String bottomText,
    required String template,
    String color = 'white',
  }) {
    // Uri.encodeComponent захищає від помилок з пробілами та спецсимволами
    final top = Uri.encodeComponent(topText);
    final bottom = Uri.encodeComponent(bottomText);
    final ts = DateTime.now().millisecondsSinceEpoch;

    return '$_baseUrl?textTop=$top&textBottom=$bottom&template=$template&color=$color&v=$ts';
  }
}
