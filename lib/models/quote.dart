import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      json['text'],
      json['author'],
    );
  }
}
class QuoteService {
  static Future<Quote> getQuote() async {
    String category = 'happiness';
    String apiUrl = 'https://api.api-ninjas.com/v1/quotes?category=$category';

    Map<String, String> headers = {
      'X-Api-Key': 'DUGn/QS38GrZ9R8v/mlt8w==X8LKQxFWudhvvCJf',
    };

    try {
      var response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.isNotEmpty) {
          String quoteText = jsonResponse[0]['quote'];
          String author = jsonResponse[0]['author'];
          return Quote(quoteText, author);
        } else {
          return Quote('No Quote Found.', '');
        }
      } else {
        return Quote('Error', 'Error: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      return Quote('Error', 'Error fetching quote: $e');
    }
  }

// Function to save a list of quotes to local storage
  static Future<void> saveQuotesToLocal(List<Quote> quotes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> quoteData = quotes.map((quote) => jsonEncode(quote.toJson())).toList();
    await prefs.setStringList('quotes', quoteData);
  }

  // Function to load quotes from local storage
  static Future<List<Quote>> loadQuotesFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> quoteData = prefs.getStringList('quotes') ?? [];
    return quoteData.map((data) {
      Map<String, dynamic> json = jsonDecode(data);
      return Quote.fromJson(json);
    }).toList();
  }
}
