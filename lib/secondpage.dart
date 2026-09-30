import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Splashpage.dart';
import 'firstlogin.dart';
import 'Home2.dart';
import 'app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class second extends StatefulWidget {
  final VoidCallback toggleTheme;
  const second({super.key, required this.toggleTheme});

  @override
  State<second> createState() => _FirstState();
}

class _FirstState extends State<second> with SingleTickerProviderStateMixin {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext c) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      User? u = FirebaseAuth.instance.currentUser;
      if (u != null && !u.emailVerified) {
        await FirebaseAuth.instance.signOut();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Correct")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(toggleTheme: widget.toggleTheme),
          ),
        );
        email.clear();
        password.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.75),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          hintText: hint,
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.35),
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: const Color(0xFFDE88DB).withOpacity(0.15),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFDE88DB),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildLabel(title),
        child,
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => splash(toggleTheme: widget.toggleTheme),
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          size: 20,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFDE88DB).withOpacity(0.12),
                          ),
                          child: Image.asset(
                            'assets/Union.png',
                            width: screenWidth * 0.09,
                            color: const Color(0xFFDE88DB),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          AppLocalizations.of(context)!.loginButton,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withOpacity(0.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(children: [
                    Expanded(child: Divider(color: const Color(0xFFDE88DB).withOpacity(0.2))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        AppLocalizations.of(context)!.Credentials,
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
                  const SizedBox(height: 20),

                  _buildSection(
                    AppLocalizations.of(context)!.email,
                    _buildField(controller: email, hint: AppLocalizations.of(context)!.enterEmail),
                  ),
                  _buildSection(
                    AppLocalizations.of(context)!.password,
                    _buildField(controller: password, hint: AppLocalizations.of(context)!.enterPassword, obscure: true),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(toggleTheme: widget.toggleTheme))),
                      //login(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFDE88DB), Color(0xFFB85DB5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDE88DB).withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.loginButton,
                            style: const TextStyle(
                              color: Color(0xFF1E0A23),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => First(toggleTheme: widget.toggleTheme),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.firstLogin,
                            style: const TextStyle(
                              color: Color(0xFFDE88DB),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}