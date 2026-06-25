import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/shared_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final bool isContact;
  const EditProfileScreen({super.key, this.isContact = false});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  // Personal controllers
  late TextEditingController _nameCtrl;
  late TextEditingController _titleCtrl;
  late TextEditingController _taglineCtrl;
  late TextEditingController _aboutCtrl;
  late TextEditingController _locationCtrl;

  // Contact controllers
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _websiteCtrl;
  late TextEditingController _githubCtrl;
  late TextEditingController _linkedinCtrl;
  late TextEditingController _twitterCtrl;

  @override
  void initState() {
    super.initState();
    final p = context.read<ProfileProvider>();
    _nameCtrl = TextEditingController(text: p.name);
    _titleCtrl = TextEditingController(text: p.title);
    _taglineCtrl = TextEditingController(text: p.tagline);
    _aboutCtrl = TextEditingController(text: p.about);
    _locationCtrl = TextEditingController(text: p.location);
    _emailCtrl = TextEditingController(text: p.email);
    _phoneCtrl = TextEditingController(text: p.phone);
    _websiteCtrl = TextEditingController(text: p.website);
    _githubCtrl = TextEditingController(text: p.github);
    _linkedinCtrl = TextEditingController(text: p.linkedin);
    _twitterCtrl = TextEditingController(text: p.twitter);
  }

  @override
  void dispose() {
    for (final c in [_nameCtrl, _titleCtrl, _taglineCtrl, _aboutCtrl, _locationCtrl, _emailCtrl, _phoneCtrl, _websiteCtrl, _githubCtrl, _linkedinCtrl, _twitterCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final p = context.read<ProfileProvider>();
    if (widget.isContact) {
      await p.saveContact(
        newEmail: _emailCtrl.text.trim(),
        newPhone: _phoneCtrl.text.trim(),
        newWebsite: _websiteCtrl.text.trim(),
        newGithub: _githubCtrl.text.trim(),
        newLinkedin: _linkedinCtrl.text.trim(),
        newTwitter: _twitterCtrl.text.trim(),
      );
    } else {
      await p.savePersonal(
        newName: _nameCtrl.text.trim(),
        newTitle: _titleCtrl.text.trim(),
        newTagline: _taglineCtrl.text.trim(),
        newAbout: _aboutCtrl.text.trim(),
        newLocation: _locationCtrl.text.trim(),
      );
    }
    setState(() => _saving = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("✅ Saved successfully!"),
        backgroundColor: kAccentGreen(context),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ));
      Navigator.pop(context);
    }
  }

  Widget _field(String label, TextEditingController ctrl, {int maxLines = 1, String? hint, TextInputType? type, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: type,
        style: GoogleFonts.inter(fontSize: 14, color: kTextPrimary(context)),
        validator: validator ?? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
        decoration: InputDecoration(labelText: label, hintText: hint),
      ),
    );
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
        title: Text(
          widget.isContact ? "Edit Contact Info" : "Edit Personal Info",
          style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: kTextPrimary(context)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text("Save", style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: kAccent(context))),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          child: widget.isContact ? _buildContactForm() : _buildPersonalForm(),
        ),
      ),
    );
  }

  Widget _buildPersonalForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHeader("Personal Information"),
      _field("Full Name", _nameCtrl),
      _field("Professional Title", _titleCtrl),
      _field("Tagline", _taglineCtrl, hint: "Your short bio headline"),
      _field("Location", _locationCtrl),
      _field("About Me", _aboutCtrl, maxLines: 5, hint: "Tell your story..."),
    ]);
  }

  Widget _buildContactForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHeader("Contact Information"),
      _field("Email", _emailCtrl, type: TextInputType.emailAddress),
      _field("Phone", _phoneCtrl, type: TextInputType.phone, validator: (_) => null),
      _field("Website", _websiteCtrl, hint: "https://...", validator: (_) => null),
      _field("GitHub URL", _githubCtrl, hint: "https://github.com/...", validator: (_) => null),
      _field("LinkedIn URL", _linkedinCtrl, hint: "https://linkedin.com/in/...", validator: (_) => null),
      _field("Twitter URL", _twitterCtrl, hint: "https://twitter.com/...", validator: (_) => null),
    ]);
  }
}
