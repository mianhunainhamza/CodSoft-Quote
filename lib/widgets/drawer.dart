import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../screens/about_us.dart';
import '../screens/favourite_page.dart';
import '../screens/home_page.dart';

class CustomDrawer extends StatelessWidget {
  final String route;

  const CustomDrawer({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: Colors.white,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
                      CupertinoPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
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
                      CupertinoPageRoute(
                        builder: (context) => const FavouriteQuote(),
                      ),
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
                  if (route != "AboutUs") {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AboutUs(),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
