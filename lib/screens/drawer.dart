import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.heart),
                  title: const Text("Favourite"),
                  onTap: () {
                    Navigator.pop(context);
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