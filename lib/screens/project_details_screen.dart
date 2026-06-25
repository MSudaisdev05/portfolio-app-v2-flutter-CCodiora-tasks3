import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;
  const ProjectDetailScreen({super.key, required this.project});

  IconData _iconForCategory(String cat) {
    switch (cat) {
      case "Mobile App": return Icons.smartphone_rounded;
      case "Web App": return Icons.web_rounded;
      case "Open Source": return Icons.terminal_rounded;
      default: return Icons.folder_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground(context),
      appBar: AppBar(
        backgroundColor: kBackground(context),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: kTextPrimary(context), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Project Details", style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: kTextPrimary(context))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kTagBg(context), kSurface(context)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kAccent(context).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        gradient: project.isFeatured ? AppTheme.accentGradient : LinearGradient(colors: [kSurfaceAlt(context), kDivider(context)]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(_iconForCategory(project.category), color: project.isFeatured ? Colors.white : kTextMuted(context), size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      TechTag(project.category),
                      const SizedBox(height: 6),
                      if (project.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(gradient: AppTheme.accentGradient, borderRadius: BorderRadius.circular(6)),
                          child: Text("✦ Featured Project", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                    ])),
                  ]),
                  const SizedBox(height: 16),
                  Text(project.title, style: GoogleFonts.spaceGrotesk(fontSize: 26, fontWeight: FontWeight.w700, color: kTextPrimary(context), letterSpacing: -0.5)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.bar_chart_rounded, size: 14, color: kAccentGreen(context)),
                    const SizedBox(width: 6),
                    Text(project.stats, style: GoogleFonts.inter(fontSize: 13, color: kAccentGreen(context), fontWeight: FontWeight.w500)),
                  ]),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Description
            Text("About This Project", style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: kTextPrimary(context))),
            const SizedBox(height: 12),
            GlassCard(
              child: Text(project.description, style: GoogleFonts.inter(fontSize: 14, color: kTextSecondary(context), height: 1.8)),
            ),

            const SizedBox(height: 24),

            // Technologies
            Text("Technologies Used", style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: kTextPrimary(context))),
            const SizedBox(height: 12),
            GlassCard(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: project.tech.map((t) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: kTagBg(context),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kAccent(context).withOpacity(0.25)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.code_rounded, size: 14, color: kAccent(context)),
                      const SizedBox(width: 6),
                      Text(t, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: kAccent(context))),
                    ]),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Project Image placeholder
            Text("Project Preview", style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: kTextPrimary(context))),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kSurfaceAlt(context), kDivider(context)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kDivider(context)),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.image_outlined, size: 48, color: kTextMuted(context)),
                const SizedBox(height: 8),
                Text("Project Screenshot", style: GoogleFonts.inter(fontSize: 13, color: kTextMuted(context))),
                Text("Add images to assets/images/", style: GoogleFonts.inter(fontSize: 11, color: kTextMuted(context))),
              ]),
            ),

            const SizedBox(height: 28),

            // Links
            Text("Project Links", style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: kTextPrimary(context))),
            const SizedBox(height: 12),
            Row(children: [
              if (project.liveUrl.isNotEmpty)
                Expanded(child: _LinkButton(icon: Icons.open_in_new_rounded, label: "Live Demo", url: project.liveUrl, isPrimary: true)),
              if (project.liveUrl.isNotEmpty && project.repoUrl.isNotEmpty)
                const SizedBox(width: 12),
              if (project.repoUrl.isNotEmpty)
                Expanded(child: _LinkButton(icon: Icons.code_rounded, label: "Source Code", url: project.repoUrl, isPrimary: false)),
            ]),
            if (project.liveUrl.isEmpty && project.repoUrl.isEmpty)
              GlassCard(
                child: Row(children: [
                  Icon(Icons.info_outline_rounded, color: kTextMuted(context), size: 18),
                  const SizedBox(width: 10),
                  Text("No links available for this project", style: GoogleFonts.inter(fontSize: 13, color: kTextMuted(context))),
                ]),
              ),
          ],
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isPrimary;
  const _LinkButton({required this.icon, required this.label, required this.url, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    final accent = kAccent(context);
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Opening: $url"), behavior: SnackBarBehavior.floating),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: isPrimary ? AppTheme.accentGradient : null,
          color: isPrimary ? null : kSurfaceAlt(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isPrimary ? Colors.transparent : kDivider(context)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 16, color: isPrimary ? Colors.white : accent),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isPrimary ? Colors.white : accent)),
        ]),
      ),
    );
  }
}
