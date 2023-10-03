import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 30,
                child: Image.asset("assets/images/quote.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50,left: 50,right: 50),
                child: Text("Keep your self motivated unless you achieve your DREAMS and GOALS",
                    style: GoogleFonts.novaRound(
                        fontSize: 25,
                        color: CupertinoColors.white,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 100,
              ),
              Text("Mian Hunain Hamza",
                  style: GoogleFonts.novaMono(
                      fontSize: 22,
                      color: CupertinoColors.white,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 15,
              ),
              Text("Connect with us on every platform with same username",
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      color: CupertinoColors.white,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 20,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.insert_comment,color: CupertinoColors.white,size: 20,),
                Text("   @mianhunainhamza",
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: CupertinoColors.white,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
              ]),
            ]),
      ),
      //drawer
      drawer: CustomDrawer(route: 'AboutUs',),
    );
  }
}
