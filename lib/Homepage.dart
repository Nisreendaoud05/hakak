import 'package:flutter/material.dart';
import 'package:untitled19/Splashpage.dart';
import 'app_localizations.dart';
import 'Splashpage.dart';
class MyApp extends StatelessWidget {
  final VoidCallback onChangeLanguage;
  final VoidCallback toggleTheme;
  const MyApp({super.key, required this.onChangeLanguage, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/Group_12.png',
              width: 150,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/Group_11.png',
              width: 150,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.language, color: Colors.white, size: 30),
                    onPressed: () {
                      onChangeLanguage();
                    },
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  AppLocalizations.of(context)!.changeLanguage,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
                ),              ],
            ),
          ),


          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 200,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => splash(      toggleTheme: toggleTheme,
                            )));
                  },
                  icon: Image.asset(
                    'assets/Union.png',color: Theme.of(context).iconTheme.color,
                    width: 120,
                  ),
                ),

                SizedBox(height: 40),


              ],
            ),
          ),
        ],
      ),
    );
  }
}