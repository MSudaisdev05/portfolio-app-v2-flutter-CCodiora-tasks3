import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';
import 'project_details_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});
  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _filter = "All";
  String _search = "";
  final _searchController = TextEditingController();
  final _categories = ["All", "Mobile App", "Web App", "Open Source"];

  List<Project> get _filtered {
    var list = _filter == "All" ? PortfolioData.projects : PortfolioData.projects.where((p) => p.category == _filter).toList();
    if (_search.isNotEmpty) {
      final q = _search.toLowerCase();
      list = list.where((p) => p.title.toLowerCase().contains(q) || p.description.toLowerCase().contains(q) || p.tech.any((t) => t.toLowerCase().contains(q))).toList();
    }
    return list;
  }

  @override
  void dispose() { _searchController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: kBackground(context),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 4),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const SectionHeader("Projects"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: kSurfaceAlt(context), borderRadius: BorderRadius.circular(8), border: Border.all(color: kDivider(context))),
                child: Text("${filtered.length} works", style: GoogleFonts.inter(fontSize: 12, color: kTextMuted(context))),
              ),
            ]),
          )),

          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _search = v),
              style: GoogleFonts.inter(fontSize: 14, color: kTextPrimary(context)),
              decoration: InputDecoration(
                hintText: "Search projects, tech...",
                prefixIcon: Icon(Icons.search_rounded, color: kTextMuted(context), size: 20),
                suffixIcon: _search.isNotEmpty ? IconButton(icon: Icon(Icons.close_rounded, color: kTextMuted(context), size: 18), onPressed: () { _searchController.clear(); setState(() => _search = ""); }) : null,
              ),
            ),
          )),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverToBoxAdapter(child: SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final selected = _filter == cat;
                return GestureDetector(
                  onTap: () => setState(() => _filter = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: selected ? AppTheme.accentGradient : null,
                      color: selected ? null : kSurfaceAlt(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: selected ? Colors.transparent : kDivider(context)),
                    ),
                    child: Text(cat, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: selected ? Colors.white : kTextSecondary(context))),
                  ),
                );
              },
            ),
          )),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          if (filtered.isEmpty)
            SliverToBoxAdapter(child: Center(child: Padding(
              padding: const EdgeInsets.all(48),
              child: Column(children: [
                Icon(Icons.search_off_rounded, size: 56, color: kTextMuted(context)),
                const SizedBox(height: 12),
                Text("No projects found", style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: kTextSecondary(context))),
                const SizedBox(height: 6),
                Text("Try a different search or filter", style: GoogleFonts.inter(fontSize: 13, color: kTextMuted(context))),
              ]),
            ))),

          if (_filter == "All" && _search.isEmpty) ...[
            SliverToBoxAdapter(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _FeaturedBanner(
                project: PortfolioData.projects.firstWhere((p) => p.isFeatured),
                onTap: (p) => Navigator.push(context, MaterialPageRoute(builder: (_) => ProjectDetailScreen(project: p))),
              ),
            )),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            sliver: SliverList(delegate: SliverChildBuilderDelegate(
              (context, i) {
                final project = filtered[i];
                if (_filter == "All" && _search.isEmpty && project.isFeatured && i == 0) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ProjectCard(project: project, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProjectDetailScreen(project: project)))),
                );
              },
              childCount: filtered.length,
            )),
          ),
        ]),
      ),
    );
  }
}

class _FeaturedBanner extends StatelessWidget {
  final Project project;
  final void Function(Project) onTap;
  const _FeaturedBanner({required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(project),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [kTagBg(context), kSurface(context)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kAccent(context).withOpacity(0.35)),
          boxShadow: [BoxShadow(color: kAccent(context).withOpacity(0.12), blurRadius: 24, offset: const Offset(0, 6))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(gradient: AppTheme.accentGradient, borderRadius: BorderRadius.circular(6)),
              child: Text("✦ Featured", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white))),
            const Spacer(),
            TechTag(project.category, small: true),
          ]),
          const SizedBox(height: 14),
          Text(project.title, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: kTextPrimary(context), letterSpacing: -0.3)),
          const SizedBox(height: 8),
          Text(project.description, style: GoogleFonts.inter(fontSize: 13, color: kTextSecondary(context), height: 1.6), maxLines: 3, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 14),
          Wrap(spacing: 6, runSpacing: 6, children: project.tech.map((t) => TechTag(t, small: true)).toList()),
          const SizedBox(height: 16),
          Row(children: [
            Icon(Icons.bar_chart_rounded, size: 14, color: kAccentGreen(context)),
            const SizedBox(width: 6),
            Text(project.stats, style: GoogleFonts.inter(fontSize: 12, color: kAccentGreen(context), fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(Icons.arrow_forward_rounded, size: 16, color: kAccent(context)),
            const SizedBox(width: 4),
            Text("View Details", style: GoogleFonts.inter(fontSize: 12, color: kAccent(context), fontWeight: FontWeight.w600)),
          ]),
        ]),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  const _ProjectCard({required this.project, required this.onTap});

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
    return GlassCard(
      highlight: project.isFeatured,
      onTap: onTap,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            gradient: project.isFeatured ? AppTheme.accentGradient : LinearGradient(colors: [kSurfaceAlt(context), kDivider(context)]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(_iconForCategory(project.category), color: project.isFeatured ? Colors.white : kTextMuted(context), size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(project.title, style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w600, color: kTextPrimary(context)))),
            Icon(Icons.arrow_forward_ios_rounded, size: 12, color: kTextMuted(context)),
          ]),
          const SizedBox(height: 4),
          Text(project.description, style: GoogleFonts.inter(fontSize: 12, color: kTextMuted(context), height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: Wrap(spacing: 5, runSpacing: 5, children: project.tech.take(3).map((t) => TechTag(t, small: true)).toList())),
            Text(project.stats, style: GoogleFonts.inter(fontSize: 11, color: kAccentGreen(context), fontWeight: FontWeight.w500)),
          ]),
        ])),
      ]),
    );
  }
}
