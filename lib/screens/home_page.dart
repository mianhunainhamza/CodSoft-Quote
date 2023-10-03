import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../service/qoute_service.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChange = false;
  List<Quote> quotes = [];
  late Future<void> futureQuote;
  final quoteService = QuoteService.instance;

  @override
  void initState() {
    futureQuote = quoteService.getQuote();
    super.initState();
    _loadQuotesFromStorage();
  }

  // Function to load quotes from local storage
  Future<void> _loadQuotesFromStorage() async {
    List<Quote> loadedQuotes = await quoteService.loadQuotesFromLocal();
    Set<Quote> uniqueQuotes = {};

    for (final quote in loadedQuotes) {
      if (!uniqueQuotes.contains(quote)) {
        uniqueQuotes.add(quote);
      }
    }

    setState(() {
      quotes = uniqueQuotes.toList();
    });
  }

  // Function to add a new quote to local storage
  Future<void> _addQuoteToStorage() async {
    await futureQuote;

    if (!quotes.contains(quoteService.quote) && quoteService.quote != null) {
      quotes.add(quoteService.quote!);
      await QuoteService.saveQuotesToLocal(quotes);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              alignment: AlignmentDirectional.center,
              height: height * 0.6,
              width: width * 0.8,
              color: CupertinoColors.black,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 40,
                      width: 30,
                      child: Image.asset("assets/images/quote.png"),
                    ),
                    FutureBuilder<void>(
                      future: futureQuote,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(70),
                            child: CircularProgressIndicator(
                              color: CupertinoColors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final quote = quoteService.quote;
                          return Column(
                            children: [
                              Text(
                                quote?.text ?? 'Loading...',
                                style: GoogleFonts.novaMono(
                                  fontSize: 20,
                                  color: CupertinoColors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  "'${quote?.author}'",
                                  style: GoogleFonts.novaMono(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          //buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                      onTap: () {
                        if (!quotes.contains(quoteService.quote)) {
                          _addQuoteToStorage();
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  "Saved to Favourite",
                                  style: GoogleFonts.lato(
                                      color: CupertinoColors.white),
                                )));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Text(
                                "Already Saved to Favourite",
                                style: GoogleFonts.lato(
                                    color: CupertinoColors.white),
                              )));
                        }
                      },
                      child: const Icon(
                        CupertinoIcons.add_circled_solid,
                        color: CupertinoColors.white,
                        size: 40,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChange = !isChange;
                        futureQuote = quoteService.getQuote(
                            refresh: true);
                      });
                    },
                    child: isChange
                        ? const Icon(
                            CupertinoIcons.arrow_clockwise_circle_fill,
                            color: CupertinoColors.white,
                            size: 80,
                          )
                        : const Icon(
                            CupertinoIcons.arrow_counterclockwise_circle_fill,
                            color: CupertinoColors.white,
                            size: 80,
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      if (quoteService.quote == null) {
                        return;
                      }
                      Share.share(
                          '${quoteService.quote!.text}\n- ${quoteService.quote!.author}');
                    },
                    child: const Icon(
                      CupertinoIcons.share,
                      color: CupertinoColors.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      //Drawer
      drawer: const CustomDrawer(route: "HomePage"),
    );
  }
}
