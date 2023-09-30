import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/screens/favourite_page.dart';
import 'package:quote_app/screens/home_page.dart';

class CustomDrawer extends StatelessWidget {
  final String route;
  const CustomDrawer({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: Colors.white,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
          child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 12,
              children: [
                ListTile(
                  leading: const Icon(CupertinoIcons.home),
                  title: const Text("Home"),
                  onTap: () {
                    if (route != "HomePage") {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
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
                    } else {
                      Navigator.pop(context);
                    }
                  },

                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.heart),
                  title: const Text("Favourite"),
                  onTap: () {
                    if (route != "FavouritePage") {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const FavouriteQuote(),
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
                            })
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.info),
                  title: const Text("About Us"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ]
          ),
        )
      ],
    );
  }
}