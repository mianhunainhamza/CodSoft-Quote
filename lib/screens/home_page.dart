import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Quote> futureQuote = QuoteService.getQuote();

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
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      // Handle the like action
                    },
                    child: const Icon(CupertinoIcons.heart, color: CupertinoColors.white, size: 37,),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        futureQuote = QuoteService.getQuote(); // Fetch a new quote
                      });
                    },
                    child: const Icon(Icons.add_circle, color: CupertinoColors.white, size: 80,),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Icon(CupertinoIcons.share, color: CupertinoColors.white, size: 35,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
