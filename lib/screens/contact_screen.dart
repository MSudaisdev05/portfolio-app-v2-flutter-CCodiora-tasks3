import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/shared_widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  void _copy(BuildContext context, String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$label copied",
          style: GoogleFonts.inter(fontSize: 13, color: kTextPrimary(context)),
        ),
        backgroundColor: kSurfaceAlt(context),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                "Contact",
                subtitle: "Let's build something together",
              ),

              // Hero CTA card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kTagBg(context), kSurface(context)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.accent.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accent.withOpacity(0.10),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AvatarWidget(size: 52, initials: "AM"),
                    const SizedBox(height: 16),
                    Text(
                      "Open to new projects",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Whether you have a project in mind or just want to connect — "
                      "my inbox is always open. I typically respond within 24 hours.",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: kTextSecondary(context),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        // ✅ CORRECT
                          StatusDot(color: kAccentGreen(context)),
                          const SizedBox(width: 8),
                        Text(
                          "Available for freelance & full-time",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: kAccentGreen(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              const SectionHeader("Direct Contact"),

              // Email
              _ContactTile(
                icon: Icons.alternate_email_rounded,
                label: "Email",
                value: PortfolioData.email,
                iconColor: AppTheme.accent,
                onCopy: () => _copy(context, PortfolioData.email, "Email"),
              ),
              const SizedBox(height: 12),

              // Phone
              _ContactTile(
                icon: Icons.phone_outlined,
                label: "Phone",
                value: PortfolioData.phone,
                iconColor: kAccentGreen(context),
                onCopy: () => _copy(context, PortfolioData.phone, "Phone"),
              ),
              const SizedBox(height: 12),

              // Location
              _ContactTile(
                icon: Icons.location_on_outlined,
                label: "Location",
                value: PortfolioData.location,
                iconColor: AppTheme.accentWarm,
                copyable: false,
              ),

              const SizedBox(height: 32),
              const SectionHeader("Social Links"),

              // Social grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.4,
                children: [
                  _SocialCard(
                    label: "GitHub",
                    handle: "@alexmorgan",
                    icon: Icons.code_rounded,
                    color: const Color(0xFF6E7681),
                  ),
                  _SocialCard(
                    label: "LinkedIn",
                    handle: "alexmorgan",
                    icon: Icons.work_outline_rounded,
                    color: const Color(0xFF0A66C2),
                  ),
                  _SocialCard(
                    label: "Twitter",
                    handle: "@alexmorgan_dev",
                    icon: Icons.alternate_email_rounded,
                    color: const Color(0xFF1DA1F2),
                  ),
                  _SocialCard(
                    label: "Website",
                    handle: "alexmorgan.dev",
                    icon: Icons.language_outlined,
                    color: AppTheme.accent,
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const SectionHeader("Send a Message"),

              // Contact form
              const _ContactForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Contact Tile ─────────────────────────────────────────────────────────────
class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final VoidCallback? onCopy;
  final bool copyable;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.onCopy,
    this.copyable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: kTextMuted(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: kTextPrimary(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: onCopy,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: kSurfaceAlt(context),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kDivider(context)),
                ),
                child:  Icon(
                  Icons.copy_rounded,
                  size: 15,
                  color: kTextMuted(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Social Card ──────────────────────────────────────────────────────────────
class _SocialCard extends StatelessWidget {
  final String label;
  final String handle;
  final IconData icon;
  final Color color;

  const _SocialCard({
    required this.label,
    required this.handle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary(context),
                  ),
                ),
                Text(
                  handle,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: kTextMuted(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Contact Form ─────────────────────────────────────────────────────────────
class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sent = false;
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      _sending = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return GlassCard(
        highlight: true,
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppTheme.accentGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              "Message sent!",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kTextPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Thanks for reaching out. I'll get back to you within 24 hours.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: kTextSecondary(context),
                height: 1.5,
              ),
            ),
          ],
        ),
      );
    }

    return GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _field(
              controller: _nameCtrl,
              label: "Your name",
              hint: "John Doe",
              icon: Icons.person_outline_rounded,
              validator: (v) =>
                  (v?.isNotEmpty ?? false) ? null : "Name is required",
            ),
            const SizedBox(height: 12),
            _field(
              controller: _emailCtrl,
              label: "Email address",
              hint: "john@example.com",
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
                  v != null && v.contains('@') ? null : "Enter valid email",
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _msgCtrl,
              maxLines: 4,
              style: GoogleFonts.inter(
                  fontSize: 14, color: kTextPrimary(context)),
              validator: (v) =>
                  (v?.length ?? 0) > 10 ? null : "Message too short",
              decoration: InputDecoration(
                labelText: "Message",
                hintText: "Tell me about your project...",
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Icon(Icons.message_outlined,
                      size: 18, color: kTextMuted(context)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _sending ? null : _send,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: _sending ? null : AppTheme.accentGradient,
                  color: _sending ? kSurfaceAlt(context) : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _sending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppTheme.accent),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.send_rounded,
                                size: 16, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              "Send Message",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, color: kTextPrimary(context)),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 18, color: kTextMuted(context)),
      ),
    );
  }
}
