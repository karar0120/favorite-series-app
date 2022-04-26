class Quotes {
  late String? quote;

  Quotes.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }
}
