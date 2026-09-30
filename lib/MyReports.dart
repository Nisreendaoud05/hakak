import 'package:flutter/material.dart';
import 'Home2.dart';
import 'Lowpage.dart';
import 'aipage.dart';
import 'personpage.dart';
import 'app_localizations.dart';

class Myreports extends StatefulWidget {
  final VoidCallback toggleTheme;
  const Myreports({super.key, required this.toggleTheme});

  @override
  State<Myreports> createState() => _MyreportsState();
}

class _MyreportsState extends State<Myreports> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _notifController;
  late Animation<double> _fadeAnim;
  late Animation<double> _notifAnim;
  bool isPink = false;
  int _selectedTab = 0; // 0 = In Progress, 1 = Completed

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
    return Directionality(
      textDirection: Localizations.localeOf(context).languageCode == 'ar'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFDE88DB),
          elevation: 4,
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ),
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
                                  _notifController
                                      .forward()
                                      .then((_) => _notifController.reverse());
                                  setState(() => isPink = !isPink);
                                },
                                icon: Icon(
                                  isPink
                                      ? Icons.notifications
                                      : Icons.notifications_outlined,
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
                        AppLocalizations.of(context)!.myReports,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                        hintText: AppLocalizations.of(context)!.Searchreports,
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.35),
                          fontSize: 13,
                        ),
                        suffixIcon:
                        const Icon(Icons.search, color: Color(0xFFDE88DB)),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
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
                          const Icon(Icons.arrow_back_ios,
                              size: 14, color: Color(0xFFDE88DB)),
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
                        AppLocalizations.of(context)!.InProgress,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  buildReportCard(
                    icon: Icons.gavel,
                    title: AppLocalizations.of(context)!.objectionAmmanViolation,
                    desc: AppLocalizations.of(context)!.objectionDesc,
                    progress: 0.6,
                    percent: "60%",
                    status: AppLocalizations.of(context)!.processingStage,
                    statusColor: const Color(0xFFDE88DB),
                    ref: "#REF-88291",
                  ),

                  buildReportCard(
                    icon: Icons.work_outline,
                    title: AppLocalizations.of(context)!.laborComplaint,
                    desc: AppLocalizations.of(context)!.laborComplaintDesc,
                    progress: 0.25,
                    percent: "25%",
                    status: AppLocalizations.of(context)!.actionRequired,
                    statusColor: Colors.orange,
                    ref: "#REF-44102",
                    showBadge: true,
                  ),

                  buildReportCard(
                    icon: Icons.balance,
                    title: AppLocalizations.of(context)!.legalConsultation,
                    desc: AppLocalizations.of(context)!.rentalConsultationDesc,
                    progress: 0.05,
                    percent: "5%",
                    status: AppLocalizations.of(context)!.underReview,
                    statusColor: Colors.grey,
                    ref: "#REF-77654",
                  ),

                  const SizedBox(height: 24),

                  Text(
                    AppLocalizations.of(context)!.quickActions,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 12),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                    children: [
                      quickItem(Icons.add_circle_outline,
                          AppLocalizations.of(context)!.newReport, () {}),
                      quickItem(Icons.history,
                          AppLocalizations.of(context)!.history, () {}),
                      quickItem(Icons.attach_file,
                          AppLocalizations.of(context)!.attachDocuments, () {}),
                      quickItem(Icons.support_agent,
                          AppLocalizations.of(context)!.contactSupport, () {}),
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

  Widget buildReportCard({
    required IconData icon,
    required String title,
    required String desc,
    required double progress,
    required String percent,
    required String status,
    required Color statusColor,
    required String ref,
    bool showBadge = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border:
        Border.all(color: const Color(0xFFDE88DB).withOpacity(0.1)),
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
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(18)),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFDE88DB).withOpacity(0.18),
                        const Color(0xFFDE88DB).withOpacity(0.04),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFFDE88DB).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon,
                              size: 30, color: const Color(0xFFDE88DB)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 14,
                child: Text(
                  ref,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                  ),
                ),
              ),
              if (showBadge)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.priority_high,
                            size: 14, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          AppLocalizations.of(context)!.actionRequired,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange),
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
                // Status pill + title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  desc,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 7,
                          color: const Color(0xFFDE88DB),
                          backgroundColor:
                          const Color(0xFFDE88DB).withOpacity(0.12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      percent,
                      style: const TextStyle(
                        color: Color(0xFFDE88DB),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
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
                        backgroundColor: const Color(0xFFDE88DB),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.ViewDetails,
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
            border: Border.all(
                color: const Color(0xFFDE88DB).withOpacity(0.1)),
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
                child:
                Icon(icon, size: 32, color: const Color(0xFFDE88DB)),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
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
          navItem(Icons.person_outline,
              AppLocalizations.of(context)!.account, () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            personpage(toggleTheme: widget.toggleTheme)));
              }),
          navItem(Icons.smart_toy_outlined,
              AppLocalizations.of(context)!.advisor, () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            aipage(toggleTheme: widget.toggleTheme)));
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
                  icon: const Icon(Icons.library_books_outlined,
                      color: Color(0xFFDE88DB), size: 24),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.myReports,
                style: const TextStyle(
                  color: Color(0xFFDE88DB),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          navItem(
              Icons.book_outlined, AppLocalizations.of(context)!.myRights,
                  () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            Lowpage(toggleTheme: widget.toggleTheme)));
              }),
          navItem(Icons.home_outlined, AppLocalizations.of(context)!.home,
                  () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            MyHomePage(toggleTheme: widget.toggleTheme)));
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
            color:
            Theme.of(context).iconTheme.color?.withOpacity(0.5),
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color:
            Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
