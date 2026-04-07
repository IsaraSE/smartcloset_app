<div align="center">

# N O I R
**The Future of Premium Digital Retail**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&style=flat-square)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&style=flat-square)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Feature--Based-black?style=flat-square)](#)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](#)

[🌐 Live Showcase](https://noir-premium-store.web.app) • [📱 Physical Device Recommended](#-hardware-integration)

</div>

---

## 🌟 Overview

**NOIR** is a high-end, editorial-grade mobile commerce application designed to redefine the luxury fashion experience. Far beyond a traditional storefront, NOIR bridges the gap between physical and digital reality through advanced AR try-ons, decentralized state management, and an omnichannel retail engine.

Built for the discerning shopper, the application employs a **Champagne Gold & Deep Black** aesthetic, powered by a robust **Feature-Based Architecture** to ensure institutional-grade scalability and performance.

## ✨ Core Pillars

### 📸 Virtual AR Try-On
Leveraging high-frequency camera processing, NOIR allows users to virtually wear catalog items in real-time. Full spatial manipulation (scale, rotate, translate) enables a true-to-life assessment of fit and style before purchase.

### 🏷️ Omnichannel QR Engine
Designed for the modern retail floor, the integrated QR scanner instantly decodes physical storefront markers to bridge into the digital ecosystem—pulling live stock data, community reviews, and size availability directly to the user's hand.

### 🇱🇰 Deep LKR Localization
Fully standardized for the Sri Lankan market, NOIR features comprehensive **LKR (Sri Lankan Rupee)** regional support. All pricing, subtotals, and transaction logic are calculated and formatted with local precision.

### 💎 Editorial Design System
Experience a UI that breathes. Utilizing **Cormorant Garamond** for luxury headings and **DM Sans** for professional-grade readability, NOIR features immersive parallax effects, frosted glass components, and refined micro-animations.

---

## 🏗 Technical Architecture

NOIR is engineered for modularity and long-term maintainability using a **Feature-Based Architecture**.

```text
lib/
├── core/         # Critical infrastructure (Theme, Constants, Utils)
├── data/         # Data layer (Models, DTOs, Repositories)
├── providers/    # Global state management (Riverpod)
├── router/       # Centralized routing engine (GoRouter)
└── ui/
    ├── features/ # Domain-specific modules (Auth, Cart, Product, Scanning)
    ├── widgets/  # Reusable atomic UI components
    └── base/     # Shared layout shells (Navigation, Scaffolds)
```

### Stack
- **Framework:** Flutter (Material 3)
- **State:** `flutter_riverpod` (Reactive State)
- **Routing:** `go_router` (Declarative Navigation)
- **Design:** `flutter_animate` (Motion System)
- **Hardware:** `camera` (AR Logic) & `mobile_scanner` (QR Engine)

---

## 🚀 Getting Started

### Prerequisites
Ensure your local environment is configured with the Flutter SDK (Stable):
```bash
flutter doctor
```

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/IsaraSE/smartcloset_app.git
   cd smartcloset_app
   ```
2. **Synchronize dependencies:**
   ```bash
   flutter pub get
   ```
3. **Hardware Deployment:**
   To experience the AR and Scan features, deploy to a physical device:
   ```bash
   flutter run
   ```

---

## 🔐 Hardware Integration

NOIR requires native permissions for full functionality. Ensure the following configurations are preserved:

- **iOS:** `ios/Runner/Info.plist` (NSCameraUsageDescription)
- **Android:** `AndroidManifest.xml` (android.permission.CAMERA)

---

## 🌐 Deployment Details

The official NOIR production build is hosted on **Firebase Hosting**.

| Environment | Endpoint | Provider |
|---|---|---|
| **Production** | [https://noir-premium-store.web.app](https://noir-premium-store.web.app) | Google Firebase |
| **Branch** | `main` | GitHub |

---

<div align="center">
  <p>Engineered with Precision · Built for Reality</p>
</div>
