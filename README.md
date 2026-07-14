# Kids Learning Adventure 🦁✨

An enterprise-grade, commercial-quality Flutter Kids Learning Platform designed meticulously for toddlers and young learners (Ages 3-7). Featuring highly interactive spelling gameplay, immersive cartoon environments, deep analytical parenting gates, custom sound engines, and multi-world structures.

---

## 📂 Architecture & Directory Structure
This platform conforms to **Clean Architecture** with a feature-first approach:

```text
lib/
 core/
   ├── config/        # App version flags & COPPA/Family policies
   ├── constants/     # Core game rewards & styling limits
   ├── theme/         # Cartoon-style rounded material theme
   ├── services/      # Child-safe ads hooks & holiday services
   ├── storage/       # Local database & profile progress engine
   └── routes/        # Beautiful scale-based custom route transition engine
 features/
    ├── onboarding/    # Interactive name, age, and avatar setups
    ├── achievements/  # Medals dashboard & streak tracking
    ├── game/          # Dynamic spelling loops, scoring, & hints
    └── parent/        # Gatekeeper dashboards with math locks

