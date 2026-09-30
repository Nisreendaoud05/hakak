import 'package:flutter/material.dart';
import 'firstlogin.dart';
import 'secondpage.dart';
import 'Lowpage.dart';
import 'MyReports.dart';
import 'Home2.dart';
import 'aipage.dart';
import 'app_localizations.dart';
import 'Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class personpage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const personpage({super.key, required this.toggleTheme});

  @override
  State<personpage> createState() => _personpageState();
}

class _personpageState extends State<personpage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _notifController;
  late Animation<double> _fadeAnim;
  late Animation<double> _notifAnim;
  bool isPink = false;

  String name = "Loading...";
  String email = "Loading...";

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("com")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          name = doc["fullName"] ?? "";
          email = doc["email"] ?? "";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();

    _notifController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _notifAnim = Tween<double>(begin: 0, end: 0.2).animate(
      CurvedAnimation(parent: _notifController, curve: Curves.elasticIn),
    );

    loadUserData();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _notifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Localizations.localeOf(context).languageCode == 'ar'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedBuilder(
                        animation: _notifAnim,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _notifAnim.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isPink
                                    ? const Color(0xFFDE88DB).withOpacity(0.15)
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _notifController.reset();
                                  _notifController.forward().then((_) => _notifController.reverse());
                                  setState(() => isPink = !isPink);
                                },
                                icon: Icon(
                                  isPink ? Icons.notifications : Icons.notifications_outlined,
                                  color: isPink
                                      ? const Color(0xFFDE88DB)
                                      : Theme.of(context).iconTheme.color,
                                  size: 28,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)!.account,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDE88DB).withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/Union.png',
                          color: const Color(0xFFDE88DB),
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFDE88DB).withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFDE88DB).withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/img.png'),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          email,
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 160,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFDE88DB), Color(0xFFB85DB5)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.edit, size: 15, color: Color(0xFF1E0A23)),
                                    const SizedBox(width: 6),
                                    Text(
                                      AppLocalizations.of(context)!.up,
                                      style: const TextStyle(
                                        color: Color(0xFF1E0A23),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(children: [
                    Expanded(child: Divider(color: const Color(0xFFDE88DB).withOpacity(0.2))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        AppLocalizations.of(context)!.set,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: const Color(0xFFDE88DB).withOpacity(0.7),
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: const Color(0xFFDE88DB).withOpacity(0.2))),
                  ]),

                  const SizedBox(height: 16),

                  _buildItem(AppLocalizations.of(context)!.Appearance,
                      Icons.palette_outlined, () {
                        widget.toggleTheme();
                      }),

                  _buildItem(AppLocalizations.of(context)!.RegisterAgain,
                      Icons.lock_outline, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => First(toggleTheme: widget.toggleTheme),
                        ));
                      }),

                  _buildItem(AppLocalizations.of(context)!.log,
                      Icons.logout, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => MyApp(
                            onChangeLanguage: () {},
                            toggleTheme: () {},
                          ),
                        ));
                      }),
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: buildBottomBar(),
      ),
    );
  }

  Widget _buildItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDE88DB).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? Icons.arrow_back_ios
                    : Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).hintColor,
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFDE88DB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFFDE88DB), size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFDE88DB).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person, color: Color(0xFFDE88DB), size: 24),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.account,
                style: const TextStyle(
                  color: Color(0xFFDE88DB),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          navItem(Icons.smart_toy_outlined, AppLocalizations.of(context)!.advisor, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => aipage(toggleTheme: widget.toggleTheme)));
          }),
          navItem(Icons.library_books_outlined, AppLocalizations.of(context)!.myReports, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => Myreports(toggleTheme: widget.toggleTheme)));
          }),
          navItem(Icons.book_outlined, AppLocalizations.of(context)!.myRights, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => Lowpage(toggleTheme: widget.toggleTheme)));
          }),
          navItem(Icons.home_outlined, AppLocalizations.of(context)!.home, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => MyHomePage(toggleTheme: widget.toggleTheme)));
          }),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String text, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}