import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/screens/quote_preview.dart';
import 'package:quote_app/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quote.dart';

class FavouriteQuote extends StatefulWidget {
  const FavouriteQuote({Key? key}) : super(key: key);

  @override
  _FavouriteQuoteState createState() => _FavouriteQuoteState();
}

class _FavouriteQuoteState extends State<FavouriteQuote> {
  List<Quote> quotes = []; // List to store quote objects

  @override
  void initState() {
    super.initState();
    _loadQuotesFromStorage(); // Load quotes from local storage when the widget is initialized
  }

  // Function to load quotes from local storage
  Future<void> _loadQuotesFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? quoteData = prefs.getStringList('quotes');

    if (quoteData != null) {
      quotes = quoteData.map((data) {
        Map<String, dynamic> json = jsonDecode(data);
        return Quote.fromJson(json);
      }).toList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: quotes.isEmpty
          ? Center(
        child: Text(
          "So Empty",
          style: GoogleFonts.novaMono(fontSize: 20, color: CupertinoColors.white),
        ),
      )
          : ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              QuotePreview(quote: quotes[index]),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;
                            final tween = Tween(begin: begin, end: end);
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );
                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          }));
                },
                title: Text(
                  quotes[index].text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: CupertinoColors.white,
                  ),
                ),
                subtitle: Text(
                  quotes[index].author,
                  style: GoogleFonts.novaMono(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    deleteQuote(index);
                  },
                  icon: const Icon(
                    CupertinoIcons.delete,
                    color: CupertinoColors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      drawer: const CustomDrawer(route: "FavouritePage"),
    );
  }

  // Function to delete a quote
  void deleteQuote(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    quotes.removeAt(index); // Remove the quote from the list
    List<String> quoteData = quotes.map((q) => jsonEncode(q.toJson())).toList();
    prefs.setStringList('quotes', quoteData); // Save the updated list to local storage
    setState(() {});
  }
}
