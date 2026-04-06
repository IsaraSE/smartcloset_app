<div align="center">
  
# N O I R

**A Premium E-Commerce & Virtual Try-On Fashion Experience**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![iOS](https://img.shields.io/badge/Platform-iOS-black?logo=apple)](#)
[![Android](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](#)

</div>

---

## 🌟 Overview

**NOIR** is a world-class, ultra-premium mobile application designed for luxury fashion retail. Blending high-end editorial aesthetics with cutting-edge mobile hardware capabilities, NOIR offers a seamless transition between the digital storefront and physical reality.

The app completely rethinks the mobile shopping experience, moving away from generic tech-blue designs into a sophisticated monochrome palette (Deep Black, Pure White, and Champagne Gold) backed by elegant typography seamlessly managed by Riverpod.

## ✨ Key Features

- **📸 Live AR Virtual Try-On:** Utilizing advanced mobile camera integration, users can overlay and manipulate clothing in real-time over live camera feeds using intuitive pinch, scale, and rotate gestures.
- **🏷️ Smart QR Rack Scanner:** Built for omnichannel retail, the live hardware scanner allows users to scan physical clothing racks in-store and instantly pull up their digital counterparts, complete with reviews, sizing, and stock.
- **💎 Editorial UX/UI:** Breathtaking `Cormorant Garamond` headings paired with ultra-clean `DM Sans` typography, sleek frosted glass layouts, immersive parallax imagery, and custom animation controllers.
- **🛍️ Complete E-Commerce Flow:** Fully mocked out end-to-end shopping experience featuring 28 curated luxury products, cart state management, checkout routing, and timeline-based order tracking.
- **⚡ Reactive Performance:** Powered entirely by `Riverpod` for lightning-fast state management without prop-drilling, and `go_router` for deep linking and safe navigation transitions.

## 📱 Screenshots

> **Note to Developer:** *Drop your app screenshots into an `assets/visuals/` folder and link them here to complete the professional look.*

<div align="center">
  <img src="https://via.placeholder.com/250x500.png?text=Splash+Screen" width="200" style="margin-right: 15px;"/>
  <img src="https://via.placeholder.com/250x500.png?text=Home+Feed" width="200" style="margin-right: 15px;"/>
  <img src="https://via.placeholder.com/250x500.png?text=Live+AR+Camera" width="200" style="margin-right: 15px;"/>
  <img src="https://via.placeholder.com/250x500.png?text=QR+Scanner" width="200"/>
</div>

---

## 🛠 Tech Stack

*   **Framework:** Flutter
*   **State Management:** `flutter_riverpod`
*   **Routing:** `go_router`
*   **Hardware/Sensors:** `camera` (AR feed), `mobile_scanner` (QR engine)
*   **Animations:** `flutter_animate`, `smooth_page_indicator`
*   **UI Helpers:** `google_fonts`, `cached_network_image`, `shimmer`

## 🚀 Getting Started

Follow these instructions to get the NOIR project up and running on your local machine.

### Prerequisites
Make sure you have [Flutter](https://docs.flutter.dev/get-started/install) installed and running on your machine.
```bash
flutter doctor
```

### Installation

1. **Clone the repository** (if you haven't already):
   ```bash
   git clone https://github.com/yourusername/noir-app.git
   cd noir-app
   ```

2. **Install Flutter Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Install iOS Pods (macOS only):**
   ```bash
   cd ios
   pod install
   cd ..
   ```

### Running the App

Because **NOIR** utilizes deep native hardware integration (Camera and Microphones for the AR and QR logic), **it is highly recommended to test on a physical device** rather than a simulator. 

*To build and run:*
```bash
flutter run
```

---

## 🔐 Hardware Permissions

If you are modifying the camera logic, ensure your native permission files are kept updated:
- **iOS:** `ios/Runner/Info.plist` utilizes `NSCameraUsageDescription` and `NSMicrophoneUsageDescription`.
- **Android:** Ensure `android/app/src/main/AndroidManifest.xml` contains `<uses-permission android:name="android.permission.CAMERA" />`.

---

<div align="center">
  <p>Designed and Built with 🖤 for the Future of Retail</p>
</div>
