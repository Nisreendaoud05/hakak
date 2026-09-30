import 'package:flutter/material.dart';
import 'Home2.dart';
import 'MyReports.dart';
import 'aipage.dart';
import 'personpage.dart';
import 'app_localizations.dart';
class Lowpage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const Lowpage({super.key, required this.toggleTheme});

  @override
  State<Lowpage> createState() => _LowpageState();
}

class _LowpageState extends State<Lowpage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _notifController;
  late Animation<double> _fadeAnim;
  late Animation<double> _notifAnim;
  bool isPink = false;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                        AppLocalizations.of(context)!.myRights,
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

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchLegalTopics,
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.35),
                          fontSize: 13,
                        ),
                        suffixIcon: const Icon(Icons.search, color: Color(0xFFDE88DB)),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xFFDE88DB).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFFDE88DB),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_back_ios, size: 14, color: Color(0xFFDE88DB)),
                          Text(
                            AppLocalizations.of(context)!.all,
                            style: const TextStyle(
                              color: Color(0xFFDE88DB),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.activeRightsTitle,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  buildCard(
                    "assets/img_1.png",
                    AppLocalizations.of(context)!.taxExemptionDeadline,
                    AppLocalizations.of(context)!.taxExemptionDesc,
                    AppLocalizations.of(context)!.details,
                    const Color(0xFFDE88DB),
                  ),

                  buildCard(
                    "assets/img_2.png",
                    AppLocalizations.of(context)!.objectionPeriodTitle,
                    AppLocalizations.of(context)!.objectionPeriodDesc,
                    AppLocalizations.of(context)!.objection,
                    Colors.grey,
                    showBadge: true,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    AppLocalizations.of(context)!.lifeEvents,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 12),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                    children: [
                      quickItem(Icons.home, AppLocalizations.of(context)!.newProperty, () {}),
                      quickItem(Icons.elderly, AppLocalizations.of(context)!.retirement, () {}),
                      quickItem(Icons.family_restroom, AppLocalizations.of(context)!.newborns, () {}),
                      quickItem(Icons.work, AppLocalizations.of(context)!.newJob, () {}),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: buildBottomBar(),
      ),
    );
  }

  Widget buildCard(
      String image,
      String title,
      String desc,
      String btn,
      Color color, {
        bool showBadge = false,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  image,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (showBadge)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          AppLocalizations.of(context)!.remainingDays,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.lastUpdate,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 11,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: Text(
                        btn,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          navItem(Icons.smart_toy_outlined, AppLocalizations.of(context)!.advisor, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => aipage(toggleTheme: widget.toggleTheme)));
          }),
          navItem(Icons.library_books_outlined, AppLocalizations.of(context)!.myReports, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => Myreports(toggleTheme: widget.toggleTheme)));
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
                  icon: const Icon(Icons.book_outlined, color: Color(0xFFDE88DB), size: 24),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.myRights,
                style: const TextStyle(
                  color: Color(0xFFDE88DB),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
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

  Widget quickItem(IconData icon, String text, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFDE88DB).withOpacity(0.12),
                ),
                child: Icon(icon, size: 32, color: const Color(0xFFDE88DB)),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}