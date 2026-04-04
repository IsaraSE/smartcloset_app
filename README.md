# 👗 StyleSphere (SmartCloset App)

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Riverpod-0082FB?style=for-the-badge&logo=dart&logoColor=white" alt="Riverpod" />
</p>

StyleSphere is a premium, modern e-commerce application built with Flutter. Designed with a luxurious deep burgundy aesthetic, the app offers a seamless shopping experience for apparel and accessories, featuring advanced features like AR Virtual Try-On previews and QR-based clothing rack scanning.

## ✨ Features

- **💎 Premium UI/UX:** A rich, engaging design system utilizing a deep burgundy and rose gold palette with custom micro-animations and frosted glass (glassmorphism) effects.
- **🚀 Seamless Onboarding:** A luxurious 3-page full-screen onboarding flow with engaging background imagery and elegant typography.
- **🛍️ Comprehensive Shopping Experience:**
  - Browse categorized catalogs (Men, Women, Kids, Accessories)
  - Detailed product pages with image carousels, size selectors, color swatches, and reviews
  - Persistent shopping cart and wishlist functionality
- **📸 Virtual Try-On (AR Preview):** An interactive camera overlay simulating the placement of clothing items on a detected human body footprint.
- **🔍 Rack Scanner (In-Store Mode):** A simulated QR Code scanner allowing users to scan physical store racks to instantly view corresponding digital inventory.
- **🔒 Authentication Flow:** Beautifully designed mock login and registration screens.
- **🗂️ Reactive Architecture:** Powered by `flutter_riverpod` for rock-solid reactive state management and `go_router` for structured declarative routing.

## 🛠️ Tech Stack & Dependencies

The project relies on industry-standard Flutter packages for performance and maintainability:

- **State Management:** `flutter_riverpod` (AsyncNotifier, StateProvider)
- **Routing:** `go_router` (ShellRoute for bottom navigation)
- **UI & Animations:** 
  - `flutter_animate` (Chained declarative animations)
  - `smooth_page_indicator` (Onboarding and image carousels)
  - `google_fonts` (Playfair Display & Poppins font families)
  - `shimmer` (Loading skeleton effects)
- **Image Handling:** `cached_network_image` (Robust remote image caching)

## 🎨 Design System

The application utilizes a custom color palette (`class C`) designed for a high-end fashion aesthetic:

- **Primary:** Deep Wine (`#2D0A16`)
- **Secondary:** Rich Rose (`#C8415B`)
- **Accent:** Soft Blush (`#F5E6EA`)
- **Typography:** `Playfair Display` (Headings/Display) & `Poppins` (Body/UI)

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.19.0 or higher recommended)
- Dart SDK
- An iOS Simulator, Android Emulator, or connected physical device

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/smartcloset_app.git
   cd smartcloset_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

## 📁 Project Structure

Currently, the application logic is unified for rapid prototyping and demonstration. Key architectural segments within the codebase include:

- **Theme & Tokens:** Color constants, gradients, and `ThemeData`.
- **Models:** Data structures for `Product`, `Category`, `User`, `Order`, etc.
- **Mock Data:** Extensive seeded catalogs utilizing high-quality Unsplash assets.
- **Providers (Riverpod):** Logic for Auth, Cart, Wishlist, and Onboarding state tracking.
- **Router (GoRouter):** Centralized navigation with redirect guards (Auth/Onboarding barriers).
- **Screens:** Modular UI classes (Home, Detail, Scanner, Try-On, etc.).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! 
Feel free to check the [issues page](https://github.com/yourusername/smartcloset_app/issues).

---
*Developed for the SmartCloset / StyleSphere initiative.*
