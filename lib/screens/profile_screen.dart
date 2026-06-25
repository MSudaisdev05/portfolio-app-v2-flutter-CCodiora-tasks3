import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';
import '../providers/profile_provider.dart';
import '../providers/theme_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() { super.initState(); _tabCtrl = TabController(length: 3, vsync: this); }
  @override
  void dispose() { _tabCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: kBackground(context),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: _buildHeader(context, profile, themeProvider)),
            SliverToBoxAdapter(child: _buildTabBar(context)),
          ],
          body: TabBarView(controller: _tabCtrl, children: [
            _AboutTab(profile: profile),
            const _SkillsTab(),
            const _ExperienceTab(),
          ]),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileProvider profile, ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Column(children: [
        Row(children: [
          AvatarWidget(size: 72, initials: profile.name.isNotEmpty ? profile.name.substring(0, 2).toUpperCase() : "AM"),
          const SizedBox(width: 18),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(profile.name, style: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w700, color: kTextPrimary(context), letterSpacing: -0.5)),
            const SizedBox(height: 4),
            Text(profile.title, style: GoogleFonts.inter(fontSize: 12, color: kTextSecondary(context), height: 1.4)),
            const SizedBox(height: 8),
            Row(children: [
              StatusDot(color: kAccentGreen(context)),
              const SizedBox(width: 6),
              Text("Open to opportunities", style: GoogleFonts.inter(fontSize: 11, color: kAccentGreen(context), fontWeight: FontWeight.w500)),
            ]),
          ])),
          // Action buttons
          Column(children: [
            // Dark mode toggle
            GestureDetector(
              onTap: () => themeProvider.toggle(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: kSurfaceAlt(context), borderRadius: BorderRadius.circular(10), border: Border.all(color: kDivider(context))),
                child: Icon(themeProvider.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, size: 18, color: kTextSecondary(context)),
              ),
            ),
            const SizedBox(height: 8),
            // Edit button
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: kSurfaceAlt(context), borderRadius: BorderRadius.circular(10), border: Border.all(color: kDivider(context))),
                child: Icon(Icons.edit_outlined, size: 18, color: kTextSecondary(context)),
              ),
            ),
          ]),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          _infoChip(context, Icons.location_on_outlined, profile.location),
          const SizedBox(width: 10),
          _infoChip(context, Icons.work_outline_rounded, "Full-Time"),
        ]),
      ]),
    );
  }

  Widget _infoChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: kSurfaceAlt(context), borderRadius: BorderRadius.circular(8), border: Border.all(color: kDivider(context))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 13, color: kTextMuted(context)),
        const SizedBox(width: 5),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: kTextSecondary(context))),
      ]),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: kSurfaceAlt(context), borderRadius: BorderRadius.circular(12), border: Border.all(color: kDivider(context))),
      child: TabBar(
        controller: _tabCtrl,
        indicator: BoxDecoration(gradient: AppTheme.accentGradient, borderRadius: BorderRadius.circular(10)),
        indicatorPadding: const EdgeInsets.all(4),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
        labelColor: Colors.white,
        unselectedLabelColor: kTextMuted(context),
        tabs: const [Tab(text: "About"), Tab(text: "Skills"), Tab(text: "Experience")],
      ),
    );
  }
}

