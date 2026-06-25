// ─── Portfolio Data Models ────────────────────────────────────────────────

class PortfolioData {
  static const String name = "Alex Morgan";
  static const String title = "Full-Stack Developer & UI Designer";
  static const String tagline = "Crafting digital experiences that matter.";
  static const String about =
      "I'm a passionate developer with 5+ years of experience building "
      "scalable web and mobile applications. I love solving complex problems "
      "with clean, elegant code and designing interfaces that feel effortless.";

  static const String email = "alex.morgan@email.com";
  static const String phone = "+1 (555) 234-5678";
  static const String location = "San Francisco, CA";
  static const String website = "https://alexmorgan.dev";
  static const String github = "https://github.com/alexmorgan";
  static const String linkedin = "https://linkedin.com/in/alexmorgan";
  static const String twitter = "https://twitter.com/alexmorgan_dev";

  static const List<Skill> skills = [
    Skill("Flutter", 92, SkillCategory.mobile),
    Skill("Dart", 90, SkillCategory.mobile),
    Skill("React", 88, SkillCategory.frontend),
    Skill("TypeScript", 85, SkillCategory.frontend),
    Skill("Node.js", 82, SkillCategory.backend),
    Skill("Python", 78, SkillCategory.backend),
    Skill("Firebase", 80, SkillCategory.backend),
    Skill("Figma", 75, SkillCategory.design),
    Skill("PostgreSQL", 72, SkillCategory.backend),
    Skill("Docker", 68, SkillCategory.backend),
  ];

  static const List<Experience> experiences = [
    Experience(
      role: "Senior Mobile Developer",
      company: "TechNova Inc.",
      period: "2022 – Present",
      description: "Lead development of cross-platform mobile apps using Flutter, "
          "serving 500K+ users. Architected state management solutions and "
          "mentored a team of 4 junior developers.",
      tech: ["Flutter", "Dart", "Firebase", "REST APIs"],
    ),
    Experience(
      role: "Full-Stack Engineer",
      company: "Pixel Labs",
      period: "2020 – 2022",
      description: "Built and shipped 8 client products from concept to launch. "
          "Developed React frontends and Node.js backends with PostgreSQL databases.",
      tech: ["React", "Node.js", "PostgreSQL", "AWS"],
    ),
    Experience(
      role: "Frontend Developer",
      company: "Creative Studio Co.",
      period: "2019 – 2020",
      description: "Crafted interactive UI components and design systems for "
          "e-commerce clients, improving conversion rates by 23%.",
      tech: ["React", "TypeScript", "CSS", "Figma"],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: "Budgify — Finance Tracker",
      description: "A personal finance app helping users track spending, set budgets, "
          "and visualize money habits. Features real-time bank sync, smart "
          "categorization, and monthly reports.",
      tech: ["Flutter", "Firebase", "Plaid API", "Riverpod"],
      category: "Mobile App",
      liveUrl: "https://budgify.app",
      repoUrl: "https://github.com/alexmorgan/budgify",
      isFeatured: true,
      stats: "12K users · 4.8★",
    ),
    Project(
      title: "Kanvas — Design Collaboration",
      description: "Real-time collaborative design tool with vector editing, "
          "component libraries, and one-click export to Flutter/CSS. "
          "Think Figma, built for solo makers.",
      tech: ["React", "WebSockets", "Node.js", "Canvas API"],
      category: "Web App",
      liveUrl: "https://kanvas.design",
      repoUrl: "https://github.com/alexmorgan/kanvas",
      isFeatured: true,
      stats: "3.2K stars · Open Source",
    ),
    Project(
      title: "Pulse — Health Dashboard",
      description: "Wearable data aggregator that connects Apple Health, Garmin, "
          "and Fitbit into one clean dashboard. Includes AI-powered "
          "weekly summaries and trend analysis.",
      tech: ["Flutter", "Python", "FastAPI", "ML Kit"],
      category: "Mobile App",
      liveUrl: "",
      repoUrl: "https://github.com/alexmorgan/pulse",
      isFeatured: false,
      stats: "In Beta",
    ),
    Project(
      title: "Threadz — Community Forum",
      description: "Modern forum platform with topic threading, reputation system, "
          "and markdown support. Built for developer communities with "
          "sub-communities and moderation tools.",
      tech: ["Next.js", "PostgreSQL", "Prisma", "Vercel"],
      category: "Web App",
      liveUrl: "https://threadz.community",
      repoUrl: "https://github.com/alexmorgan/threadz",
      isFeatured: false,
      stats: "8K monthly visits",
    ),
    Project(
      title: "WeatherNow — Minimal Weather",
      description: "Beautifully minimal weather app with hourly forecasts, "
          "precipitation maps, and home screen widgets. Designed for "
          "clarity — no clutter, just weather.",
      tech: ["Flutter", "OpenWeather API", "Geolocator"],
      category: "Mobile App",
      liveUrl: "",
      repoUrl: "https://github.com/alexmorgan/weathernow",
      isFeatured: false,
      stats: "2K downloads",
    ),
    Project(
      title: "CLI Toolkit — Dev Utilities",
      description: "A collection of productivity CLI tools for developers: "
          "project scaffolding, git workflow helpers, env manager, "
          "and custom script runner.",
      tech: ["Python", "Click", "Rich", "PyPI"],
      category: "Open Source",
      liveUrl: "https://pypi.org/project/cli-toolkit",
      repoUrl: "https://github.com/alexmorgan/cli-toolkit",
      isFeatured: false,
      stats: "1.4K downloads/month",
    ),
  ];
}

// ─── Skill ───────────────────────────────────────────────────────────────────

enum SkillCategory { mobile, frontend, backend, design }

class Skill {
  final String name;
  final int level; // 0-100
  final SkillCategory category;
  const Skill(this.name, this.level, this.category);
}

// ─── Experience ───────────────────────────────────────────────────────────────

class Experience {
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> tech;
  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.tech,
  });
}

// ─── Project ──────────────────────────────────────────────────────────────────

class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String category;
  final String liveUrl;
  final String repoUrl;
  final bool isFeatured;
  final String stats;
  const Project({
    required this.title,
    required this.description,
    required this.tech,
    required this.category,
    required this.liveUrl,
    required this.repoUrl,
    required this.isFeatured,
    required this.stats,
  });
}
