import 'package:flutter/material.dart';
import 'firstlogin.dart';
import 'secondpage.dart';
import 'Lowpage.dart';
import 'MyReports.dart';
import 'aipage.dart';
import 'personpage.dart';
import 'app_localizations.dart';

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const MyHomePage({super.key, required this.toggleTheme});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _notifController;
  late Animation<double> _fadeAnim;
  late Animation<double> _notifAnim;
  bool isPink = false;
  int _selectedIndex = 4;

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
    _notifAnim = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(parent: _notifController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _notifController.dispose();
    super.dispose();
  }

  Widget buildCircleItem({
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, size: 32, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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
                      const Spacer(),
                      Text(
                        AppLocalizations.of(context)!.home,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                      const Spacer(),
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

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.seeall,

                        style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xFFDE88DB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.impo,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _importantCard(),
                  const SizedBox(height: 10),
                  _importantCard(),

                  const SizedBox(height: 28),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context)!.Quick,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCircleItem(
                        color: Colors.pink.shade100,
                        icon: Icons.menu_book,
                        text: AppLocalizations.of(context)!.Exemptions,
                        onTap: () {},
                      ),
                      buildCircleItem(
                        color: Colors.green.shade100,
                        icon: Icons.home,
                        text: AppLocalizations.of(context)!.Tenantrights,
                        onTap: () {},
                      ),
                      buildCircleItem(
                        color: Colors.pink.shade100,
                        icon: Icons.directions_car,
                        text: AppLocalizations.of(context)!.BuyingCar,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── My Rights by Case ─────────────────────
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context)!.Myrightsbycase,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _caseCard()),
                      const SizedBox(width: 12),
                      Expanded(child: _caseCard()),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),

        // ── Bottom Navigation ─────────────────────────
        bottomNavigationBar: Container(
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
              navItem(Icons.person_outline, AppLocalizations.of(context)!.account, 0, () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => personpage(toggleTheme: widget.toggleTheme),
                ));
              }),
              navItem(Icons.smart_toy_outlined, AppLocalizations.of(context)!.advisor, 1, () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => aipage(toggleTheme: widget.toggleTheme),
                ));
              }),
              navItem(Icons.library_books_outlined, AppLocalizations.of(context)!.myReports, 2, () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => Myreports(toggleTheme: widget.toggleTheme),
                ));
              }),
              navItem(Icons.book_outlined, AppLocalizations.of(context)!.myRights, 3, () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => Lowpage(toggleTheme: widget.toggleTheme),
                ));
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
                      icon: const Icon(Icons.home_rounded, color: Color(0xFFDE88DB), size: 26),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.home,
                    style: const TextStyle(
                      color: Color(0xFFDE88DB),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _importantCard() {
    return Container(
      padding: const EdgeInsets.all(18),
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
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDE88DB).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline, size: 18, color: Color(0xFFDE88DB)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.transactionDeadline,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B0B2F),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                elevation: 0,
              ),
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.Viewtransaction,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _caseCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFDE88DB).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.directions_car, color: Color(0xFFDE88DB), size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.BuyingCar,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.dis,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).hintColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDE88DB),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
              ),
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.follow,
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, String text, int index, VoidCallback onTap) {
    final bool isSelected = _selectedIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            setState(() => _selectedIndex = index);
            onTap();
          },
          icon: Icon(
            icon,
            color: isSelected
                ? const Color(0xFFDE88DB)
                : Theme.of(context).iconTheme.color?.withOpacity(0.5),
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? const Color(0xFFDE88DB)
                : Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}