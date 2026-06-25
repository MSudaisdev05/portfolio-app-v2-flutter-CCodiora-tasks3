import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  // Personal Info
  String name = "Muhammad Sudais";
  String title = "Flutter & AI Developer";
  String tagline = "Building apps that matter.";
  String about =
      "I am a Computer Science student passionate about software development, web technologies, and artificial intelligence. "
      "I enjoy building practical projects, learning new technologies, and solving realworld problems through programming. "
      "My goal is to continuously improve my technical skills and contribute to innovative solutions that create a positive impact."
      " I am always eager to learn, collaborate, and grow as a future software engineer.";

  // Contact Info
  String email = "msudais.dev05@email.com";
  String phone = "03185425200";
  String location = "Nowshera,kpk,Pakistan";
  String website = "https://alexmorgan.dev";
  String github = "https://github.com/MSudaisdev05";
  String linkedin = "https://www.linkedin.com/in/muhammad-sudais-5b2423384/";
  String twitter = "https://x.com/MsudaisDev05";

  ProfileProvider() {
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    name = p.getString('profile_name') ?? name;
    title = p.getString('profile_title') ?? title;
    tagline = p.getString('profile_tagline') ?? tagline;
    about = p.getString('profile_about') ?? about;
    email = p.getString('profile_email') ?? email;
    phone = p.getString('profile_phone') ?? phone;
    location = p.getString('profile_location') ?? location;
    website = p.getString('profile_website') ?? website;
    github = p.getString('profile_github') ?? github;
    linkedin = p.getString('profile_linkedin') ?? linkedin;
    twitter = p.getString('profile_twitter') ?? twitter;
    notifyListeners();
  }

  Future<void> savePersonal({
    required String newName,
    required String newTitle,
    required String newTagline,
    required String newAbout,
    required String newLocation,
  }) async {
    name = newName;
    title = newTitle;
    tagline = newTagline;
    about = newAbout;
    location = newLocation;
    final p = await SharedPreferences.getInstance();
    await p.setString('profile_name', name);
    await p.setString('profile_title', title);
    await p.setString('profile_tagline', tagline);
    await p.setString('profile_about', about);
    await p.setString('profile_location', location);
    notifyListeners();
  }

  Future<void> saveContact({
    required String newEmail,
    required String newPhone,
    required String newWebsite,
    required String newGithub,
    required String newLinkedin,
    required String newTwitter,
  }) async {
    email = newEmail;
    phone = newPhone;
    website = newWebsite;
    github = newGithub;
    linkedin = newLinkedin;
    twitter = newTwitter;
    final p = await SharedPreferences.getInstance();
    await p.setString('profile_email', email);
    await p.setString('profile_phone', phone);
    await p.setString('profile_website', website);
    await p.setString('profile_github', github);
    await p.setString('profile_linkedin', linkedin);
    await p.setString('profile_twitter', twitter);
    notifyListeners();
  }
}
