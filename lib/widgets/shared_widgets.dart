import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ─── Theme helpers ────────────────────────────────────────────────────────────
Color kSurface(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkSurface : AppTheme.surface;
Color kSurfaceAlt(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkSurfaceAlt : AppTheme.surfaceAlt;
Color kTextPrimary(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
Color kTextSecondary(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkTextSecondary : AppTheme.textSecondary;
Color kTextMuted(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkTextMuted : AppTheme.textMuted;
Color kDivider(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkDivider : AppTheme.divider;
Color kTagBg(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkTagBg : AppTheme.tagBg;
Color kAccent(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkAccent : AppTheme.accent;
Color kAccentGreen(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkAccentGreen : AppTheme.accentGreen;
Color kBackground(BuildContext ctx) =>
    Theme.of(ctx).brightness == Brightness.dark ? AppTheme.darkBackground : AppTheme.background;

// ─── Gradient Text ────────────────────────────────────────────────────────────
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  const GradientText(this.text, {super.key, this.style, this.gradient = AppTheme.accentGradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }
}

// ─── Tech Tag ─────────────────────────────────────────────────────────────────
class TechTag extends StatelessWidget {
  final String label;
  final bool small;
  const TechTag(this.label, {super.key, this.small = false});

  @override
  Widget build(BuildContext context) {
    final accent = kAccent(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 8 : 10, vertical: small ? 3 : 5),
      decoration: BoxDecoration(
        color: kTagBg(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withOpacity(0.2), width: 1),
      ),
      child: Text(label, style: GoogleFonts.inter(fontSize: small ? 10 : 12, fontWeight: FontWeight.w500, color: accent.withOpacity(0.9), letterSpacing: 0.3)),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const SectionHeader(this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 4, height: 22, decoration: BoxDecoration(gradient: AppTheme.accentGradient, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
            GradientText(title, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.3)),
          ]),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Padding(padding: const EdgeInsets.only(left: 14), child: Text(subtitle!, style: GoogleFonts.inter(fontSize: 13, color: kTextMuted(context)))),
          ],
        ],
      ),
    );
  }
}

// ─── Glass Card ───────────────────────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final bool highlight;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  const GlassCard({super.key, required this.child, this.highlight = false, this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    final accent = kAccent(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kSurface(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: highlight ? accent.withOpacity(0.4) : kDivider(context), width: highlight ? 1.5 : 1),
          boxShadow: [BoxShadow(color: highlight ? accent.withOpacity(0.08) : Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 3))],
        ),
        child: child,
      ),
    );
  }
}

// ─── Avatar Widget ────────────────────────────────────────────────────────────
class AvatarWidget extends StatelessWidget {
  final double size;
  final String initials;
  const AvatarWidget({super.key, required this.size, required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.accentGradient,
        boxShadow: [
          BoxShadow(
            color: kAccent(context).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile.jpg',
          fit: BoxFit.cover,
          width: size,
          height: size,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                initials,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: size * 0.28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// ─── Status Dot ───────────────────────────────────────────────────────────────
class StatusDot extends StatelessWidget {
  final Color color;
  const StatusDot({super.key, required this.color});
  @override
  Widget build(BuildContext context) => Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

// ─── Skill Bar ────────────────────────────────────────────────────────────────
class SkillBar extends StatelessWidget {
  final String name;
  final int level;
  final Color color;
  const SkillBar({super.key, required this.name, required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: kTextPrimary(context))),
          Text('$level%', style: GoogleFonts.inter(fontSize: 12, color: kTextMuted(context), fontWeight: FontWeight.w500)),
        ]),
        const SizedBox(height: 8),
        ClipRRect(borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: level / 100, backgroundColor: kDivider(context), valueColor: AlwaysStoppedAnimation<Color>(color), minHeight: 6)),
      ]),
    );
  }
}
