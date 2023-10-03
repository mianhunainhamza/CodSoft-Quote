import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quote.dart';


class QuoteService {
  Quote? quote;

  static final instance = QuoteService._();

  QuoteService._();

  Future<void> getQuote({bool refresh = false}) async {
    if(!refresh && quote!=null)return;
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
          quote = Quote(quoteText, author);
        } else {
          quote = Quote('No Quote Found.', '');
        }
      } else {
        quote = Quote('Error', 'Error: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      quote = Quote('Error', 'Error fetching quote: $e');
    }
  }

// Function to save a list of quotes to local storage
  static Future<void> saveQuotesToLocal(List<Quote> quotes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> quoteData = quotes.map((quote) => jsonEncode(quote.toJson())).toList();
    await prefs.setStringList('quotes', quoteData);
  }

  // Function to load quotes from local storage
  Future<List<Quote>> loadQuotesFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> quoteData = prefs.getStringList('quotes') ?? [];
    return quoteData.map((data) {
      Map<String, dynamic> json = jsonDecode(data);
      return Quote.fromJson(json);
    }).toList();
  }
}