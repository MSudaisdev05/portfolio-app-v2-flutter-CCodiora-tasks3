import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_app/providers/profile_provider.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onNavigate;
  const HomeScreen({super.key, this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
            begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _openGitHub(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Could not open GitHub"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Scaffold(
      body: Stack(
        children: [
          // Ambient glow
          Positioned(
            top: 40,
            right: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppTheme.accent.withOpacity(0.12),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: CustomScrollView(
                  slivers: [
                    // App bar
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good morning 👋",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: kTextMuted(context),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                GradientText(
                                  "Portfolio",
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            AvatarWidget(
                              size: 42,
                              initials: profile.name.isNotEmpty
                                  ? profile.name.substring(0, 2).toUpperCase()
                                  : "MS",
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Hero section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                StatusDot(color: kAccentGreen(context)),
                                const SizedBox(width: 8),
                                Text(
                                  "Available for work",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: kAccentGreen(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Hi, I'm",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: kTextPrimary(context),
                                height: 1.1,
                              ),
                            ),
                            GradientText(
                              profile.name,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1.5,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              profile.title,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: kTextSecondary(context),
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              profile.about,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: kTextMuted(context),
                                height: 1.7,
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),

                    // Stats row
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            _statCard("5+", "Years Exp."),
                            const SizedBox(width: 12),
                            _statCard("20+", "Projects"),
                            const SizedBox(width: 12),
                            _statCard("10+", "Clients"),
                          ],
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 36)),

                    // Quick nav section header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SectionHeader(
                          "Explore",
                          subtitle: "Jump to a section",
                        ),
                      ),
                    ),

                    // Quick nav cards
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.4,
                        ),
                        delegate: SliverChildListDelegate([
                          _quickNav(
                            icon: Icons.person_rounded,
                            label: "Profile",
                            sub: "Skills & Experience",
                            color: AppTheme.accent,
                            onTap: () => widget.onNavigate?.call(1),
                          ),
                          _quickNav(
                            icon: Icons.grid_view_rounded,
                            label: "Projects",
                            sub: "${PortfolioData.projects.length} works",
                            color: AppTheme.accentWarm,
                            onTap: () => widget.onNavigate?.call(2),
                          ),
                          _quickNav(
                            icon: Icons.mail_rounded,
                            label: "Contact",
                            sub: "Get in touch",
                            color: kAccentGreen(context),
                            onTap: () => widget.onNavigate?.call(3),
                          ),
                          _quickNav(
                            icon: Icons.code_rounded,
                            label: "GitHub",
                            sub: "Open Source",
                            color: const Color(0xFFE2A84B),
                            onTap: () => _openGitHub(profile.github),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            GradientText(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: kTextMuted(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickNav({
    required IconData icon,
    required String label,
    required String sub,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kTextPrimary(context),
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: kTextMuted(context),
            ),
          ),
        ],
      ),
    );
  }
}
