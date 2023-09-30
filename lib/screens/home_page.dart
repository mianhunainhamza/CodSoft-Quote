import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app/widgets/drawer.dart';
import '../models/quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSaved = false;
  bool isChange = false;
  Future<Quote> futureQuote = QuoteService.getQuote();
  List<Quote> quotes = [];

  @override
  void initState() {
    super.initState();
    _loadQuotesFromStorage();
  }

  // Function to load quotes from local storage
  Future<void> _loadQuotesFromStorage() async {
    List<Quote> loadedQuotes = await QuoteService.loadQuotesFromLocal();
    setState(() {
      quotes = loadedQuotes;
    });
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
                    FutureBuilder<Quote>(
                      future: futureQuote,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(70),
                            child: CircularProgressIndicator(
                              color: CupertinoColors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Column(
                            children: [
                              Text(
                                snapshot.data?.text ?? 'Loading...',
                                style: GoogleFonts.novaMono(
                                  fontSize: 20,
                                  color: CupertinoColors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20,),
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  "'${snapshot.data?.author}'",
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
                      _addQuoteToStorage();
                    },
                    child: isSaved
                        ? const Icon(CupertinoIcons.heart_fill, color: CupertinoColors.white, size: 37,)
                        : const Icon(CupertinoIcons.heart, color: CupertinoColors.white, size: 37,),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChange = !isChange;
                        isSaved = false;
                        futureQuote = QuoteService.getQuote(); // Fetch a new quote
                      });
                    },
                    child: isChange
                        ? const Icon(CupertinoIcons.arrow_clockwise_circle_fill, color: CupertinoColors.white, size: 80,)
                        : const Icon(CupertinoIcons.arrow_counterclockwise_circle_fill, color: CupertinoColors.white, size: 80,),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: const Icon(CupertinoIcons.share, color: CupertinoColors.white, size: 35,),
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

  // Function to add a new quote to local storage
  Future<void> _addQuoteToStorage() async {
    Quote currentQuote = await futureQuote;

    if (!quotes.contains(currentQuote)) {
      quotes.add(currentQuote);

      await QuoteService.saveQuotesToLocal(quotes);

      setState(() {
        isSaved = true;
      });
    }
  }
}
