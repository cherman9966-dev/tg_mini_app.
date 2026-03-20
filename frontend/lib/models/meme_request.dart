class MemeRequest {
  final String topText;
  final String bottomText;
  final String template;
  final String color;

  MemeRequest({
    required this.topText,
    required this.bottomText,
    this.template = 'classic',
    this.color = 'white',
  });
}