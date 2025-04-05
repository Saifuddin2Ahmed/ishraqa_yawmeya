class QuoteModel {
  final String quote;
  final String author;
  final String category;

  QuoteModel({
    required this.quote,
    required this.author,
    required this.category,
  });

  // لإنشاء نسخة معدّلة من الكائن
  QuoteModel copyWith({
    String? quote,
    String? author,
    String? category,
  }) {
    return QuoteModel(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      category: category ?? this.category,
    );
  }

  // تحويل إلى خريطة (Map)
  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
      'category': category,
    };
  }

  // إنشاء الكائن من خريطة (Map)
  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      quote: map['quote'] ?? '',
      author: map['author'] ?? '',
      category: map['category'] ?? '',
    );
  }

  // دعم JSON
  String toJson() => toMap().toString();

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['quote'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
    );
  }

  // مقارنة الكائنات
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuoteModel &&
        other.quote == quote &&
        other.author == author &&
        other.category == category;
  }

  @override
  int get hashCode => quote.hashCode ^ author.hashCode ^ category.hashCode;
}
