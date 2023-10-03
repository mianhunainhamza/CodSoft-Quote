
class Quote {
  final String text;
  final String author;

  Quote(this.text, this.author);

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
    };
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Quote &&
              runtimeType == other.runtimeType &&
              text == other.text &&
              author == other.author;

  @override
  int get hashCode => text.hashCode ^ author.hashCode;

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      json['text'],
      json['author'],
    );
  }
}
