import 'package:flutter/material.dart';
import 'package:untitled19/firstlogin.dart';
import 'firstlogin.dart';
import 'secondpage.dart';
import 'app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Home2.dart';
import 'Homepage.dart';
class splash extends StatefulWidget {
  final VoidCallback toggleTheme;

  const splash({super.key,required this.toggleTheme});
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> login(BuildContext c) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      User? u = FirebaseAuth.instance.currentUser;
      if (u != null && !u.emailVerified)
        await FirebaseAuth.instance.signOut();
      else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Correct")));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(toggleTheme: widget.toggleTheme)),);
        email.clear();
        password.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [Positioned(
          bottom: 0,
        left: 0,
        child: Image.asset(
            'assets/Group_15.png',
            width: 160
        ),
    ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/Group_13.png',
                width: 120
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            child: Image.asset(
                'assets/Group_14.png',
                width: 110
            ),
          ),
          Positioned(
            bottom: 50,
            right: 0,
            child: Image.asset(
                'assets/Group_16.png',
                width: 120
            ),
          ),
          Center(
            child: Container(
              width: 450,
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),

              ),
              child: Column(children: [
                SizedBox(height: 90),

                Image.asset('assets/Union.png' , width: 150,),
                SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.slogan,
                  style: TextStyle(fontFamily: 'Arslan',fontSize: 35,fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 30),

                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>second(toggleTheme: widget.toggleTheme)));
                },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFDE88DB ),
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(color: Color(0xFF1E0A23), fontFamily: 'OpenSans'),
                    ),),
                SizedBox(height: 10),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>First(toggleTheme: widget.toggleTheme)));

                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E0A23  ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  child: Text(
                    AppLocalizations.of(context)!.firstLogin,
                    style: TextStyle(    color: Colors.white,fontFamily: 'OpenSans'),
                  ),
                )
              ],),
            ),
          ),
        ],
      ),
    );
  }
}
