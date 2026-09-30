import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Splashpage.dart';
import 'secondpage.dart';
import 'app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home2.dart';
class First extends StatefulWidget {
  final VoidCallback toggleTheme;
  const First({super.key, required this.toggleTheme});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> with SingleTickerProviderStateMixin {
  String s = "";
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  List<String> nationalities = [
    "", "Afghan", "Albanian", "Algerian", "American", "Andorran", "Angolan", "Antiguan",
    "Argentine", "Armenian", "Australian", "Austrian", "Azerbaijani",
    "Bahamian", "Bahraini", "Bangladeshi", "Barbadian", "Belarusian", "Belgian", "Belizean",
    "Beninese", "Bhutanese", "Bolivian", "Bosnian", "Botswanan", "Brazilian", "British",
    "Bruneian", "Bulgarian", "Burkinabe", "Burmese", "Burundian",
    "Cambodian", "Cameroonian", "Canadian", "Cape Verdean", "Central African", "Chadian",
    "Chilean", "Chinese", "Colombian", "Comoran", "Congolese", "Costa Rican", "Croatian", "Cuban", "Cypriot", "Czech",
    "Danish", "Djiboutian", "Dominican", "Dutch",
    "East Timorese", "Ecuadorian", "Egyptian", "Emirati", "Equatorial Guinean", "Eritrean", "Estonian", "Ethiopian",
    "Fijian", "Filipino", "Finnish", "French",
    "Gabonese", "Gambian", "Georgian", "German", "Ghanaian", "Greek", "Grenadian", "Guatemalan", "Guinean", "Guinea-Bissauan", "Guyanese",
    "Haitian", "Honduran", "Hungarian",
    "Icelandic", "Indian", "Indonesian", "Iranian", "Iraqi", "Irish", "Israeli", "Italian", "Ivorian",
    "Jamaican", "Japanese", "Jordanian",
    "Kazakh", "Kenyan", "Kittitian", "Kuwaiti", "Kyrgyz",
    "Laotian", "Latvian", "Lebanese", "Liberian", "Libyan", "Liechtensteiner", "Lithuanian", "Luxembourger",
    "Macedonian", "Malagasy", "Malawian", "Malaysian", "Maldivian", "Malian", "Maltese", "Marshallese", "Mauritanian", "Mauritian", "Mexican", "Micronesian", "Moldovan", "Monacan", "Mongolian", "Montenegrin", "Moroccan", "Mozambican",
    "Namibian", "Nauruan", "Nepali", "New Zealander", "Nicaraguan", "Nigerien", "Nigerian", "North Korean", "Norwegian",
    "Omani",
    "Pakistani", "Palauan", "Panamanian", "Papuan", "Paraguayan", "Peruvian", "Polish", "Portuguese",
    "Qatari",
    "Romanian", "Russian", "Rwandan",
    "Saint Lucian", "Salvadoran", "Samoan", "San Marinese", "Sao Tomean", "Saudi", "Scottish", "Senegalese", "Serbian", "Seychellois", "Sierra Leonean", "Singaporean", "Slovak", "Slovenian", "Solomon Islander", "Somali", "South African", "South Korean", "South Sudanese", "Spanish", "Sri Lankan", "Sudanese", "Surinamese", "Swazi", "Swedish", "Swiss", "Syrian",
    "Taiwanese", "Tajik", "Tanzanian", "Thai", "Togolese", "Tongan", "Trinidadian", "Tunisian", "Turkish", "Turkmen", "Tuvaluan",
    "Ugandan", "Ukrainian", "Uruguayan", "Uzbek",
    "Vanuatuan", "Venezuelan", "Vietnamese",
    "Welsh", "Yemeni",
    "Zambian", "Zimbabwean"
  ];
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance.collection("com").doc(userCredential.user!.uid).set({
        "fullName": nameController.text,
        "email": emailController.text,
        "NationalID": nationalIdController.text,
        "Phone": phoneController.text,
        "job": jobController.text,
        "dob": _dobController.text,
      });

      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(toggleTheme: widget.toggleTheme)));
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
    bool readOnly = false,
    VoidCallback? onTap,
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
        readOnly: readOnly,
        onTap: onTap,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                        AppLocalizations.of(context)!.per,
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
                    AppLocalizations.of(context)!.fullName,
                    _buildField(controller: nameController, hint: AppLocalizations.of(context)!.enterName),
                  ),
                  _buildSection(
                    AppLocalizations.of(context)!.email,
                    _buildField(controller: emailController, hint: AppLocalizations.of(context)!.enterEmail),
                  ),

                  _buildLabel(AppLocalizations.of(context)!.nationality),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: const Color(0xFFDE88DB).withOpacity(0.15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButton<String>(
                      value: s,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFDE88DB)),
                      items: nationalities.map((String h) {
                        return DropdownMenuItem(
                          value: h,
                          child: Text(h, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (f) => setState(() => s = f!),
                      dropdownColor: Theme.of(context).cardColor,
                    ),
                  ),
                  const SizedBox(height: 18),

                  _buildSection(
                    AppLocalizations.of(context)!.nationalID,
                    _buildField(controller: nationalIdController, hint: AppLocalizations.of(context)!.enterNationalID),
                  ),
                  _buildSection(
                    AppLocalizations.of(context)!.phone,
                    _buildField(controller: phoneController, hint: AppLocalizations.of(context)!.enterPhone),
                  ),
                  _buildSection(
                    AppLocalizations.of(context)!.job,
                    _buildField(controller: jobController, hint: AppLocalizations.of(context)!.enterJob),
                  ),
                  _buildSection(
                    AppLocalizations.of(context)!.password,
                    _buildField(controller: passwordController, hint: AppLocalizations.of(context)!.enterPassword, obscure: true),
                  ),
                  _buildSection(
                    AppLocalizations.of(context)!.dob,
                    _buildField(
                      controller: _dobController,
                      hint: AppLocalizations.of(context)!.pickDOB,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dobController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            nationalIdController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            jobController.text.isEmpty ||
                            _dobController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context)!.fill)),
                          );
                          return;
                        }

                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context)!.truee)),
                          );
                          return;
                        }

                        if (passwordController.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context)!.pass)),
                          );
                          return;
                        }

                        if (!RegExp(r'^\d{10}$').hasMatch(nationalIdController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context)!.pass2)),
                          );
                          return;
                        }

                        try {
                          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          await FirebaseFirestore.instance.collection("com").doc(userCredential.user!.uid).set({
                            "fullName": nameController.text,
                            "email": emailController.text,
                            "NationalID": nationalIdController.text,
                            "Phone": phoneController.text,
                            "job": jobController.text,
                            "dob": _dobController.text,
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => MyHomePage(toggleTheme: widget.toggleTheme)),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ).copyWith(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
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
                            MaterialPageRoute(builder: (_) => second(toggleTheme: widget.toggleTheme)),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.login,
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