// ─── About Tab ────────────────────────────────────────────────────────────────
class _AboutTab extends StatelessWidget {
  final ProfileProvider profile;
  const _AboutTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeader("About Me"),
        GlassCard(child: Text(profile.about, style: GoogleFonts.inter(fontSize: 14, color: kTextSecondary(context), height: 1.75))),
        const SizedBox(height: 28),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SectionHeader("Personal Details"),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: kTagBg(context), borderRadius: BorderRadius.circular(8), border: Border.all(color: kAccent(context).withOpacity(0.3))),
              child: Row(children: [
                Icon(Icons.edit_rounded, size: 12, color: kAccent(context)),
                const SizedBox(width: 4),
                Text("Edit", style: GoogleFonts.inter(fontSize: 12, color: kAccent(context), fontWeight: FontWeight.w500)),
              ]),
            ),
          ),
        ]),
        GlassCard(child: Column(children: [
          _detail(context, Icons.person_outline_rounded, "Name", profile.name),
          _divider(context),
          _detail(context, Icons.alternate_email_rounded, "Email", profile.email),
          _divider(context),
          _detail(context, Icons.phone_outlined, "Phone", profile.phone),
          _divider(context),
          _detail(context, Icons.location_on_outlined, "Location", profile.location),
          _divider(context),
          _detail(context, Icons.language_outlined, "Website", profile.website),
        ])),
        const SizedBox(height: 28),

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SectionHeader("Contact Links"),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen(isContact: true))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: kTagBg(context), borderRadius: BorderRadius.circular(8), border: Border.all(color: kAccent(context).withOpacity(0.3))),
              child: Row(children: [
                Icon(Icons.edit_rounded, size: 12, color: kAccent(context)),
                const SizedBox(width: 4),
                Text("Edit", style: GoogleFonts.inter(fontSize: 12, color: kAccent(context), fontWeight: FontWeight.w500)),
              ]),
            ),
          ),
        ]),
        GlassCard(child: Column(children: [
          _detail(context, Icons.code_rounded, "GitHub", profile.github),
          _divider(context),
          _detail(context, Icons.business_center_outlined, "LinkedIn", profile.linkedin),
          _divider(context),
          _detail(context, Icons.tag_rounded, "Twitter", profile.twitter),
        ])),

        const SizedBox(height: 28),
        const SectionHeader("Interests"),
        Wrap(spacing: 8, runSpacing: 8, children: ["Open Source", "System Design", "UI/UX Design", "Developer Tools", "Performance", "Accessibility"].map((t) => TechTag(t)).toList()),
      ]),
    );
  }

  Widget _detail(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(children: [
        Container(width: 32, height: 32, decoration: BoxDecoration(color: kAccent(context).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 15, color: kAccent(context))),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: GoogleFonts.inter(fontSize: 11, color: kTextMuted(context))),
          Text(value, style: GoogleFonts.inter(fontSize: 13, color: kTextPrimary(context), fontWeight: FontWeight.w500)),
        ])),
      ]),
    );
  }

  Widget _divider(BuildContext context) => Container(height: 1, color: kDivider(context));
}

// ─── Skills Tab ───────────────────────────────────────────────────────────────
class _SkillsTab extends StatelessWidget {
  const _SkillsTab();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoryColors = {
      SkillCategory.mobile: isDark ? AppTheme.darkAccent : AppTheme.accent,
      SkillCategory.frontend: AppTheme.accentWarm,
      SkillCategory.backend: isDark ? AppTheme.darkAccentGreen : AppTheme.accentGreen,
      SkillCategory.design: const Color(0xFFE2A84B),
    };
    final categoryLabels = {
      SkillCategory.mobile: "Mobile",
      SkillCategory.frontend: "Frontend",
      SkillCategory.backend: "Backend",
      SkillCategory.design: "Design",
    };

    final grouped = <SkillCategory, List<Skill>>{};
    for (final s in PortfolioData.skills) { grouped.putIfAbsent(s.category, () => []).add(s); }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ...SkillCategory.values.map((cat) {
          final skills = grouped[cat];
          if (skills == null || skills.isEmpty) return const SizedBox.shrink();
          final color = categoryColors[cat]!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withOpacity(0.25), width: 1)),
                child: Text(categoryLabels[cat]!, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
              ),
              const SizedBox(height: 14),
              GlassCard(child: Column(children: skills.map((s) => SkillBar(name: s.name, level: s.level, color: color)).toList())),
            ]),
          );
        }),
      ]),
    );
  }
}

// ─── Experience Tab ───────────────────────────────────────────────────────────
class _ExperienceTab extends StatelessWidget {
  const _ExperienceTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeader("Work Experience"),
        ...PortfolioData.experiences.asMap().entries.map((entry) {
          final i = entry.key;
          final exp = entry.value;
          final isLast = i == PortfolioData.experiences.length - 1;
          return IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                Container(width: 12, height: 12, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppTheme.accentGradient)),
                if (!isLast) Expanded(child: Container(width: 1.5, color: kDivider(context), margin: const EdgeInsets.symmetric(vertical: 4))),
              ]),
              const SizedBox(width: 16),
              Expanded(child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Text(exp.role, style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w600, color: kTextPrimary(context)))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: kAccent(context).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(exp.period, style: GoogleFonts.inter(fontSize: 11, color: kAccent(context), fontWeight: FontWeight.w500)),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text(exp.company, style: GoogleFonts.inter(fontSize: 13, color: kTextSecondary(context), fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Text(exp.description, style: GoogleFonts.inter(fontSize: 13, color: kTextMuted(context), height: 1.6)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 6, runSpacing: 6, children: exp.tech.map((t) => TechTag(t, small: true)).toList()),
                ])),
              )),
            ]),
          );
        }),
      ]),
    );
  }
}
