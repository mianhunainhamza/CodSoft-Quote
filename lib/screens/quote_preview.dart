import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quote.dart';

class QuotePreview extends StatelessWidget {
  final Quote quote;
  const QuotePreview({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate back when the button is pressed
          },
        ),
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
                    Column(
                      children: [
                        Text(
                          quote.text,
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
                            quote.author,
                            style: GoogleFonts.novaMono(
                              fontStyle: FontStyle.italic,
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: GestureDetector(
                  onTap: ()
                  {
                  // _shareQuote();
                  },
                  child: const Icon(CupertinoIcons.share, color: CupertinoColors.white, size: 35,)),
            ),
          ),
        ],
      ),
    );
  }
  // Function to share a quote
  // void _shareQuote() async
  // {
  //    await Share.share("Good");
  // }
}
