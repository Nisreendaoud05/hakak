import 'package:flutter/material.dart';
import 'firstlogin.dart';
import 'secondpage.dart';
import 'Lowpage.dart';
import 'MyReports.dart';
import 'Home2.dart';
import 'personpage.dart';
import 'app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class aipage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const aipage({super.key, required this.toggleTheme});

  @override
  State<aipage> createState() => _AIPageState();
}

class _AIPageState extends State<aipage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _notifController;
  late Animation<double> _fadeAnim;
  late Animation<double> _notifAnim;
  bool isPink = false;

  final TextEditingController controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;
  final String _baseUrl = 'http://192.168.100.253:8000';

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
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _notifController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<String> sendMessage(String message) async {
    try {
      final url = Uri.parse('$_baseUrl/ask');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': message}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'] ?? 'لا توجد إجابة';
      } else {
        return 'حدث خطأ: ${response.statusCode}';
      }
    } catch (e) {
      return 'حدث خطأ في الاتصال: $e';
    }
  }

  void _handleSend() async {
    final userMessage = controller.text.trim();
    if (userMessage.isEmpty || isLoading) return;

    setState(() {
      messages.add({'role': 'user', 'text': userMessage});
      isLoading = true;
    });
    controller.clear();

    final reply = await sendMessage(userMessage);

    setState(() {
      messages.add({'role': 'bot', 'text': reply});
      isLoading = false;
    });
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
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
                      AppLocalizations.of(context)!.advisor,
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
              ),

              Expanded(
                child: messages.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDE88DB).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          size: 50,
                          color: Color(0xFFDE88DB),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.ask,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isUser = msg['role'] == 'user';
                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xFFDE88DB)
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: isUser
                                ? const Radius.circular(16)
                                : const Radius.circular(0),
                            bottomRight: isUser
                                ? const Radius.circular(0)
                                : const Radius.circular(16),
                          ),
                          border: Border.all(
                            color: const Color(0xFFDE88DB).withOpacity(
                              isUser ? 0 : 0.1,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          msg['text']!,
                          style: TextStyle(
                            color: isUser
                                ? const Color(0xFF1E0A23)
                                : Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFDE88DB),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'جاري الرد...',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30),
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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _handleSend,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFDE88DB), Color(0xFFB85DB5)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        textDirection: TextDirection.rtl,
                        onSubmitted: (_) => _handleSend(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'اكتب سؤالك القانوني...',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: TextStyle(
                            color: Theme.of(context).hintColor?.withOpacity(0.5),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),

        bottomNavigationBar: buildBottomBar(),
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
          navItem(Icons.person_outline, AppLocalizations.of(context)!.account, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => personpage(toggleTheme: widget.toggleTheme)));
          }),
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
                  icon: const Icon(Icons.smart_toy_outlined, color: Color(0xFFDE88DB), size: 24),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.advisor,
                style: const TextStyle(
                  color: Color(0xFFDE88DB),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
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