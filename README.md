<div align="center">
  
# N O I R

**A Premium E-Commerce & Virtual Try-On Fashion Experience**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![iOS](https://img.shields.io/badge/Platform-iOS-black?logo=apple)](#)
[![Android](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](#)
[![Live Demo](https://img.shields.io/badge/Live%20Demo-Firebase-orange?logo=firebase)](https://noir-premium-store.web.app)

### 🌐 [View Live Demo → noir-premium-store.web.app](https://noir-premium-store.web.app)

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
- **🇱🇰 Localized for LKR:** Seamless currency standardization across the entire application, featuring locally formatted Sri Lankan Rupee (LKR) pricing for a tailored regional experience.
- **👤 Enhanced Profile Experience:** A professional-grade account management suite including dedicated modules for Addresses, Promo Codes, Notifications, and Help & Support.
- **⚡ Reactive Performance:** Powered entirely by `Riverpod` for lightning-fast state management without prop-drilling, and `go_router` for deep linking and safe navigation transitions.

## 🏆 Core App Functions & Workflows

**1. Virtual AR Clothing Try-On**
The hallmark feature of NOIR. Using the `camera` package, users can select any piece of clothing from the catalog and project it onto a live camera feed. This allows users to hold up their phone, point the camera at themselves in a mirror (or another person), and see exactly how the clothing maps to their body. Gestures like drag, pinch-to-zoom, and rotation give the user full spatial control over the virtual garment.

**2. Physical-to-Digital QR Rack Scanning**
Bridging the gap between the physical retail store and the digital app. Users can tap the QR icon to launch the live scanner (powered by `mobile_scanner`). By pointing the camera at a QR code located on a physical clothing rack in a NOIR retail store, the app instantly parses the ID and loads the digital product details, allowing the user to read details and add it directly to their virtual cart.

**3. State-of-the-Art E-Commerce Pipeline**
From discovery to checkout, NOIR provides a frictionless shopping loop. The app features a highly curated feed of clothing, shoes, and accessories. Once an item is added to the cart, the user proceeds to an integrated checkout experience that provides an itemized subtotal, and generates an interactive, timeline-based order receipt tracking the package from processing to delivery.

**4. Persistent Authentication & Profile Management**
Upon launching the application, users are greeted by a breathtaking, animation-driven Splash Screen that fades into an elegant login portal. The entire system uses Riverpod to track the auth state, saving sessions flawlessly across app relaunches. Once logged in, users gain access to a comprehensive profile dashboard allowing them to manage multiple shipping addresses, view active promo codes, and configure custom notifications.

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

## 🌐 Web Deployment

NOIR is live and hosted on **Firebase Hosting**. The web build is compiled from the Flutter source and deployed to a globally distributed CDN.

| Property | Value |
|---|---|
| **Live URL** | [https://noir-premium-store.web.app](https://noir-premium-store.web.app) |
| **Firebase Project** | `noir-premium-store` |
| **Hosting Provider** | Firebase Hosting (Google) |
| **Build Output** | `build/web/` |

### Re-deploying After Changes

Whenever you make changes to the app and want to push them live, run these two commands:

```bash
# Step 1: Rebuild the optimized web bundle
flutter build web

# Step 2: Push the new build to Firebase
npx firebase-tools deploy --only hosting
```

> **Note:** The AR Try-On camera and QR Scanner features require native mobile hardware and will have limited functionality in the web browser version. For the full experience, run the app on a physical iOS or Android device.

---

<div align="center">
  <p>Designed and Built with 🖤 for the Future of Retail</p>
</div>
