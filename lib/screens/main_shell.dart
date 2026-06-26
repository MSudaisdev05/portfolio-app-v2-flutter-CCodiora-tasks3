import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/shared_widgets.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'project_screen.dart';
import 'contact_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.home_rounded, Icons.home_outlined, "Home"),
    _NavItem(Icons.person_rounded, Icons.person_outline_rounded, "Profile"),
    _NavItem(Icons.grid_view_rounded, Icons.grid_view_outlined, "Projects"),
    _NavItem(Icons.mail_rounded, Icons.mail_outline_rounded, "Contact"),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    // ✅ Screens list inside build method so setState works correctly
    final List<Widget> screens = [
      HomeScreen(onNavigate: (index) => setState(() => _currentIndex = index)),
      const ProfileScreen(),
      const ProjectsScreen(),
      const ContactScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kSurface(context),
          border: Border(top: BorderSide(color: kDivider(context), width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...List.generate(_navItems.length, (i) {
                  final item = _navItems[i];
                  final selected = i == _currentIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _currentIndex = i),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected
                            ? kAccent(context).withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            selected ? item.activeIcon : item.inactiveIcon,
                            size: 22,
                            color: selected
                                ? kAccent(context)
                                : kTextMuted(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: selected
                                  ? kAccent(context)
                                  : kTextMuted(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                // Theme toggle
                GestureDetector(
                  onTap: () => themeProvider.toggle(),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          themeProvider.isDark
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          size: 22,
                          color: kTextMuted(context),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          themeProvider.isDark ? "Light" : "Dark",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: kTextMuted(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  const _NavItem(this.activeIcon, this.inactiveIcon, this.label);
}
