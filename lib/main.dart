// ============================================================
//  NOIR — Premium Fashion App
//  Refactored: Performance · Design · UX
//  Brand: NOIR | Palette: Black / White / Champagne Gold
// ============================================================

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:camera/camera.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ╔══════════════════════════════════════════════════════════╗
// ║  1 · ENTRY POINT                                        ║
// ╚══════════════════════════════════════════════════════════╝

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
  ));
  runApp(const ProviderScope(child: NoirApp()));
}

// ╔══════════════════════════════════════════════════════════╗
// ║  2 · DESIGN SYSTEM — Colors, Typography, Theme          ║
// ║  NOIR Palette: Deep Black · Pure White · Champagne Gold ║
// ╚══════════════════════════════════════════════════════════╝

class C {
  C._();
  // ── Core ──────────────────────────────────────────────────
  static const ink        = Color(0xFF0A0A0A);   // Near-black text & primary
  static const canvas     = Color(0xFFFAFAFA);   // App background
  static const white      = Color(0xFFFFFFFF);
  static const black      = Color(0xFF000000);
  // ── Brand Gold ────────────────────────────────────────────
  static const gold       = Color(0xFFC4A265);   // Champagne gold — main accent
  static const goldLight  = Color(0xFFF5EDD8);   // Gold tint for backgrounds
  static const goldDark   = Color(0xFF8B6F3E);   // Deep gold for pressed states
  // ── Neutrals ──────────────────────────────────────────────
  static const n50        = Color(0xFFFAFAFA);
  static const n100       = Color(0xFFF5F5F5);
  static const n200       = Color(0xFFE8E8E8);
  static const n300       = Color(0xFFD4D4D4);
  static const n400       = Color(0xFFA3A3A3);
  static const n500       = Color(0xFF737373);
  static const n600       = Color(0xFF525252);
  static const n700       = Color(0xFF404040);
  static const n800       = Color(0xFF262626);
  static const n900       = Color(0xFF171717);
  // ── Semantic ──────────────────────────────────────────────
  static const success    = Color(0xFF22C55E);
  static const error      = Color(0xFFEF4444);
  static const warning    = Color(0xFFF59E0B);
  // ── Utility ───────────────────────────────────────────────
  static const surface    = Color(0xFFFFFFFF);
  static const border     = Color(0xFFE8E8E8);
  static const shadow     = Color(0x08000000);
  static const shadowMd   = Color(0x12000000);

  // ── Gradients ─────────────────────────────────────────────
  static const LinearGradient inkGrad = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
  );
  static const LinearGradient goldGrad = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFFD4A96A), Color(0xFFC4A265), Color(0xFF8B6F3E)],
  );
  static const LinearGradient heroGrad = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xE0000000)],
    stops: [0.3, 1.0],
  );
}

ThemeData buildTheme() {
  // Cormorant Garamond for display — editorial, luxury feel
  // DM Sans for body — clean, modern, readable
  TextStyle dm(double sz, FontWeight w, Color col, {double ls = 0, double? h}) =>
      GoogleFonts.dmSans(fontSize: sz, fontWeight: w, color: col, letterSpacing: ls, height: h);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: C.ink,
      primary: C.ink,
      secondary: C.gold,
      surface: C.white,
      error: C.error,
      onPrimary: C.white,
      onSecondary: C.ink,
      onSurface: C.ink,
    ),
    scaffoldBackgroundColor: C.canvas,
    textTheme: TextTheme(
      displayLarge:   GoogleFonts.cormorantGaramond(fontSize: 36, fontWeight: FontWeight.w700, color: C.ink, height: 1.1, letterSpacing: -0.5),
      displayMedium:  GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w700, color: C.ink, height: 1.15),
      displaySmall:   GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600, color: C.ink),
      headlineLarge:  dm(20, FontWeight.w700, C.ink),
      headlineMedium: dm(18, FontWeight.w600, C.ink),
      headlineSmall:  dm(16, FontWeight.w600, C.ink),
      titleLarge:     dm(16, FontWeight.w600, C.ink),
      titleMedium:    dm(14, FontWeight.w500, C.ink),
      titleSmall:     dm(12, FontWeight.w500, C.n700),
      bodyLarge:      dm(16, FontWeight.w400, C.n800, h: 1.6),
      bodyMedium:     dm(14, FontWeight.w400, C.n700, h: 1.55),
      bodySmall:      dm(12, FontWeight.w400, C.n500),
      labelLarge:     dm(14, FontWeight.w600, C.white, ls: 0.5),
      labelMedium:    dm(12, FontWeight.w500, C.n600),
      labelSmall:     dm(10, FontWeight.w500, C.n500, ls: 0.5),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: C.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: C.ink, size: 22),
      titleTextStyle: GoogleFonts.dmSans(
        fontSize: 17, fontWeight: FontWeight.w700, color: C.ink),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: C.ink, foregroundColor: C.white,
        elevation: 0, disabledBackgroundColor: C.n200,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: C.ink,
        side: const BorderSide(color: C.ink, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: C.n100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: C.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: C.ink, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: C.error)),
      hintStyle: GoogleFonts.dmSans(fontSize: 14, color: C.n400),
      labelStyle: GoogleFonts.dmSans(fontSize: 14, color: C.n500),
    ),
    cardTheme: CardThemeData(
      color: C.white, elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      margin: EdgeInsets.zero,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: C.ink,
      contentTextStyle: GoogleFonts.dmSans(color: C.white, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      behavior: SnackBarBehavior.floating,
    ),
    dividerTheme: const DividerThemeData(color: C.border, thickness: 1, space: 1),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? C.ink : C.n200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: C.gold),
    sliderTheme: const SliderThemeData(
      activeTrackColor: C.ink, thumbColor: C.ink, inactiveTrackColor: C.n200),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  3 · MODELS                                             ║
// ╚══════════════════════════════════════════════════════════╝

class Product {
  final String id, name, brand, description, category, subCategory;
  final double price;
  final double? originalPrice;
  final List<String> images, sizes, colors;
  final double rating;
  final int reviewCount, soldCount;
  final bool isNew, isFeatured, isInStock;
  final String? rackId, rackName;
  final Map<String, String> details;

  const Product({
    required this.id, required this.name, required this.brand,
    required this.description, required this.category, required this.subCategory,
    required this.price, this.originalPrice,
    required this.images, required this.sizes, required this.colors,
    required this.rating, required this.reviewCount, this.soldCount = 0,
    this.isNew = false, this.isFeatured = false, this.isInStock = true,
    this.rackId, this.rackName, this.details = const {},
  });

  double get discount => (originalPrice != null && originalPrice! > price)
      ? ((originalPrice! - price) / originalPrice! * 100).roundToDouble() : 0;
  bool get hasDiscount => discount > 0;
}

class CartItem {
  final String id, selectedSize, selectedColor;
  final Product product;
  final int quantity;

  const CartItem({
    required this.id, required this.product, required this.quantity,
    required this.selectedSize, required this.selectedColor,
  });

  double get total => product.price * quantity;

  CartItem copyWith({int? quantity}) => CartItem(
    id: id, product: product,
    selectedSize: selectedSize, selectedColor: selectedColor,
    quantity: quantity ?? this.quantity,
  );
}

class Address {
  final String id, name, phone, line1, city, state, zip, country;
  final String? line2;
  final bool isDefault;

  const Address({
    required this.id, required this.name, required this.phone,
    required this.line1, this.line2, required this.city,
    required this.state, required this.zip, required this.country,
    this.isDefault = false,
  });

  String get full => '$line1${line2 != null ? ', $line2' : ''}, $city, $state $zip, $country';
  String get short => '$line1, $city';
}

class AppUser {
  final String id, name, email;
  final String? photoUrl;
  final List<Address> addresses;

  const AppUser({
    required this.id, required this.name, required this.email,
    this.photoUrl, this.addresses = const [],
  });

  Address? get defaultAddress =>
      addresses.where((a) => a.isDefault).firstOrNull ?? addresses.firstOrNull;
}

enum OrderStatus { placed, processing, shipped, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get label => const {
    OrderStatus.placed: 'Order Placed',
    OrderStatus.processing: 'Processing',
    OrderStatus.shipped: 'Shipped',
    OrderStatus.delivered: 'Delivered',
    OrderStatus.cancelled: 'Cancelled',
  }[this]!;

  int get step => const {
    OrderStatus.placed: 0, OrderStatus.processing: 1,
    OrderStatus.shipped: 2, OrderStatus.delivered: 3,
    OrderStatus.cancelled: -1,
  }[this]!;

  Color get color => this == OrderStatus.delivered ? C.success
      : this == OrderStatus.cancelled ? C.error : C.ink;
}

class AppOrder {
  final String id, orderNumber, paymentMethod;
  final List<CartItem> items;
  final double subtotal, shipping, total, discount;
  final Address address;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;

  const AppOrder({
    required this.id, required this.orderNumber, required this.items,
    required this.subtotal, required this.shipping, required this.total,
    required this.address, required this.paymentMethod, required this.status,
    required this.createdAt, this.estimatedDelivery, this.discount = 0,
  });

  int get itemCount => items.fold(0, (s, i) => s + i.quantity);
}

class BannerData {
  final String id, imageUrl, title, subtitle, actionLabel, route, tag;
  const BannerData({
    required this.id, required this.imageUrl, required this.title,
    required this.subtitle, required this.actionLabel, required this.route,
    this.tag = '',
  });
}

class CategoryData {
  final String id, name, emoji, imageUrl;
  const CategoryData({
    required this.id, required this.name,
    required this.emoji, required this.imageUrl,
  });
}

// ╔══════════════════════════════════════════════════════════╗
// ║  4 · MOCK DATA — 28 Products, Curated Images            ║
// ╚══════════════════════════════════════════════════════════╝

final kProducts = <Product>[
  // ── Men's Formal ──────────────────────────────────────────
  Product(
    id: 'p01', name: 'Slim Oxford Shirt', brand: 'Ralph Lauren',
    description: 'A timeless oxford shirt in premium 100% cotton. Button-down collar, slim fit, subtle texture. Pairs perfectly with chinos or tailored trousers for a smart-casual look.',
    price: 79.99, originalPrice: 120.00, category: 'Men', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=700&q=85',
      'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=700&q=85',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['White','Light Blue','Navy'],
    rating: 4.7, reviewCount: 324, soldCount: 890, isFeatured: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal",
    details: {'Material':'100% Cotton','Fit':'Slim Fit','Care':'Machine Wash','Origin':'Portugal'},
  ),
  Product(
    id: 'p02', name: 'Wool Blazer', brand: 'Tommy Hilfiger',
    description: 'Sophisticated wool-blend blazer with single-button closure, notch lapels, and structured shoulders for a sharp professional appearance.',
    price: 249.99, originalPrice: 380.00, category: 'Men', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=700&q=85',
      'https://images.unsplash.com/photo-1593030761757-71fae45fa0e7?w=700&q=85',
    ],
    sizes: ['S','M','L','XL'], colors: ['Charcoal','Navy','Black'],
    rating: 4.9, reviewCount: 187, soldCount: 420, isFeatured: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal",
    details: {'Material':'70% Wool, 30% Poly','Fit':'Slim Fit','Care':'Dry Clean Only','Lining':'Full'},
  ),
  Product(
    id: 'p03', name: 'Tailored Dress Trousers', brand: 'Dior',
    description: 'Impeccably cut dress trousers in a premium wool-stretch blend. Flat front, slim silhouette. The backbone of any formal wardrobe.',
    price: 139.99, originalPrice: 195.00, category: 'Men', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=700&q=85',
      'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=700&q=85',
    ],
    sizes: ['28','30','32','34','36'], colors: ['Black','Charcoal','Navy'],
    rating: 4.6, reviewCount: 211, soldCount: 580, isNew: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal",
    details: {'Material':'95% Wool, 5% Elastane','Fit':'Slim','Rise':'Mid','Care':'Dry Clean'},
  ),
  // ── Men's Casual ──────────────────────────────────────────
  Product(
    id: 'p04', name: 'Slim Chino', brand: 'Polo Ralph Lauren',
    description: 'Versatile chino in lightweight cotton-stretch. Moves with you through the workday and beyond. Available in classic seasonal colors.',
    price: 89.99, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=700&q=85',
      'https://images.unsplash.com/photo-1542272604-787c3835535d?w=700&q=85',
    ],
    sizes: ['28','30','32','34','36'], colors: ['Khaki','Navy','Olive','Stone'],
    rating: 4.5, reviewCount: 458, soldCount: 1200, isNew: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'97% Cotton, 3% Elastane','Fit':'Slim','Rise':'Mid','Care':'Machine Wash'},
  ),
  Product(
    id: 'p05', name: 'Cable Knit Sweater', brand: 'Gucci',
    description: 'Timeless cable-knit sweater in 100% merino wool. Dropped shoulders, ribbed cuffs and hem deliver an elevated cold-weather layer you will reach for season after season.',
    price: 119.99, originalPrice: 165.00, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=700&q=85',
      'https://images.unsplash.com/photo-1611312449408-fcece27cdbb7?w=700&q=85',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['Cream','Charcoal','Navy','Brown'],
    rating: 4.8, reviewCount: 312, soldCount: 740, isFeatured: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'100% Merino Wool','Fit':'Relaxed','Pattern':'Cable Knit','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p06', name: 'Classic Cardigan', brand: 'Ralph Lauren',
    description: 'An enduring wardrobe staple. Ribbed collar and cuffs, button front closure. Crafted from a soft wool blend for all-day comfort.',
    price: 99.99, originalPrice: 140.00, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=700&q=85',
      'https://images.unsplash.com/photo-1611312449408-fcece27cdbb7?w=700&q=85',
    ],
    sizes: ['S','M','L','XL'], colors: ['Brown','Black','Navy'],
    rating: 4.5, reviewCount: 178, soldCount: 510, isFeatured: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'Wool Blend','Buttons':'Horn','Collar':'Ribbed','Care':'Dry Clean Preferred'},
  ),
  Product(
    id: 'p07', name: 'Linen Overshirt', brand: 'Tommy Hilfiger',
    description: 'Relaxed linen overshirt — wear it open over a tee or buttoned as a light layer. Stone-washed for a naturally worn-in feel.',
    price: 74.99, originalPrice: 98.00, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=700&q=85',
      'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=700&q=85',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['Stone','Sage','White'],
    rating: 4.4, reviewCount: 245, soldCount: 680, isNew: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'100% Linen','Fit':'Relaxed','Treatment':'Stone Washed','Care':'Machine Wash'},
  ),
  // ── Men's Streetwear ──────────────────────────────────────
  Product(
    id: 'p08', name: 'Oversized Hoodie', brand: 'Chanel',
    description: 'The definitive streetwear staple. Heavyweight 400gsm fleece, kangaroo pocket, ribbed cuffs. An oversized silhouette engineered for maximum comfort and effortless style.',
    price: 119.99, originalPrice: 160.00, category: 'Men', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=700&q=85',
      'https://images.unsplash.com/photo-1542338347-4fff3276af78?w=700&q=85',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['Black','Cream','Charcoal'],
    rating: 4.8, reviewCount: 792, soldCount: 2100, isNew: true, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'400gsm Fleece','Fit':'Oversized','Weight':'Heavyweight','Care':'Machine Wash Cold'},
  ),
  Product(
    id: 'p09', name: 'Cargo Tech Pants', brand: 'Versace',
    description: 'Technical cargo pants where function meets fashion. Multiple zip pockets, adjustable waistband, tapered leg silhouette. Water-resistant ripstop nylon.',
    price: 149.99, originalPrice: 200.00, category: 'Men', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1542272604-787c3835535d?w=700&q=85',
      'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=700&q=85',
    ],
    sizes: ['S','M','L','XL'], colors: ['Black','Khaki','Olive'],
    rating: 4.6, reviewCount: 234, soldCount: 560,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'Ripstop Nylon','Pockets':'6 Zip','Feature':'Water Resistant','Care':'Machine Wash'},
  ),
  // ── Women's Casual ────────────────────────────────────────
  Product(
    id: 'p10', name: 'Floral Midi Dress', brand: 'Gucci',
    description: 'Effortlessly feminine floral midi dress. V-neckline, flowing silhouette, adjustable tie waist. Crafted from lightweight viscose for all-day ease.',
    price: 129.99, originalPrice: 180.00, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=700&q=85',
      'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=700&q=85',
    ],
    sizes: ['XS','S','M','L','XL'], colors: ['Floral Blue','Floral Pink'],
    rating: 4.8, reviewCount: 567, soldCount: 1340, isNew: true, isFeatured: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'100% Viscose','Fit':'Relaxed','Length':'Midi','Care':'Hand Wash'},
  ),
  Product(
    id: 'p11', name: 'High-Waist Wide Leg Jeans', brand: 'Calvin Klein',
    description: 'A modern take on the wide-leg silhouette. Premium stretch denim, high-rise waist that flatters every body type. Finished with subtle hardware.',
    price: 109.99, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=700&q=85',
      'https://images.unsplash.com/photo-1475178626620-a4d074967452?w=700&q=85',
    ],
    sizes: ['24','25','26','27','28','30'], colors: ['Light Wash','Dark Wash','Black'],
    rating: 4.7, reviewCount: 883, soldCount: 2500,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'93% Cotton, 7% Elastane','Rise':'High','Fit':'Wide Leg','Care':'Machine Wash'},
  ),
  Product(
    id: 'p12', name: 'Oversized Knit Sweater', brand: 'Dior',
    description: 'A luxuriously cozy chunky-knit pullover in an 80/20 wool-cashmere blend. Dropped shoulders with refined ribbed trims. The ultimate statement in soft, seasonal dressing.',
    price: 109.99, originalPrice: 155.00, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=700&q=85',
      'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=700&q=85',
    ],
    sizes: ['XS','S','M','L','XL'], colors: ['Cream','Dusty Rose','Sage'],
    rating: 4.8, reviewCount: 523, soldCount: 1290, isNew: true, isFeatured: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'80% Wool, 20% Cashmere','Fit':'Oversized','Pattern':'Chunky Knit','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p13', name: 'Summer Linen Blouse', brand: 'Tommy Hilfiger',
    description: 'Breezy linen blouse with subtle pintuck detailing and a relaxed drape. Perfect over jeans or tucked into a midi skirt.',
    price: 64.99, originalPrice: 89.00, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=700&q=85',
      'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=700&q=85',
    ],
    sizes: ['XS','S','M','L'], colors: ['White','Ecru','Dusty Blue'],
    rating: 4.5, reviewCount: 302, soldCount: 870, isNew: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'100% Linen','Fit':'Relaxed','Detail':'Pintuck','Care':'Machine Wash Cold'},
  ),
  // ── Women's Formal ────────────────────────────────────────
  Product(
    id: 'p14', name: 'Tailored Blazer Dress', brand: 'Prada',
    description: 'A power-dressing icon. Italian crepe, peak lapels, a defined waist, and single-button closure. Commands attention in every room.',
    price: 219.99, originalPrice: 320.00, category: 'Women', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=700&q=85',
      'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=700&q=85',
    ],
    sizes: ['XS','S','M','L'], colors: ['Black','Ivory','Deep Red'],
    rating: 4.9, reviewCount: 189, soldCount: 380, isFeatured: true,
    rackId: 'rack_women_formal', rackName: "Women's Formal",
    details: {'Material':'Italian Crepe','Fit':'Tailored','Closure':'Single Button','Care':'Dry Clean'},
  ),
  Product(
    id: 'p15', name: 'Satin Slip Dress', brand: 'Gucci',
    description: 'Effortlessly chic bias-cut satin slip dress. Adjustable spaghetti straps, subtle sheen, fluid drape. A modern classic for evenings out.',
    price: 99.99, originalPrice: 150.00, category: 'Women', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=700&q=85',
      'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=700&q=85',
    ],
    sizes: ['XS','S','M','L'], colors: ['Champagne','Dusty Rose','Black'],
    rating: 4.7, reviewCount: 456, soldCount: 980,
    rackId: 'rack_women_formal', rackName: "Women's Formal",
    details: {'Material':'100% Satin','Fit':'Bias Cut','Straps':'Adjustable','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p16', name: 'Structured Midi Skirt', brand: 'Chanel',
    description: 'A polished pencil midi skirt with a back kick pleat for ease of movement. Crafted from a luxe ponte fabric that holds its shape beautifully.',
    price: 89.99, originalPrice: 130.00, category: 'Women', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=700&q=85',
      'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=700&q=85',
    ],
    sizes: ['XS','S','M','L','XL'], colors: ['Black','Navy','Ivory'],
    rating: 4.6, reviewCount: 223, soldCount: 610,
    rackId: 'rack_women_formal', rackName: "Women's Formal",
    details: {'Material':'Ponte Knit','Fit':'Fitted','Length':'Midi','Care':'Dry Clean Preferred'},
  ),
  // ── Women's Streetwear ────────────────────────────────────
  Product(
    id: 'p17', name: 'Cropped Leather Jacket', brand: 'Versace',
    description: 'The definitive statement piece. Premium vegan leather, silver-tone hardware, asymmetric zip closure. Pairs with everything from slip dresses to wide-leg jeans.',
    price: 299.99, originalPrice: 450.00, category: 'Women', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=700&q=85',
      'https://images.unsplash.com/photo-1548624313-0396c75e4b1a?w=700&q=85',
    ],
    sizes: ['XS','S','M','L'], colors: ['Black','Burgundy','Tan'],
    rating: 4.9, reviewCount: 342, soldCount: 710, isNew: true, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'Vegan Leather','Fit':'Cropped','Hardware':'Silver','Care':'Wipe Clean'},
  ),
  Product(
    id: 'p18', name: 'White Leather Sneakers', brand: 'Versace',
    description: 'Minimalist white leather sneakers with a cushioned memory-foam insole. Clean lines, signature back-tab, rubber outsole. Effortlessly versatile.',
    price: 129.99, category: 'Women', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=700&q=85',
      'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=700&q=85',
    ],
    sizes: ['36','37','38','39','40','41'], colors: ['White','Black'],
    rating: 4.9, reviewCount: 678, soldCount: 2300, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'Premium Leather','Sole':'Rubber','Insole':'Memory Foam','Care':'Wipe Clean'},
  ),
  // ── Kids ──────────────────────────────────────────────────
  Product(
    id: 'p19', name: 'Denim Overalls', brand: 'Tommy Hilfiger',
    description: 'Durable and adorable denim overalls with adjustable straps and reinforced knees. Built to keep up with every adventure.',
    price: 49.99, originalPrice: 70.00, category: 'Kids', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=700&q=85',
      'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=700&q=85',
    ],
    sizes: ['3T','4T','5T','6','7','8'], colors: ['Light Denim','Dark Denim'],
    rating: 4.8, reviewCount: 234, soldCount: 670,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'Soft Denim','Feature':'Reinforced Knees','Straps':'Adjustable','Care':'Machine Wash'},
  ),
  Product(
    id: 'p20', name: 'Graphic Tee & Shorts Set', brand: 'Ralph Lauren',
    description: 'Fun graphic tee and matching pull-on shorts. Super-soft 100% cotton jersey. The perfect play set.',
    price: 39.99, category: 'Kids', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?w=700&q=85',
      'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=700&q=85',
    ],
    sizes: ['3T','4T','5T','6','7','8'], colors: ['Blue','Red','Yellow'],
    rating: 4.6, reviewCount: 178, soldCount: 440, isNew: true,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'100% Cotton','Set':'2-Piece','Waistband':'Elastic','Care':'Machine Wash'},
  ),
  // ── Accessories ───────────────────────────────────────────
  Product(
    id: 'p21', name: 'Full-Grain Leather Tote', brand: 'Chanel',
    description: 'Spacious, elegant tote in full-grain vegetable-tanned leather. Gold-tone hardware, interior zip pocket, cotton canvas lining. Improves with age.',
    price: 189.99, originalPrice: 280.00, category: 'Accessories', subCategory: 'Bags',
    images: [
      'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=700&q=85',
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=700&q=85',
    ],
    sizes: ['One Size'], colors: ['Tan','Black','Cognac'],
    rating: 4.9, reviewCount: 312, soldCount: 540, isFeatured: true,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'Full-Grain Leather','Hardware':'Gold-Tone','Dimensions':'14x12x5"','Lining':'Canvas'},
  ),
  Product(
    id: 'p22', name: 'Merino Wool Scarf', brand: 'Prada',
    description: 'Luxuriously soft merino wool scarf in a classic ribbed pattern. Extra-long for versatile styling — wrap, drape, or layer.',
    price: 69.99, originalPrice: 100.00, category: 'Accessories', subCategory: 'Scarves',
    images: [
      'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=700&q=85',
      'https://images.unsplash.com/photo-1574180566232-aaad1b5b8450?w=700&q=85',
    ],
    sizes: ['One Size'], colors: ['Camel','Charcoal','Cream','Burgundy'],
    rating: 4.8, reviewCount: 145, soldCount: 320,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'100% Merino Wool','Length':'180cm','Pattern':'Ribbed Knit','Care':'Hand Wash'},
  ),
  Product(
    id: 'p23', name: 'Minimalist Leather Watch', brand: 'Dior',
    description: 'Swiss-movement timepiece with a brushed stainless case, sapphire crystal, and genuine leather strap. Understated luxury for the discerning wearer.',
    price: 299.99, originalPrice: 420.00, category: 'Accessories', subCategory: 'Watches',
    images: [
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=700&q=85',
      'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=700&q=85',
    ],
    sizes: ['One Size'], colors: ['Black','Brown'],
    rating: 4.9, reviewCount: 198, soldCount: 290, isFeatured: true,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Case':'38mm Stainless','Crystal':'Sapphire','Movement':'Swiss Quartz','Strap':'Genuine Leather'},
  ),
  Product(
    id: 'p24', name: 'Polarized Sunglasses', brand: 'Gucci',
    description: 'Sleek geometric frames with polarized UV400 lenses. Lightweight acetate, spring hinges. Effortless cool with all-day comfort.',
    price: 149.99, originalPrice: 210.00, category: 'Accessories', subCategory: 'Eyewear',
    images: [
      'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=700&q=85',
      'https://images.unsplash.com/photo-1508296695146-257a814070b4?w=700&q=85',
    ],
    sizes: ['One Size'], colors: ['Black','Tortoise','Gold'],
    rating: 4.7, reviewCount: 267, soldCount: 430,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Frame':'Lightweight Acetate','Lens':'Polarized UV400','Hinges':'Spring','Fit':'Medium'},
  ),
  Product(
    id: 'p25', name: 'Woven Leather Belt', brand: 'Prada',
    description: 'Hand-woven full-grain leather belt with a matte silver buckle. A masterclass in Italian craftsmanship. Fits waist 28–40".',
    price: 79.99, originalPrice: 115.00, category: 'Accessories', subCategory: 'Belts',
    images: [
      'https://images.unsplash.com/photo-1624222247344-550fb60583dc?w=700&q=85',
      'https://images.unsplash.com/photo-1624222247344-550fb60583dc?w=700&q=85',
    ],
    sizes: ['S','M','L','XL'], colors: ['Black','Tan','Brown'],
    rating: 4.6, reviewCount: 134, soldCount: 280,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'Full-Grain Leather','Buckle':'Matte Silver','Width':'3.5cm','Origin':'Italy'},
  ),
  Product(
    id: 'p26', name: 'Canvas Baseball Cap', brand: 'Ralph Lauren',
    description: 'Six-panel unstructured cap in premium canvas. Embroidered tonal logo, curved brim, adjustable back strap. The finishing touch.',
    price: 44.99, category: 'Accessories', subCategory: 'Hats',
    images: [
      'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=700&q=85',
      'https://images.unsplash.com/photo-1556306535-0f09a537f0a3?w=700&q=85',
    ],
    sizes: ['One Size'], colors: ['Black','Cream','Navy','Olive'],
    rating: 4.5, reviewCount: 289, soldCount: 760, isNew: true,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'Canvas','Closure':'Adjustable','Panels':'6','Care':'Spot Clean'},
  ),
  Product(
    id: 'p27', name: 'High-Top Leather Boots', brand: 'Versace',
    description: 'Italian-crafted high-top boots in supple full-grain leather. Cushioned footbed, lug sole, YKK side zip for easy on-off. Built to last a decade.',
    price: 349.99, originalPrice: 480.00, category: 'Accessories', subCategory: 'Shoes',
    images: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=700&q=85',
      'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=700&q=85',
    ],
    sizes: ['39','40','41','42','43','44','45'], colors: ['Black','Dark Brown'],
    rating: 4.8, reviewCount: 156, soldCount: 210, isFeatured: true,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'Full-Grain Leather','Sole':'Lug','Closure':'Side Zip + Laces','Origin':'Italy'},
  ),
  Product(
    id: 'p28', name: 'Structured Crossbody Bag', brand: 'Chanel',
    description: 'Compact yet capacious structured crossbody in pebbled leather. Adjustable chain strap, magnetic snap closure, suede-lined interior.',
    price: 219.99, originalPrice: 310.00, category: 'Accessories', subCategory: 'Bags',
    images: [
      'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=700&q=85',
      'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=700&q=85',
    ],
    sizes: ['One Size'], colors: ['Black','Dusty Rose','Tan'],
    rating: 4.9, reviewCount: 278, soldCount: 390, isNew: true,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'Pebbled Leather','Strap':'Chain (Adjustable)','Closure':'Magnetic Snap','Lining':'Suede'},
  ),
];

final kBanners = <BannerData>[
  BannerData(
    id: 'b1',
    imageUrl: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=900&q=85',
    title: 'New Season\nEditorial', subtitle: 'Curated looks for the season ahead',
    actionLabel: 'Explore Now', route: '/explore', tag: 'SS 2025',
  ),
  BannerData(
    id: 'b2',
    imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=900&q=85',
    title: "Women's\nEssentials", subtitle: 'Timeless pieces, refined for today',
    actionLabel: 'Discover', route: '/explore', tag: 'NEW IN',
  ),
  BannerData(
    id: 'b3',
    imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=900&q=85',
    title: 'Up to 35%\nOff', subtitle: 'End of season sale — limited time',
    actionLabel: 'Shop Sale', route: '/explore', tag: 'SALE',
  ),
  BannerData(
    id: 'b4',
    imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900&q=85',
    title: 'Accessories\nEdit', subtitle: 'Complete your look with the right detail',
    actionLabel: 'Browse', route: '/explore', tag: 'EDIT',
  ),
];

final kCategories = <CategoryData>[
  CategoryData(
    id: 'men', name: 'Men', emoji: '👔',
    imageUrl: 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400&q=80',
  ),
  CategoryData(
    id: 'women', name: 'Women', emoji: '👗',
    imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400&q=80',
  ),
  CategoryData(
    id: 'kids', name: 'Kids', emoji: '🎒',
    imageUrl: 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=400&q=80',
  ),
  CategoryData(
    id: 'accessories', name: 'Accessories', emoji: '👜',
    imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400&q=80',
  ),
];

const kRackMap = <String, List<String>>{
  'rack_men_formal':   ['p01','p02','p03'],
  'rack_men_casual':   ['p04','p05','p06','p07'],
  'rack_streetwear':   ['p08','p09','p17','p18'],
  'rack_women_casual': ['p10','p11','p12','p13'],
  'rack_women_formal': ['p14','p15','p16'],
  'rack_kids':         ['p19','p20'],
  'rack_accessories':  ['p21','p22','p23','p24','p25','p26','p27','p28'],
};

const kRackNames = <String, String>{
  'rack_men_formal':   "Men's Formal Section",
  'rack_men_casual':   "Men's Casual Section",
  'rack_streetwear':   'Streetwear Collection',
  'rack_women_casual': "Women's Casual Section",
  'rack_women_formal': "Women's Formal Section",
  'rack_kids':         "Kids' Section",
  'rack_accessories':  'Accessories',
};

const _colorMap = <String, Color>{
  'White': Color(0xFFF8F8F8), 'Black': Color(0xFF1A1A1A),
  'Light Blue': Color(0xFF64B5F6), 'Navy': Color(0xFF0D47A1),
  'Charcoal': Color(0xFF424242), 'Khaki': Color(0xFFC8AD7F),
  'Olive': Color(0xFF6B8E23), 'Brown': Color(0xFF6B3F2A),
  'Cream': Color(0xFFFFF8DC), 'Stone': Color(0xFFD4C5B0),
  'Sage': Color(0xFFB2C5B0), 'Ecru': Color(0xFFF5F0E8),
  'Floral Blue': Color(0xFF6495ED), 'Floral Pink': Color(0xFFF8A4B8),
  'Ivory': Color(0xFFFFFFF0), 'Deep Red': Color(0xFFB71C1C),
  'Light Wash': Color(0xFFB3C7E6), 'Dark Wash': Color(0xFF3A5A8C),
  'Light Denim': Color(0xFF7BA3D4), 'Dark Denim': Color(0xFF3B5998),
  'Tan': Color(0xFFD2B48C), 'Champagne': Color(0xFFF7E7CE),
  'Dusty Rose': Color(0xFFDCB2A8), 'Dusty Blue': Color(0xFF9DB4C0),
  'Red': Color(0xFFE53935), 'Yellow': Color(0xFFFFEB3B),
  'Blue': Color(0xFF2962FF), 'Camel': Color(0xFFC19A6B),
  'Cognac': Color(0xFF9A463D), 'Grey': Color(0xFF9E9E9E),
  'Burgundy': Color(0xFF800020), 'Gold': Color(0xFFC4A265),
  'Tortoise': Color(0xFF8B5E3C), 'Dark Brown': Color(0xFF4A2C0A),
};

// ╔══════════════════════════════════════════════════════════╗
// ║  5 · STATE MANAGEMENT — Optimized Riverpod Providers    ║
// ╚══════════════════════════════════════════════════════════╝

final authProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    // Simulate auth check — in production, read from secure storage
    await Future.delayed(const Duration(milliseconds: 800));
    return null;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.length >= 6) {
      state = AsyncData(_makeUser(email));
      return true;
    }
    state = const AsyncData(null);
    return false;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(AppUser(
      id: 'g001', name: 'Alex Johnson', email: 'alex@gmail.com',
      addresses: [_defaultAddress()],
    ));
  }

  Future<bool> signUp(String name, String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(AppUser(id: 'u_${DateTime.now().millisecondsSinceEpoch}', name: name, email: email));
    return true;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 400));
    state = const AsyncData(null);
  }

  AppUser _makeUser(String email) => AppUser(
    id: 'u001',
    name: email.split('@').first.split('.').map((w) =>
        w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}').join(' '),
    email: email, addresses: [_defaultAddress()],
  );

  Address _defaultAddress() => const Address(
    id: 'a01', name: 'Home', phone: '+1 234 567 8900',
    line1: '247 Fifth Avenue', line2: 'Apt 12B',
    city: 'New York', state: 'NY', zip: '10001',
    country: 'USA', isDefault: true,
  );
}

// ── Filter ─────────────────────────────────────────────────
class PFilter {
  final String? category, subCategory, search, sortBy;
  final List<String> sizes, colors;
  final double? minPrice, maxPrice;

  const PFilter({
    this.category, this.subCategory, this.search,
    this.sortBy = 'popularity', this.sizes = const [],
    this.colors = const [], this.minPrice, this.maxPrice,
  });

  bool get hasFilters =>
      category != null || sizes.isNotEmpty || colors.isNotEmpty ||
      minPrice != null || maxPrice != null || search != null;

  PFilter copyWith({
    String? category, String? subCategory, String? search, String? sortBy,
    List<String>? sizes, List<String>? colors,
    double? minPrice, double? maxPrice,
    bool clearCategory = false, bool clearSearch = false,
  }) => PFilter(
    category: clearCategory ? null : category ?? this.category,
    subCategory: subCategory ?? this.subCategory,
    search: clearSearch ? null : search ?? this.search,
    sortBy: sortBy ?? this.sortBy,
    sizes: sizes ?? this.sizes, colors: colors ?? this.colors,
    minPrice: minPrice ?? this.minPrice, maxPrice: maxPrice ?? this.maxPrice,
  );
}

final filterProvider = StateProvider<PFilter>((_) => const PFilter());

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final f = ref.watch(filterProvider);
  var list = kProducts.where((p) {
    if (f.category != null && p.category != f.category) return false;
    if (f.subCategory != null && p.subCategory != f.subCategory) return false;
    if (f.sizes.isNotEmpty && !p.sizes.any(f.sizes.contains)) return false;
    if (f.colors.isNotEmpty && !p.colors.any(f.colors.contains)) return false;
    if (f.minPrice != null && p.price < f.minPrice!) return false;
    if (f.maxPrice != null && p.price > f.maxPrice!) return false;
    if (f.search != null && f.search!.isNotEmpty) {
      final q = f.search!.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.subCategory.toLowerCase().contains(q);
    }
    return true;
  }).toList();

  switch (f.sortBy) {
    case 'price_low':  list.sort((a, b) => a.price.compareTo(b.price));
    case 'price_high': list.sort((a, b) => b.price.compareTo(a.price));
    case 'newest':     list.sort((a, b) => b.isNew ? 1 : -1);
    case 'rating':     list.sort((a, b) => b.rating.compareTo(a.rating));
    default:           list.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
  }
  return list;
});

// ── Cart ───────────────────────────────────────────────────
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (_) => CartNotifier());

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product p, String size, String color, {int qty = 1}) {
    final idx = state.indexWhere(
        (i) => i.product.id == p.id && i.selectedSize == size);
    if (idx >= 0) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity + qty),
        ...state.sublist(idx + 1),
      ];
    } else {
      state = [...state,
        CartItem(id: '${p.id}_$size', product: p, quantity: qty,
            selectedSize: size, selectedColor: color)];
    }
  }

  void remove(String id) => state = state.where((i) => i.id != id).toList();

  void updateQty(String id, int qty) {
    if (qty <= 0) { remove(id); return; }
    state = state.map((i) => i.id == id ? i.copyWith(quantity: qty) : i).toList();
  }

  void clear() => state = [];

  double get subtotal => state.fold(0, (s, i) => s + i.total);
  double get shipping  => subtotal >= 100 ? 0 : 9.99;
  double get total     => subtotal + shipping;
  int    get count     => state.fold(0, (s, i) => s + i.quantity);
}

// Use select to avoid unnecessary rebuilds
final cartCountProvider    = Provider<int>((ref)    => ref.watch(cartProvider.notifier).count);
final cartSubtotalProvider = Provider<double>((ref) => ref.watch(cartProvider.notifier).subtotal);
final cartTotalProvider    = Provider<double>((ref) => ref.watch(cartProvider.notifier).total);

// ── Wishlist ───────────────────────────────────────────────
final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (_) => WishlistNotifier());

class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);
  void toggle(Product p) => state = state.any((x) => x.id == p.id)
      ? state.where((x) => x.id != p.id).toList()
      : [...state, p];
  bool has(String id) => state.any((x) => x.id == id);
}

final inWishlistProvider = Provider.family<bool, String>(
  (ref, id) {
    final items = ref.watch(wishlistProvider);
    return items.any((x) => x.id == id);
  });

// ── Recently Viewed ────────────────────────────────────────
final recentlyViewedProvider =
    StateNotifierProvider<RecentlyViewedNotifier, List<Product>>(
        (_) => RecentlyViewedNotifier());

class RecentlyViewedNotifier extends StateNotifier<List<Product>> {
  RecentlyViewedNotifier() : super([]);
  void add(Product p) =>
      state = [p, ...state.where((x) => x.id != p.id)].take(10).toList();
}

// ── Orders ─────────────────────────────────────────────────
final ordersProvider = StateNotifierProvider<OrdersNotifier, List<AppOrder>>(
  (_) => OrdersNotifier());

class OrdersNotifier extends StateNotifier<List<AppOrder>> {
  OrdersNotifier() : super([
    AppOrder(
      id: 'o1', orderNumber: 'NR-2025-001', items: [],
      subtotal: 329.98, shipping: 0, total: 329.98,
      address: const Address(id: 'a1', name: 'Home', phone: '+1 234 567 8900',
          line1: '247 Fifth Avenue', city: 'New York', state: 'NY',
          zip: '10001', country: 'USA', isDefault: true),
      paymentMethod: 'Card Payment', status: OrderStatus.delivered,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AppOrder(
      id: 'o2', orderNumber: 'NR-2025-002', items: [],
      subtotal: 249.99, shipping: 0, total: 249.99,
      address: const Address(id: 'a1', name: 'Home', phone: '+1 234 567 8900',
          line1: '247 Fifth Avenue', city: 'New York', state: 'NY',
          zip: '10001', country: 'USA', isDefault: true),
      paymentMethod: 'Cash on Delivery', status: OrderStatus.shipped,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      estimatedDelivery: DateTime.now().add(const Duration(days: 2)),
    ),
  ]);

  Future<AppOrder> place({
    required List<CartItem> items,
    required Address address,
    required String payment,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final sub  = items.fold<double>(0, (s, i) => s + i.total);
    final ship = sub >= 100 ? 0.0 : 9.99;
    final order = AppOrder(
      id: 'o_${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: 'NR-2025-${(state.length + 1).toString().padLeft(3, '0')}',
      items: items, subtotal: sub, shipping: ship, total: sub + ship,
      address: address, paymentMethod: payment,
      status: OrderStatus.placed, createdAt: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 5)),
    );
    state = [order, ...state];
    return order;
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║  6 · ROUTER                                             ║
// ╚══════════════════════════════════════════════════════════╝

final _rootKey  = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    redirect: (ctx, state) {
      final isSplash = state.matchedLocation == '/splash';
      if (isSplash) return null; // Always let splash render

      final loggedIn = auth.valueOrNull != null;
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/register');

      if (!loggedIn && !isAuthRoute) return '/login';
      if (loggedIn && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (c, s) => _fade(s, const SplashScreen()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (c, s) => _fade(s, const LoginScreen()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (c, s) => _slide(s, const RegisterScreen()),
      ),
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (c, s, child) => MainNav(child: child),
        routes: [
          GoRoute(path: '/',         pageBuilder: (c, s) => _none(s, const HomeScreen())),
          GoRoute(path: '/explore',  pageBuilder: (c, s) => _none(s, const ExploreScreen())),
          GoRoute(path: '/cart',     pageBuilder: (c, s) => _none(s, const CartScreen())),
          GoRoute(path: '/wishlist', pageBuilder: (c, s) => _none(s, const WishlistScreen())),
          GoRoute(path: '/profile',  pageBuilder: (c, s) => _none(s, const ProfileScreen())),
        ],
      ),
      GoRoute(
        path: '/product/:id',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slideUp(s, ProductDetailScreen(product: s.extra as Product?)),
      ),
      GoRoute(
        path: '/checkout',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slideUp(s, const CheckoutScreen()),
      ),
      GoRoute(
        path: '/orders',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const OrdersScreen()),
      ),
      GoRoute(
        path: '/try-on',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _fade(s, TryOnScreen(product: s.extra as Product?)),
      ),
      GoRoute(
        path: '/qr-scanner',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _fade(s, const QrScannerScreen()),
      ),
      GoRoute(
        path: '/rack/:id',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, RackProductsScreen(
            rackId: s.pathParameters['id']!, extra: s.extra)),
      ),
      GoRoute(
        path: '/order-success',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slideUp(s, OrderSuccessScreen(order: s.extra as AppOrder)),
      ),
    ],
  );
});

Page<dynamic> _fade(GoRouterState s, Widget c) => CustomTransitionPage(
  key: s.pageKey, child: c,
  transitionsBuilder: (ctx, a, b, ch) => FadeTransition(opacity: a, child: ch));
Page<dynamic> _none(GoRouterState s, Widget c) => NoTransitionPage(key: s.pageKey, child: c);
Page<dynamic> _slide(GoRouterState s, Widget c) => CustomTransitionPage(
  key: s.pageKey, child: c,
  transitionsBuilder: (ctx, a, b, ch) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
    child: ch));
Page<dynamic> _slideUp(GoRouterState s, Widget c) => CustomTransitionPage(
  key: s.pageKey, child: c,
  transitionsBuilder: (ctx, a, b, ch) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
    child: ch));

// ╔══════════════════════════════════════════════════════════╗
// ║  7 · APP ROOT                                           ║
// ╚══════════════════════════════════════════════════════════╝

class NoirApp extends ConsumerWidget {
  const NoirApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'NOIR',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: router,
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║  8 · SHARED WIDGETS                                     ║
// ╚══════════════════════════════════════════════════════════╝

/// Optimized network image with shimmer loading
class Img extends StatelessWidget {
  final String url;
  final double? w, h;
  final BoxFit fit;
  final double r;

  const Img(this.url, {super.key, this.w, this.h,
      this.fit = BoxFit.cover, this.r = 0});

  @override
  Widget build(BuildContext ctx) => ClipRRect(
    borderRadius: BorderRadius.circular(r),
    child: url.startsWith('http') 
      ? CachedNetworkImage(
          imageUrl: url, width: w, height: h, fit: fit,
          fadeInDuration: const Duration(milliseconds: 300),
          placeholder: (c, u) => Shimmer.fromColors(
            baseColor: C.n200, highlightColor: C.n100,
            child: Container(width: w, height: h, color: C.n200)),
          errorWidget: (c, u, e) => Container(
            width: w, height: h, color: C.n100,
            child: const Center(child: Icon(
                Icons.image_outlined, color: C.n300, size: 28))),
        )
      : Image.asset(url, width: w, height: h, fit: fit),
  );
}

/// Primary action button
class Btn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final double? w;
  final IconData? icon;
  final Color? bg, fg;
  final double h;

  const Btn({
    super.key, required this.text, this.onPressed, this.loading = false,
    this.w, this.icon, this.bg, this.fg, this.h = 52,
  });

  @override
  Widget build(BuildContext ctx) => SizedBox(
    width: w ?? double.infinity, height: h,
    child: ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: bg ?? C.ink,
          foregroundColor: fg ?? C.white,
          disabledBackgroundColor: C.n200),
      child: loading
          ? SizedBox(
              width: 20, height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: fg ?? C.white))
          : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(text),
            ]),
    ),
  );
}

class GoldBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? w;

  const GoldBtn({super.key, required this.text, this.onPressed, this.w});

  @override
  Widget build(BuildContext ctx) => Btn(
    text: text, onPressed: onPressed, w: w, bg: C.gold, fg: C.white);
}

class OutBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? w;

  const OutBtn({super.key, required this.text, this.onPressed, this.w});

  @override
  Widget build(BuildContext ctx) => SizedBox(
    width: w ?? double.infinity, height: 52,
    child: OutlinedButton(onPressed: onPressed, child: Text(text)));
}

/// Section header with optional "See All" link
class SecHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAll;

  const SecHeader({super.key, required this.title, this.onAll});

  @override
  Widget build(BuildContext ctx) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,
        style: GoogleFonts.cormorantGaramond(
            fontSize: 22, fontWeight: FontWeight.w700, color: C.ink)),
      if (onAll != null)
        TextButton(
          onPressed: onAll,
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero, minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text('See All',
            style: GoogleFonts.dmSans(
                fontSize: 13, color: C.gold, fontWeight: FontWeight.w600,
                letterSpacing: 0.3)),
        ),
    ],
  );
}

class Stars extends StatelessWidget {
  final double rating;
  final int count;
  final double sz;

  const Stars({super.key, required this.rating, this.count = 0, this.sz = 13});

  @override
  Widget build(BuildContext ctx) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(Icons.star_rounded, color: C.gold, size: sz),
    const SizedBox(width: 2),
    Text(rating.toStringAsFixed(1),
      style: GoogleFonts.dmSans(
          fontSize: sz - 1, fontWeight: FontWeight.w600, color: C.n700)),
    if (count > 0)
      Text(' ($count)',
        style: GoogleFonts.dmSans(fontSize: sz - 1, color: C.n400)),
  ]);
}

class SaleBadge extends StatelessWidget {
  final double pct;
  const SaleBadge({super.key, required this.pct});

  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
        color: C.gold, borderRadius: BorderRadius.circular(2)),
    child: Text('-${pct.toInt()}%',
      style: GoogleFonts.dmSans(
          color: C.white, fontSize: 9, fontWeight: FontWeight.w700)),
  );
}

class NewBadge extends StatelessWidget {
  const NewBadge({super.key});

  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
        color: C.ink, borderRadius: BorderRadius.circular(2)),
    child: Text('NEW',
      style: GoogleFonts.dmSans(
          color: C.white, fontSize: 9, fontWeight: FontWeight.w700,
          letterSpacing: 0.8)),
  );
}

class EmptyView extends StatelessWidget {
  final IconData icon;
  final String title, desc;
  final String? btnLabel;
  final VoidCallback? onBtn;

  const EmptyView({
    super.key, required this.icon, required this.title, required this.desc,
    this.btnLabel, this.onBtn,
  });

  @override
  Widget build(BuildContext ctx) => Center(
    child: Padding(padding: const EdgeInsets.all(40),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 88, height: 88,
          decoration: const BoxDecoration(color: C.n100, shape: BoxShape.circle),
          child: Icon(icon, size: 36, color: C.n300)),
        const SizedBox(height: 20),
        Text(title,
          style: GoogleFonts.cormorantGaramond(
              fontSize: 22, fontWeight: FontWeight.w600, color: C.ink),
          textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(desc,
          style: GoogleFonts.dmSans(fontSize: 14, color: C.n500, height: 1.5),
          textAlign: TextAlign.center),
        if (btnLabel != null && onBtn != null) ...[
          const SizedBox(height: 28),
          Btn(text: btnLabel!, onPressed: onBtn, w: 180),
        ],
      ])),
  );
}

void snack(BuildContext ctx, String msg,
    {bool err = false, String? action, VoidCallback? onAction}) =>
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: err ? C.error : C.ink,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      action: action != null
          ? SnackBarAction(label: action,
              textColor: C.gold, onPressed: onAction ?? () {})
          : null,
    ));

// ── Animated Wishlist Heart Button ─────────────────────────
class _WishBtn extends StatefulWidget {
  final bool isWished;
  final VoidCallback onTap;
  final double size;
  final bool shadow;

  const _WishBtn({
    required this.isWished,
    required this.onTap,
    this.size = 15,
    this.shadow = false,
  });

  @override
  State<_WishBtn> createState() => _WishBtnState();
}

class _WishBtnState extends State<_WishBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(_WishBtn old) {
    super.didUpdateWidget(old);
    if (widget.isWished && !old.isWished) _ctrl.forward(from: 0);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTap: widget.onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: widget.size + 22,
      height: widget.size + 22,
      decoration: BoxDecoration(
        color: C.white.withOpacity(0.92),
        shape: BoxShape.circle,
        boxShadow: widget.shadow
            ? const [BoxShadow(color: C.shadowMd, blurRadius: 8)]
            : [],
      ),
      child: Center(child: ScaleTransition(
        scale: _scale,
        child: Icon(
          widget.isWished
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: widget.isWished ? C.gold : C.n400,
          size: widget.size),
      )),
    ),
  );
}

// ── Logo Widget ────────────────────────────────────────────
class NoirLogo extends StatelessWidget {
  final double size;
  final bool dark;
  const NoirLogo({super.key, this.size = 36, this.dark = false});

  @override
  Widget build(BuildContext ctx) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: dark ? C.white : C.ink,
        borderRadius: BorderRadius.circular(size * 0.22)),
      child: Center(child: Text('N',
        style: GoogleFonts.cormorantGaramond(
            color: dark ? C.ink : C.white,
            fontSize: size * 0.6,
            fontWeight: FontWeight.w700))),
    ),
    const SizedBox(width: 10),
    Text('NOIR',
      style: GoogleFonts.dmSans(
          color: dark ? C.white : C.ink,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.47,
          letterSpacing: 2)),
  ]);
}

// ╔══════════════════════════════════════════════════════════╗
// ║  9 · BOTTOM NAVIGATION — IndexedStack for performance   ║
// ╚══════════════════════════════════════════════════════════╝

class MainNav extends ConsumerWidget {
  final Widget child;
  const MainNav({super.key, required this.child});

  static const _routes = ['/', '/explore', '/cart', '/wishlist', '/profile'];

  int _idx(String loc) {
    for (int i = _routes.length - 1; i >= 0; i--) {
      if (loc.startsWith(_routes[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final loc   = GoRouterState.of(ctx).matchedLocation;
    final cur   = _idx(loc);
    final count = ref.watch(cartCountProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: C.white,
          border: const Border(top: BorderSide(color: C.border, width: 1)),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12, offset: const Offset(0, -4))],
        ),
        child: SafeArea(child: SizedBox(height: 60, child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(Icons.home_outlined, Icons.home, 'Home',
                cur == 0, () => ctx.go('/'), null),
            _NavItem(Icons.grid_view_outlined, Icons.grid_view, 'Explore',
                cur == 1, () => ctx.go('/explore'), null),
            _NavItem(Icons.shopping_bag_outlined, Icons.shopping_bag, 'Cart',
                cur == 2, () => ctx.go('/cart'), count > 0 ? count : null),
            _NavItem(Icons.favorite_border_rounded, Icons.favorite_rounded, 'Saved',
                cur == 3, () => ctx.go('/wishlist'), null),
            _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile',
                cur == 4, () => ctx.go('/profile'), null),
          ],
        ))),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData ic, ica;
  final String lbl;
  final bool active;
  final VoidCallback tap;
  final int? badge;

  const _NavItem(this.ic, this.ica, this.lbl, this.active, this.tap, this.badge);

  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTap: tap, behavior: HitTestBehavior.opaque,
    child: SizedBox(width: 64, child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(clipBehavior: Clip.none, children: [
          Icon(active ? ica : ic, size: 22,
            color: active ? C.ink : C.n400),
          if (badge != null)
            Positioned(right: -6, top: -6, child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: C.gold, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text('$badge',
                style: const TextStyle(color: C.white, fontSize: 8,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
            )),
        ]),
        const SizedBox(height: 4),
        Text(lbl, style: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          color: active ? C.ink : C.n400)),
        if (active)
          Container(margin: const EdgeInsets.only(top: 3),
            width: 16, height: 2,
            decoration: BoxDecoration(
                color: C.gold, borderRadius: BorderRadius.circular(1))),
      ],
    )),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  10 · SPLASH SCREEN                                     ║
// ║  Single clean launch screen — replaces all onboarding   ║
// ╚══════════════════════════════════════════════════════════╝

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashState();
}

class _SplashState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<double> _taglineFade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));

    _fade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _ctrl,
            curve: const Interval(0, 0.5, curve: Curves.easeOut)));

    _scale = Tween<double>(begin: 0.88, end: 1).animate(
        CurvedAnimation(parent: _ctrl,
            curve: const Interval(0, 0.6, curve: Curves.easeOutBack)));

    _taglineFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _ctrl,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));

    _ctrl.forward();

    // Navigate after auth check
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      final auth = ref.read(authProvider).valueOrNull;
      if (auth != null) {
        context.go('/');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: C.ink,
    body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // ── Logo ─────────────────────────────────────────────
        FadeTransition(opacity: _fade,
          child: ScaleTransition(scale: _scale,
            child: Column(children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: C.gold,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(
                      color: C.gold.withOpacity(0.4),
                      blurRadius: 32, spreadRadius: 4)],
                ),
                child: Center(child: Text('N',
                  style: GoogleFonts.cormorantGaramond(
                      color: C.white, fontSize: 46, fontWeight: FontWeight.w700))),
              ),
              const SizedBox(height: 18),
              Text('NOIR',
                style: GoogleFonts.dmSans(
                    color: C.white, fontSize: 22,
                    fontWeight: FontWeight.w300, letterSpacing: 10)),
            ]),
          ),
        ),
        const SizedBox(height: 12),
        // ── Tagline ───────────────────────────────────────────
        FadeTransition(opacity: _taglineFade,
          child: Text('Premium Fashion',
            style: GoogleFonts.cormorantGaramond(
                color: C.gold.withOpacity(0.8), fontSize: 14,
                letterSpacing: 3, fontStyle: FontStyle.italic))),
        const SizedBox(height: 64),
        // ── Loader ────────────────────────────────────────────
        FadeTransition(opacity: _fade,
          child: SizedBox(
            width: 28, height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation(C.gold.withOpacity(0.7)),
            ),
          )),
      ]),
    ),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  11 · LOGIN SCREEN                                      ║
// ╚══════════════════════════════════════════════════════════╝

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginScreen> {
  final _fk = GlobalKey<FormState>();
  final _ec = TextEditingController();
  final _pc = TextEditingController();
  bool _hide = true, _loading = false;

  @override
  void dispose() {
    _ec.dispose();
    _pc.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_fk.currentState!.validate()) return;
    setState(() => _loading = true);
    final ok = await ref.read(authProvider.notifier)
        .signIn(_ec.text.trim(), _pc.text);
    if (mounted) setState(() => _loading = false);
    if (!ok && mounted) snack(context, 'Invalid credentials', err: true);
  }

  @override
  Widget build(BuildContext ctx) {
    final h = MediaQuery.of(ctx).size.height;
    return Scaffold(
      backgroundColor: C.ink,
      body: Stack(children: [
        // ── Fashion image half ──────────────────────────────
        Positioned(top: 0, left: 0, right: 0, height: h * 0.45,
          child: Stack(children: [
            CachedNetworkImage(
              imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800&q=85',
              fit: BoxFit.cover,
              width: double.infinity, height: h * 0.45,
              placeholder: (c, u) => Container(color: C.n800),
              errorWidget: (c, u, e) => Container(color: C.n800),
            ),
            // Dark overlay gradient
            Container(decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.0),
                  C.ink,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            )),
            // Logo top-left
            Positioned(
              top: MediaQuery.of(ctx).padding.top + 20, left: 24,
              child: const NoirLogo(size: 32, dark: true)
                  .animate().fadeIn(duration: 600.ms),
            ),
          ]),
        ),

        // ── Form card ──────────────────────────────────────
        Positioned(
          top: h * 0.38, left: 0, right: 0, bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: C.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
              child: Form(
                key: _fk,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Welcome back',
                    style: GoogleFonts.cormorantGaramond(
                        fontSize: 30, fontWeight: FontWeight.w700, color: C.ink)),
                  const SizedBox(height: 4),
                  Text('Sign in to continue',
                    style: GoogleFonts.dmSans(fontSize: 14, color: C.n500)),
                  const SizedBox(height: 28),

                  // Email
                  _FieldLabel('Email address'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _ec,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.dmSans(fontSize: 14, color: C.ink),
                    decoration: const InputDecoration(
                      hintText: 'your@email.com',
                      prefixIcon: Icon(Icons.email_outlined, size: 19, color: C.n400),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email required';
                      if (!v.contains('@')) return 'Invalid email';
                      return null;
                    },
                  ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),

                  // Password
                  _FieldLabel('Password'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _pc,
                    obscureText: _hide,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(),
                    style: GoogleFonts.dmSans(fontSize: 14, color: C.ink),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline, size: 19, color: C.n400),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hide ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: C.n400, size: 19),
                        onPressed: () => setState(() => _hide = !_hide)),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password required';
                      if (v.length < 6) return 'Minimum 6 characters';
                      return null;
                    },
                  ).animate().fadeIn(delay: 220.ms).slideY(begin: 0.1, end: 0),

                  Align(alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          foregroundColor: C.gold,
                          padding: const EdgeInsets.symmetric(vertical: 8)),
                      child: Text('Forgot password?',
                        style: GoogleFonts.dmSans(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                    )),
                  const SizedBox(height: 4),

                  // Sign in button
                  Btn(
                    text: 'Sign In', loading: _loading, onPressed: _login)
                      .animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 20),

                  // Divider
                  Row(children: [
                    const Expanded(child: Divider()),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('or',
                        style: GoogleFonts.dmSans(fontSize: 13, color: C.n400))),
                    const Expanded(child: Divider()),
                  ]),
                  const SizedBox(height: 20),

                  // Google
                  SizedBox(width: double.infinity, height: 52,
                    child: OutlinedButton(
                      onPressed: _loading ? null
                          : ref.read(authProvider.notifier).signInWithGoogle,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(width: 20, height: 20,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFF4285F4), Color(0xFF34A853),
                              Color(0xFFFBBC05), Color(0xFFEA4335)]),
                            shape: BoxShape.circle),
                          child: const Center(child: Text('G',
                            style: TextStyle(color: C.white,
                                fontWeight: FontWeight.w800, fontSize: 11)))),
                        const SizedBox(width: 10),
                        Text('Continue with Google',
                          style: GoogleFonts.dmSans(
                              color: C.ink, fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      ]),
                    )).animate().fadeIn(delay: 380.ms),

                  const SizedBox(height: 28),
                  Center(child: RichText(text: TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.dmSans(fontSize: 14, color: C.n500),
                    children: [WidgetSpan(child: GestureDetector(
                      onTap: () => ctx.push('/register'),
                      child: Text('Create Account',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, color: C.gold,
                            fontWeight: FontWeight.w700)),
                    ))],
                  ))),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext ctx) => Text(text,
    style: GoogleFonts.dmSans(
        fontSize: 12, fontWeight: FontWeight.w600,
        color: C.n600, letterSpacing: 0.3));
}

// ╔══════════════════════════════════════════════════════════╗
// ║  12 · REGISTER SCREEN                                   ║
// ╚══════════════════════════════════════════════════════════╝

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegState();
}

class _RegState extends ConsumerState<RegisterScreen> {
  final _fk = GlobalKey<FormState>();
  final _nc = TextEditingController();
  final _ec = TextEditingController();
  final _pc = TextEditingController();
  final _cc = TextEditingController();
  bool _hp = true, _hc = true, _load = false, _agreed = false;

  @override
  void dispose() {
    _nc.dispose(); _ec.dispose(); _pc.dispose(); _cc.dispose();
    super.dispose();
  }

  Future<void> _reg() async {
    if (!_fk.currentState!.validate()) return;
    if (!_agreed) { snack(context, 'Please agree to Terms', err: true); return; }
    setState(() => _load = true);
    await ref.read(authProvider.notifier)
        .signUp(_nc.text.trim(), _ec.text.trim(), _pc.text);
    if (mounted) setState(() => _load = false);
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: C.white,
    body: CustomScrollView(slivers: [
      SliverAppBar(
        backgroundColor: C.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => ctx.pop()),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 48),
          child: Form(key: _fk, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            const NoirLogo(),
            const SizedBox(height: 20),
            Text('Create Account',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 32, fontWeight: FontWeight.w700, color: C.ink))
                .animate().fadeIn().slideX(begin: -0.15, end: 0),
            const SizedBox(height: 6),
            Text('Join NOIR and discover your style',
              style: GoogleFonts.dmSans(fontSize: 14, color: C.n500))
                .animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 32),

            _FieldLabel('Full Name'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _nc,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Your name',
                prefixIcon: Icon(Icons.person_outline, size: 19)),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name required';
                return null;
              }),
            const SizedBox(height: 16),

            _FieldLabel('Email'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _ec,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'your@email.com',
                prefixIcon: Icon(Icons.email_outlined, size: 19)),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email required';
                if (!v.contains('@')) return 'Invalid email';
                return null;
              }),
            const SizedBox(height: 16),

            _FieldLabel('Password'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _pc,
              obscureText: _hp,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, size: 19),
                suffixIcon: IconButton(
                  icon: Icon(_hp ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined, color: C.n400),
                  onPressed: () => setState(() => _hp = !_hp))),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password required';
                if (v.length < 6) return 'Minimum 6 characters';
                return null;
              }),
            const SizedBox(height: 16),

            _FieldLabel('Confirm Password'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _cc,
              obscureText: _hc,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, size: 19),
                suffixIcon: IconButton(
                  icon: Icon(_hc ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined, color: C.n400),
                  onPressed: () => setState(() => _hc = !_hc))),
              validator: (v) {
                if (v != _pc.text) return 'Passwords do not match';
                return null;
              }),
            const SizedBox(height: 20),

            Row(children: [
              Checkbox(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false)),
              Expanded(child: RichText(text: TextSpan(
                text: 'I agree to the ',
                style: GoogleFonts.dmSans(fontSize: 13, color: C.n600),
                children: const [
                  TextSpan(text: 'Terms of Service',
                    style: TextStyle(color: C.gold, fontWeight: FontWeight.w600)),
                  TextSpan(text: ' & '),
                  TextSpan(text: 'Privacy Policy',
                    style: TextStyle(color: C.gold, fontWeight: FontWeight.w600)),
                ]))),
            ]),
            const SizedBox(height: 24),

            Btn(text: 'Create Account', loading: _load, onPressed: _reg)
                .animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 24),

            Center(child: RichText(text: TextSpan(
              text: 'Already have an account? ',
              style: GoogleFonts.dmSans(fontSize: 14, color: C.n500),
              children: [WidgetSpan(child: GestureDetector(
                onTap: () => ctx.pop(),
                child: Text('Sign In',
                  style: GoogleFonts.dmSans(
                      fontSize: 14, color: C.gold,
                      fontWeight: FontWeight.w700)),
              ))],
            ))),
          ])),
        ),
      ),
    ]),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  13 · HOME SCREEN — Expanded & Virtualized              ║
// ╚══════════════════════════════════════════════════════════╝

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final user     = ref.watch(authProvider).valueOrNull;
    final featured = kProducts.where((p) => p.isFeatured).toList();
    final newArrs  = kProducts.where((p) => p.isNew).toList();
    final menItems = kProducts.where((p) => p.category == 'Men').toList();
    final womenItems = kProducts.where((p) => p.category == 'Women').toList();
    final accessories = kProducts.where((p) => p.category == 'Accessories').toList();

    return Scaffold(
      backgroundColor: C.canvas,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── AppBar ──────────────────────────────────────
          SliverAppBar(
            pinned: true, floating: true,
            backgroundColor: C.white,
            automaticallyImplyLeading: false,
            title: const NoirLogo(size: 30),
            actions: [
              IconButton(
                icon: const Icon(Icons.qr_code_scanner_rounded, size: 22),
                onPressed: () => ctx.push('/qr-scanner'),
                tooltip: 'Rack Scanner'),
              IconButton(
                icon: const Icon(Icons.search_rounded, size: 22),
                onPressed: () => ctx.go('/explore')),
              const SizedBox(width: 4),
            ],
          ),

          SliverToBoxAdapter(child: Column(children: [
            // ── Location Bar ──────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: C.white,
                  border: Border.all(color: C.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(children: [
                  const Icon(Icons.location_on_outlined,
                      color: C.gold, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deliver to',
                        style: GoogleFonts.dmSans(
                            fontSize: 10, color: C.n400, fontWeight: FontWeight.w500)),
                      Text(user?.defaultAddress?.short ?? 'Set delivery address',
                        style: GoogleFonts.dmSans(
                            fontSize: 12, color: C.ink,
                            fontWeight: FontWeight.w600)),
                    ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: C.ink,
                      borderRadius: BorderRadius.circular(4)),
                    child: Text('Change',
                      style: GoogleFonts.dmSans(
                          color: C.white, fontSize: 11,
                          fontWeight: FontWeight.w600)),
                  ),
                ]),
              )),

            // ── Banner Slider ─────────────────────────────
            const SizedBox(height: 16),
            const _BannerSlider(),

            // ── Category Grid ─────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(children: [
                SecHeader(
                  title: 'Shop by Category',
                  onAll: () => ctx.go('/explore')),
                const SizedBox(height: 14),
                Row(children: kCategories.map((cat) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final catName = cat.name;
                      ref.read(filterProvider.notifier).update(
                          (s) => s.copyWith(category: catName));
                      ctx.go('/explore');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: C.border),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(children: [
                          Img(cat.imageUrl, w: double.infinity, h: 90),
                          Container(color: Colors.black.withOpacity(0.42)),
                          Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cat.emoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 3),
                              Text(cat.name,
                                style: GoogleFonts.dmSans(
                                    fontSize: 11, fontWeight: FontWeight.w600,
                                    color: C.white)),
                            ])),
                        ]),
                      ),
                    ),
                  ),
                )).toList()),
              ])),

            // ── Featured Collection ────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SecHeader(title: 'Featured',
                    onAll: () => ctx.go('/explore')),
                const SizedBox(height: 14),
                SizedBox(height: 260, child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: featured.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => RepaintBoundary(
                    child: _ProdCard(featured[i], wide: true)),
                )),
              ])),

            // ── New Arrivals ───────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SecHeader(title: 'New Arrivals',
                    onAll: () => ctx.go('/explore')),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.72,
                    crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemCount: newArrs.take(6).length,
                  itemBuilder: (_, i) => RepaintBoundary(
                    child: _ProdCard(newArrs[i])),
                ),
              ])),

            // ── Men's Edit ────────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SecHeader(title: "Men's Edit",
                  onAll: () {
                    ref.read(filterProvider.notifier).update(
                        (s) => s.copyWith(category: 'Men'));
                    ctx.go('/explore');
                  }),
                const SizedBox(height: 14),
                SizedBox(height: 260, child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: menItems.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => RepaintBoundary(
                    child: _ProdCard(menItems[i], wide: true)),
                )),
              ])),

            // ── Editorial Banner ───────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
              child: _EditorialBanner()),

            // ── Women's Collection ─────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SecHeader(title: "Women's Collection",
                  onAll: () {
                    ref.read(filterProvider.notifier).update(
                        (s) => s.copyWith(category: 'Women'));
                    ctx.go('/explore');
                  }),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.72,
                    crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemCount: womenItems.take(6).length,
                  itemBuilder: (_, i) => RepaintBoundary(
                    child: _ProdCard(womenItems[i])),
                ),
              ])),

            // ── Accessories ────────────────────────────────
            Padding(padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SecHeader(title: 'Accessories',
                  onAll: () {
                    ref.read(filterProvider.notifier).update(
                        (s) => s.copyWith(category: 'Accessories'));
                    ctx.go('/explore');
                  }),
                const SizedBox(height: 14),
                SizedBox(height: 260, child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: accessories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => RepaintBoundary(
                    child: _ProdCard(accessories[i], wide: true)),
                )),
              ])),
          ])),
        ],
      ),
    );
  }
}

// ── Banner Slider ──────────────────────────────────────────
class _BannerSlider extends StatefulWidget {
  const _BannerSlider();

  @override
  State<_BannerSlider> createState() => _BSState();
}

class _BSState extends State<_BannerSlider> {
  final _ctrl = PageController();
  int _cur = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_cur + 1) % kBanners.length;
      _ctrl.animateToPage(next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(children: [
      SizedBox(height: 195, child: PageView.builder(
        controller: _ctrl, itemCount: kBanners.length,
        onPageChanged: (i) => setState(() => _cur = i),
        itemBuilder: (_, i) {
          final b = kBanners[i];
          return GestureDetector(
            onTap: () => context.go(b.route),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(children: [
                CachedNetworkImage(
                  imageUrl: b.imageUrl,
                  width: double.infinity, height: 195, fit: BoxFit.cover,
                  placeholder: (c, u) => Container(color: C.n200),
                  errorWidget: (c, u, e) => Container(
                    color: C.n900,
                    child: const Center(child: Icon(
                        Icons.image_outlined, color: C.n600, size: 40))),
                ),
                Container(decoration: const BoxDecoration(gradient: C.heroGrad)),
                Padding(padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: C.gold,
                          borderRadius: BorderRadius.circular(2)),
                        child: Text(b.tag,
                          style: GoogleFonts.dmSans(
                              color: C.white, fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2)),
                      ),
                      const SizedBox(height: 8),
                      Text(b.title,
                        style: GoogleFonts.cormorantGaramond(
                            fontSize: 26, fontWeight: FontWeight.w700,
                            color: C.white, height: 1.1)),
                      const SizedBox(height: 5),
                      Text(b.subtitle,
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8))),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 7),
                        decoration: BoxDecoration(
                          color: C.white,
                          borderRadius: BorderRadius.circular(4)),
                        child: Text(b.actionLabel,
                          style: GoogleFonts.dmSans(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: C.ink)),
                      ),
                    ])),
              ]),
            ),
          );
        },
      )),
      const SizedBox(height: 10),
      AnimatedSmoothIndicator(
        activeIndex: _cur, count: kBanners.length,
        effect: const WormEffect(
            dotHeight: 5, dotWidth: 5,
            activeDotColor: C.gold, dotColor: C.n300, spacing: 6)),
    ]),
  );
}

// ── Editorial Banner ───────────────────────────────────────
class _EditorialBanner extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Stack(children: [
      CachedNetworkImage(
        imageUrl: 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=900&q=85',
        width: double.infinity, height: 160, fit: BoxFit.cover,
        placeholder: (c, u) => Container(height: 160, color: C.n200),
        errorWidget: (c, u, e) => Container(height: 160, color: C.n800),
      ),
      Container(height: 160, color: Colors.black.withOpacity(0.48)),
      Positioned.fill(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('NOIR Editorial',
                style: GoogleFonts.dmSans(
                    color: C.gold, fontSize: 11,
                    fontWeight: FontWeight.w600, letterSpacing: 1.5)),
              const SizedBox(height: 6),
              Text('Style Guide\nSS 2025',
                style: GoogleFonts.cormorantGaramond(
                    color: C.white, fontSize: 28,
                    fontWeight: FontWeight.w700, height: 1.1)),
            ])),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: C.gold, foregroundColor: C.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
            child: Text('Read',
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w700))),
        ]),
      )),
    ]),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  14 · PRODUCT CARD — Optimized with RepaintBoundary     ║
// ╚══════════════════════════════════════════════════════════╝

class _ProdCard extends ConsumerWidget {
  final Product p;
  final bool wide;

  const _ProdCard(this.p, {this.wide = false});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final inWish = ref.watch(inWishlistProvider(p.id));

    return GestureDetector(
      onTap: () {
        ref.read(recentlyViewedProvider.notifier).add(p);
        ctx.push('/product/${p.id}', extra: p);
      },
      child: Container(
        width: wide ? 165 : null,
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: C.border),
          boxShadow: const [BoxShadow(
              color: C.shadowMd, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Image ────────────────────────────────────────
          Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8)),
              child: Img(p.images.first,
                  w: double.infinity, h: wide ? 155 : 150)),
            // Badges
            Positioned(top: 8, left: 8, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (p.hasDiscount) SaleBadge(pct: p.discount),
                if (p.isNew) ...[const SizedBox(height: 4), const NewBadge()],
              ])),
            // Wishlist button
            Positioned(top: 6, right: 6, child: _WishBtn(
              isWished: inWish,
              onTap: () {
                ref.read(wishlistProvider.notifier).toggle(p);
                HapticFeedback.lightImpact();
              },
              size: 15,
            )),
          ]),
          // ── Info ─────────────────────────────────────────
          Expanded(child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(p.brand,
                  style: GoogleFonts.dmSans(
                      fontSize: 10, color: C.n400,
                      fontWeight: FontWeight.w500, letterSpacing: 0.3),
                  overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(p.name,
                  style: GoogleFonts.dmSans(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: C.ink),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(children: [
                  Icon(Icons.star_rounded, color: C.gold, size: 11),
                  const SizedBox(width: 2),
                  Text(p.rating.toStringAsFixed(1),
                    style: GoogleFonts.dmSans(
                        fontSize: 10, fontWeight: FontWeight.w600,
                        color: C.n700)),
                ]),
                const Spacer(),
                Row(crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('\$${p.price.toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                          fontSize: 14, fontWeight: FontWeight.w700,
                          color: C.ink)),
                    if (p.hasDiscount) ...[
                      const SizedBox(width: 5),
                      Text('\$${p.originalPrice!.toStringAsFixed(2)}',
                        style: GoogleFonts.dmSans(
                            fontSize: 10, color: C.n400,
                            decoration: TextDecoration.lineThrough)),
                    ],
                  ]),
              ]),
          )),
        ]),
      ),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║  15 · EXPLORE SCREEN                                    ║
// ╚══════════════════════════════════════════════════════════╝

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreState();
}

class _ExploreState extends ConsumerState<ExploreScreen> {
  final _sc = TextEditingController();

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final products = ref.watch(filteredProductsProvider);
    final filter   = ref.watch(filterProvider);

    return Scaffold(
      backgroundColor: C.canvas,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          pinned: true, floating: true,
          backgroundColor: C.white,
          automaticallyImplyLeading: false,
          title: Text('Explore',
            style: GoogleFonts.cormorantGaramond(
                fontSize: 22, fontWeight: FontWeight.w700, color: C.ink)),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.sort_rounded),
              onSelected: (v) => ref.read(filterProvider.notifier)
                  .update((s) => s.copyWith(sortBy: v)),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'popularity',
                    child: Text('Popularity')),
                PopupMenuItem(value: 'price_low',
                    child: Text('Price: Low to High')),
                PopupMenuItem(value: 'price_high',
                    child: Text('Price: High to Low')),
                PopupMenuItem(value: 'newest',
                    child: Text('Newest First')),
                PopupMenuItem(value: 'rating',
                    child: Text('Top Rated')),
              ]),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: C.n100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: C.border)),
                  child: TextField(
                    controller: _sc,
                    onChanged: (q) => ref.read(filterProvider.notifier)
                        .update((s) => s.copyWith(
                            search: q.isEmpty ? null : q)),
                    style: GoogleFonts.dmSans(fontSize: 14, color: C.ink),
                    decoration: InputDecoration(
                      hintText: 'Search brands, styles...',
                      hintStyle: GoogleFonts.dmSans(
                          fontSize: 14, color: C.n400),
                      prefixIcon: const Icon(Icons.search_rounded,
                          color: C.n400, size: 20),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 13),
                      suffixIcon: _sc.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  size: 18, color: C.n400),
                              onPressed: () {
                                _sc.clear();
                                ref.read(filterProvider.notifier).update(
                                    (s) => s.copyWith(clearSearch: true));
                                setState(() {});
                              })
                          : null,
                    )),
                )),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _showFilters(ctx),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: filter.hasFilters ? C.ink : C.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: filter.hasFilters ? C.ink : C.border)),
                    child: Icon(Icons.tune_rounded,
                      color: filter.hasFilters ? C.white : C.n700,
                      size: 21)),
                ),
              ]),
            ),
          ),
        ),

        // Category chips
        SliverToBoxAdapter(child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          physics: const BouncingScrollPhysics(),
          child: Row(children: [
            _CatChip('All', filter.category == null,
              () => ref.read(filterProvider.notifier).update(
                  (s) => s.copyWith(clearCategory: true))),
            ..._cats.map((c) => _CatChip(c, filter.category == c,
              () => ref.read(filterProvider.notifier).update(
                  (s) => s.copyWith(category: c)))),
          ]),
        )),

        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text('${products.length} items',
            style: GoogleFonts.dmSans(fontSize: 12, color: C.n500)),
        )),

        products.isEmpty
            ? SliverFillRemaining(child: EmptyView(
                icon: Icons.search_off_rounded,
                title: 'No results found',
                desc: 'Try adjusting your search or filters',
                btnLabel: 'Clear Filters',
                onBtn: () => ref.read(filterProvider.notifier)
                    .update((_) => const PFilter())))
            : SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (c, i) => RepaintBoundary(
                        child: _ProdCard(products[i])),
                    childCount: products.length),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.72,
                    crossAxisSpacing: 12, mainAxisSpacing: 12),
                )),
      ]),
    );
  }

  static const _cats = ['Men', 'Women', 'Kids', 'Accessories'];

  void _showFilters(BuildContext ctx) => showModalBottomSheet(
    context: ctx, isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _FilterSheet());
}

class _CatChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CatChip(this.label, this.selected, this.onTap);

  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? C.ink : C.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? C.ink : C.border),
      ),
      child: Text(label,
        style: GoogleFonts.dmSans(
            fontSize: 13, fontWeight: FontWeight.w500,
            color: selected ? C.white : C.n700))),
  );
}

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet();

  @override
  ConsumerState<_FilterSheet> createState() => _FSState();
}

class _FSState extends ConsumerState<_FilterSheet> {
  late PFilter _f;

  @override
  void initState() {
    super.initState();
    _f = ref.read(filterProvider);
  }

  void _toggleSize(String s) => setState(() => _f = _f.copyWith(
      sizes: _f.sizes.contains(s)
          ? _f.sizes.where((x) => x != s).toList()
          : [..._f.sizes, s]));

  @override
  Widget build(BuildContext ctx) => Container(
    decoration: const BoxDecoration(
      color: C.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
    child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, children: [
        Center(child: Container(width: 36, height: 4,
          decoration: BoxDecoration(
              color: C.n200, borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Filters', style: GoogleFonts.cormorantGaramond(
              fontSize: 24, fontWeight: FontWeight.w700)),
          TextButton(
            onPressed: () => setState(() => _f = const PFilter()),
            child: Text('Clear All',
              style: GoogleFonts.dmSans(color: C.gold, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 20),

        Text('Sizes', style: GoogleFonts.dmSans(
            fontSize: 13, fontWeight: FontWeight.w600, color: C.n700,
            letterSpacing: 0.3)),
        const SizedBox(height: 10),
        Wrap(spacing: 10, runSpacing: 10,
          children: ['XS','S','M','L','XL','XXL'].map((s) => GestureDetector(
            onTap: () => _toggleSize(s),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: _f.sizes.contains(s) ? C.ink : C.white,
                shape: BoxShape.circle,
                border: Border.all(
                    color: _f.sizes.contains(s) ? C.ink : C.n300)),
              child: Center(child: Text(s,
                style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w600,
                    color: _f.sizes.contains(s) ? C.white : C.ink)))),
          )).toList()),
        const SizedBox(height: 20),

        Text('Price Range', style: GoogleFonts.dmSans(
            fontSize: 13, fontWeight: FontWeight.w600, color: C.n700,
            letterSpacing: 0.3)),
        RangeSlider(
          values: RangeValues(_f.minPrice ?? 0, _f.maxPrice ?? 500),
          min: 0, max: 500,
          activeColor: C.ink, inactiveColor: C.n200,
          onChanged: (v) => setState(() =>
              _f = _f.copyWith(minPrice: v.start, maxPrice: v.end))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('\$${(_f.minPrice ?? 0).toInt()}',
            style: GoogleFonts.dmSans(fontSize: 13, color: C.n600)),
          Text('\$${(_f.maxPrice ?? 500).toInt()}',
            style: GoogleFonts.dmSans(fontSize: 13, color: C.n600)),
        ]),
        const SizedBox(height: 24),
        Btn(text: 'Apply Filters', onPressed: () {
          ref.read(filterProvider.notifier).state = _f;
          Navigator.pop(ctx);
        }),
      ])),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  16 · PRODUCT DETAIL SCREEN                             ║
// ╚══════════════════════════════════════════════════════════╝

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductDetailScreen({super.key, this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() => _PDState();
}

class _PDState extends ConsumerState<ProductDetailScreen> {
  int _imgIdx = 0;
  String? _selSize;
  String? _selColor;
  late PageController _pc;

  @override
  void initState() {
    super.initState();
    _pc = PageController();
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final p = widget.product;
    if (p == null) return const Scaffold(
        body: Center(child: Text('Product not found')));
    final inWish = ref.watch(inWishlistProvider(p.id));
    final size   = MediaQuery.of(ctx).size;

    return Scaffold(
      backgroundColor: C.white,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.52,
            pinned: true, backgroundColor: C.white,
            leading: GestureDetector(
              onTap: () => ctx.pop(),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: C.white.withOpacity(0.92),
                  shape: BoxShape.circle,
                  boxShadow: const [BoxShadow(
                      color: C.shadowMd, blurRadius: 8)]),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 17, color: C.ink))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: _WishBtn(
                  isWished: inWish,
                  onTap: () {
                    ref.read(wishlistProvider.notifier).toggle(p);
                    HapticFeedback.lightImpact();
                    snack(ctx,
                      inWish ? 'Removed from wishlist' : 'Added to wishlist',
                      action: inWish ? null : 'View',
                      onAction: inWish ? null : () => ctx.go('/wishlist'));
                  },
                  size: 19,
                  shadow: true,
                )),
              const SizedBox(width: 4),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: [
                PageView.builder(
                  controller: _pc, itemCount: p.images.length,
                  onPageChanged: (i) => setState(() => _imgIdx = i),
                  itemBuilder: (_, i) => Container(
                    color: C.n50,
                    child: p.images[i].startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: p.images[i],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: size.height * 0.52,
                          placeholder: (c, u) => Shimmer.fromColors(
                            baseColor: C.n200, highlightColor: C.n100,
                            child: Container(color: C.n200)),
                          errorWidget: (c, u, e) => Container(
                            color: C.n100,
                            child: const Icon(
                                Icons.image_outlined, size: 48, color: C.n300)))
                      : Image.asset(p.images[i], fit: BoxFit.cover, width: double.infinity, height: size.height * 0.52))),
                ),
                // Image counter
                Positioned(bottom: 14, left: 0, right: 0,
                  child: Center(child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)),
                    child: Text('${_imgIdx + 1}/${p.images.length}',
                      style: GoogleFonts.dmSans(
                          color: C.white, fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  ))),
              ]),
            ),
          ),

          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Brand
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: C.n100,
                    borderRadius: BorderRadius.circular(4)),
                  child: Text(p.brand.toUpperCase(),
                    style: GoogleFonts.dmSans(
                        fontSize: 10, fontWeight: FontWeight.w700,
                        color: C.n600, letterSpacing: 1.2))),
                Stars(rating: p.rating, count: p.reviewCount, sz: 13),
              ]),
              const SizedBox(height: 10),

              // Name
              Text(p.name,
                style: GoogleFonts.cormorantGaramond(
                    fontSize: 26, fontWeight: FontWeight.w700,
                    color: C.ink, height: 1.2)),
              const SizedBox(height: 12),

              // Price row
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text('\$${p.price.toStringAsFixed(2)}',
                  style: GoogleFonts.dmSans(
                      fontSize: 24, fontWeight: FontWeight.w700, color: C.ink)),
                if (p.hasDiscount) ...[
                  const SizedBox(width: 10),
                  Text('\$${p.originalPrice!.toStringAsFixed(2)}',
                    style: GoogleFonts.dmSans(
                        fontSize: 14, color: C.n400,
                        decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 8),
                  SaleBadge(pct: p.discount),
                ],
                const Spacer(),
                if (p.soldCount > 0)
                  Text('${p.soldCount}+ sold',
                    style: GoogleFonts.dmSans(
                        fontSize: 12, color: C.n500)),
              ]),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 18),

              // Size
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Size',
                    style: GoogleFonts.dmSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                  Text('Size Guide',
                    style: GoogleFonts.dmSans(
                        fontSize: 12, color: C.gold,
                        fontWeight: FontWeight.w600)),
                ]),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10,
                children: p.sizes.map((s) => GestureDetector(
                  onTap: () => setState(() => _selSize = s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 46, height: 46,
                    decoration: BoxDecoration(
                      color: _selSize == s ? C.ink : C.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _selSize == s ? C.ink : C.n300,
                          width: _selSize == s ? 2 : 1)),
                    child: Center(child: Text(s,
                      style: GoogleFonts.dmSans(
                          fontSize: 12, fontWeight: FontWeight.w600,
                          color: _selSize == s ? C.white : C.n700)))),
                )).toList()),
              const SizedBox(height: 20),

              // Color
              Text('Colour',
                style: GoogleFonts.dmSans(
                    fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Wrap(spacing: 12, runSpacing: 10,
                children: p.colors.map((c) {
                  final col = _colorMap[c] ?? C.n400;
                  final sel = _selColor == c;
                  final isLight = col.computeLuminance() > 0.75;
                  return GestureDetector(
                    onTap: () => setState(() => _selColor = c),
                    child: Tooltip(message: c, child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 34, height: 34,
                      decoration: BoxDecoration(
                        color: col,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: sel ? C.gold
                              : (isLight ? C.n300 : Colors.transparent),
                          width: sel ? 2.5 : 1),
                        boxShadow: sel
                            ? [BoxShadow(
                                color: C.gold.withOpacity(0.4),
                                blurRadius: 8, spreadRadius: 1)]
                            : [],
                      ),
                      child: sel ? Icon(Icons.check_rounded,
                          color: isLight ? C.ink : C.white, size: 16)
                          : null)),
                  );
                }).toList()),
              const SizedBox(height: 22),
              const Divider(),
              const SizedBox(height: 18),

              // Description
              Text('Description',
                style: GoogleFonts.dmSans(
                    fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(p.description,
                style: GoogleFonts.dmSans(
                    fontSize: 14, color: C.n600, height: 1.7)),
              const SizedBox(height: 20),

              // Details
              if (p.details.isNotEmpty) ...[
                Text('Product Details',
                  style: GoogleFonts.dmSans(
                      fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: C.n50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: C.border)),
                  child: Column(
                    children: p.details.entries.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(children: [
                        SizedBox(width: 90, child: Text(e.key,
                          style: GoogleFonts.dmSans(
                              fontSize: 12, fontWeight: FontWeight.w600,
                              color: C.n500))),
                        Expanded(child: Text(e.value,
                          style: GoogleFonts.dmSans(
                              fontSize: 12, color: C.ink))),
                      ]),
                    )).toList())),
                const SizedBox(height: 20),
              ],

              // Try-On Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: C.goldLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: C.gold.withOpacity(0.3))),
                child: Row(children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: C.gold, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt_rounded,
                        color: C.white, size: 22)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Virtual Try-On',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            color: C.ink, fontSize: 14)),
                      Text('See how it looks on you',
                        style: GoogleFonts.dmSans(
                            color: C.goldDark, fontSize: 12)),
                    ])),
                  ElevatedButton(
                    onPressed: () => ctx.push('/try-on', extra: p),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: C.gold,
                      foregroundColor: C.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      elevation: 0),
                    child: Text('Try It',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700, fontSize: 12))),
                ]),
              ),
            ]),
          )),
        ]),

        // ── Bottom CTA ─────────────────────────────────────
        Positioned(bottom: 0, left: 0, right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: C.white,
              border: const Border(top: BorderSide(color: C.border)),
              boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12, offset: const Offset(0, -4))],
            ),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: SafeArea(child: Row(children: [
              Expanded(child: SizedBox(height: 50, child: OutlinedButton(
                onPressed: () {
                  if (_selSize == null) {
                    snack(context, 'Please select a size', err: true);
                    return;
                  }
                  ref.read(cartProvider.notifier).add(
                      p, _selSize!, _selColor ?? p.colors.first);
                  snack(context, 'Added to cart',
                      action: 'View Cart',
                      onAction: () => context.go('/cart'));
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
                child: Text('Add to Cart',
                  style: GoogleFonts.dmSans(
                      fontSize: 13, fontWeight: FontWeight.w600,
                      color: C.ink)),
              ))),
              const SizedBox(width: 12),
              Expanded(child: SizedBox(height: 50, child: ElevatedButton(
                onPressed: () {
                  if (_selSize == null) {
                    snack(context, 'Please select a size', err: true);
                    return;
                  }
                  ref.read(cartProvider.notifier).add(
                      p, _selSize!, _selColor ?? p.colors.first);
                  ctx.push('/checkout');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: C.gold,
                  foregroundColor: C.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  elevation: 0),
                child: Text('Buy Now',
                  style: GoogleFonts.dmSans(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              ))),
            ])),
          )),
      ]),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║  17 · CART SCREEN                                       ║
// ╚══════════════════════════════════════════════════════════╝

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartState();
}

class _CartState extends ConsumerState<CartScreen> {
  final _promoCtrl = TextEditingController();
  double _discount = 0;

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final items    = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final sub  = notifier.subtotal;
    final ship = notifier.shipping;
    final tot  = sub - _discount + ship;

    if (items.isEmpty) return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: const Text('My Cart'),
        automaticallyImplyLeading: false),
      body: EmptyView(
        icon: Icons.shopping_bag_outlined,
        title: 'Your cart is empty',
        desc: "Browse our collection and add items you love.",
        btnLabel: 'Start Shopping',
        onBtn: () => ctx.go('/explore')));

    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: Text('My Cart (${items.length})',
          style: GoogleFonts.cormorantGaramond(
              fontSize: 20, fontWeight: FontWeight.w700, color: C.ink)),
        backgroundColor: C.white,
        automaticallyImplyLeading: false,
        actions: [TextButton(
          onPressed: () {
            ref.read(cartProvider.notifier).clear();
            setState(() => _discount = 0);
          },
          child: Text('Clear All',
            style: GoogleFonts.dmSans(color: C.error, fontSize: 13))),
        ]),
      body: Column(children: [
        Expanded(child: ListView.separated(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final item = items[i];
            return _CartTile(item,
              onRemove: () =>
                  ref.read(cartProvider.notifier).remove(item.id),
              onQtyChange: (q) =>
                  ref.read(cartProvider.notifier).updateQty(item.id, q));
          })),

        // ── Order summary ─────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            color: C.white,
            border: const Border(top: BorderSide(color: C.border)),
            boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12, offset: const Offset(0, -4))],
          ),
          child: Column(children: [
            // Promo code
            Row(children: [
              Expanded(child: TextField(
                controller: _promoCtrl,
                style: GoogleFonts.dmSans(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Promo code',
                  hintStyle: GoogleFonts.dmSans(
                      color: C.n400, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: C.border)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: C.border)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                          color: C.ink, width: 1.5))),
              )),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (_promoCtrl.text == 'NOIR20') {
                    setState(() => _discount = sub * 0.2);
                    snack(ctx, '20% discount applied!');
                  } else {
                    snack(ctx, 'Invalid promo code', err: true);
                  }
                },
                child: const Text('Apply')),
            ]),
            const SizedBox(height: 16),
            _SumRow('Subtotal', '\$${sub.toStringAsFixed(2)}'),
            if (_discount > 0)
              _SumRow('Discount (NOIR20)',
                  '-\$${_discount.toStringAsFixed(2)}',
                  valueColor: C.success),
            _SumRow('Shipping',
                ship == 0 ? 'FREE' : '\$${ship.toStringAsFixed(2)}',
                valueColor: ship == 0 ? C.success : null),
            const Divider(height: 20),
            _SumRow('Total', '\$${tot.toStringAsFixed(2)}', bold: true),
            const SizedBox(height: 14),
            SafeArea(child: Btn(
                text: 'Proceed to Checkout',
                onPressed: () => ctx.push('/checkout'))),
            const SizedBox(height: 8),
          ])),
      ]),
    );
  }
}

Widget _SumRow(String label, String val,
    {Color? valueColor, bool bold = false}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: GoogleFonts.dmSans(
            fontSize: 14, color: C.n600,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400)),
        Text(val, style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? C.ink)),
      ]),
    );

class _CartTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQtyChange;

  const _CartTile(this.item,
      {required this.onRemove, required this.onQtyChange});

  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: C.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: C.border),
      boxShadow: const [BoxShadow(
          color: C.shadow, blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: Row(children: [
      ClipRRect(borderRadius: BorderRadius.circular(6),
        child: Img(item.product.images.first, w: 80, h: 90)),
      const SizedBox(width: 12),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(item.product.brand,
          style: GoogleFonts.dmSans(
              fontSize: 10, color: C.n400, letterSpacing: 0.3)),
        Text(item.product.name,
          style: GoogleFonts.dmSans(
              fontSize: 13, fontWeight: FontWeight.w600, color: C.ink),
          maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text('${item.selectedSize} · ${item.selectedColor}',
          style: GoogleFonts.dmSans(fontSize: 11, color: C.n500)),
        const SizedBox(height: 6),
        Text('\$${item.product.price.toStringAsFixed(2)}',
          style: GoogleFonts.dmSans(
              fontSize: 15, fontWeight: FontWeight.w700, color: C.ink)),
      ])),
      Column(children: [
        IconButton(
          icon: const Icon(Icons.delete_outline_rounded,
              color: C.n300, size: 19),
          onPressed: onRemove,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints()),
        const SizedBox(height: 8),
        Row(children: [
          _QBtn(Icons.remove, () => onQtyChange(item.quantity - 1)),
          SizedBox(width: 32, child: Text('${item.quantity}',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700, fontSize: 14))),
          _QBtn(Icons.add, () => onQtyChange(item.quantity + 1)),
        ]),
      ]),
    ]),
  );
}

class _QBtn extends StatelessWidget {
  final IconData ic;
  final VoidCallback onTap;
  const _QBtn(this.ic, this.onTap);

  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 28, height: 28,
      decoration: BoxDecoration(
          color: C.n100, borderRadius: BorderRadius.circular(4)),
      child: Icon(ic, size: 16, color: C.ink)));
}

// ╔══════════════════════════════════════════════════════════╗
// ║  18 · WISHLIST                                          ║
// ╚══════════════════════════════════════════════════════════╝

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final items = ref.watch(wishlistProvider);
    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: Text('Saved (${items.length})',
          style: GoogleFonts.cormorantGaramond(
              fontSize: 20, fontWeight: FontWeight.w700)),
        backgroundColor: C.white,
        automaticallyImplyLeading: false),
      body: items.isEmpty
          ? EmptyView(
              icon: Icons.favorite_border_rounded,
              title: 'Nothing saved yet',
              desc: 'Tap ♡ on any item to save it here.',
              btnLabel: 'Explore Now',
              onBtn: () => ctx.go('/explore'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.72,
                crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: items.length,
              itemBuilder: (_, i) =>
                  RepaintBoundary(child: _ProdCard(items[i]))),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║  19 · CHECKOUT SCREEN                                   ║
// ╚══════════════════════════════════════════════════════════╝

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _COState();
}

class _COState extends ConsumerState<CheckoutScreen> {
  int _step = 0, _payment = 0;
  bool _placing = false;
  static const _payments = ['Card Payment', 'Cash on Delivery'];

  @override
  Widget build(BuildContext ctx) {
    final user  = ref.watch(authProvider).valueOrNull;
    final items = ref.watch(cartProvider);
    final sub   = ref.read(cartProvider.notifier).subtotal;
    final ship  = ref.read(cartProvider.notifier).shipping;
    final tot   = sub + ship;
    final addr  = user?.defaultAddress;

    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: Text('Checkout',
          style: GoogleFonts.cormorantGaramond(
              fontSize: 20, fontWeight: FontWeight.w700)),
        backgroundColor: C.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => ctx.pop())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Stepper
          Row(children: ['Address', 'Payment', 'Review']
              .asMap().entries.map((e) => Expanded(child: Row(children: [
            Expanded(child: Column(children: [
              Container(width: 28, height: 28,
                decoration: BoxDecoration(
                  color: _step >= e.key ? C.ink : C.n200,
                  shape: BoxShape.circle),
                child: Center(child: _step > e.key
                    ? const Icon(Icons.check, color: C.white, size: 14)
                    : Text('${e.key + 1}',
                        style: TextStyle(
                            color: _step >= e.key ? C.white : C.n500,
                            fontSize: 12, fontWeight: FontWeight.w700)))),
              const SizedBox(height: 4),
              Text(e.value,
                style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: _step >= e.key ? C.ink : C.n400,
                    fontWeight: FontWeight.w500)),
            ])),
            if (e.key < 2) Expanded(child: Container(
              height: 1.5,
              color: _step > e.key ? C.ink : C.n200)),
          ]))).toList()),
          const SizedBox(height: 28),

          if (_step == 0) ..._addressStep(addr),
          if (_step == 1) ..._paymentStep(ctx),
          if (_step == 2) ..._reviewStep(ctx, items, sub, ship, tot, addr),
        ])),
    );
  }

  List<Widget> _addressStep(Address? addr) => [
    Text('Delivery Address',
      style: GoogleFonts.cormorantGaramond(
          fontSize: 22, fontWeight: FontWeight.w700)),
    const SizedBox(height: 14),
    if (addr != null) Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: C.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: C.gold, width: 1.5),
        boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: C.goldLight, shape: BoxShape.circle),
          child: const Icon(Icons.location_on_outlined,
              color: C.gold, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(addr.name,
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 2),
          Text(addr.full,
            style: GoogleFonts.dmSans(
                fontSize: 12, color: C.n600, height: 1.5)),
          Text(addr.phone,
            style: GoogleFonts.dmSans(fontSize: 12, color: C.n500)),
        ])),
        const Icon(Icons.check_circle_rounded, color: C.gold),
      ])),
    const SizedBox(height: 28),
    Btn(text: 'Continue to Payment',
        onPressed: () => setState(() => _step = 1)),
  ];

  List<Widget> _paymentStep(BuildContext ctx) => [
    Text('Payment Method',
      style: GoogleFonts.cormorantGaramond(
          fontSize: 22, fontWeight: FontWeight.w700)),
    const SizedBox(height: 14),
    ..._payments.asMap().entries.map((e) => GestureDetector(
      onTap: () => setState(() => _payment = e.key),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: _payment == e.key ? C.gold : C.border,
              width: _payment == e.key ? 1.5 : 1),
          boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
        child: Row(children: [
          Icon(
            _payment == e.key
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_unchecked_rounded,
            color: _payment == e.key ? C.gold : C.n400),
          const SizedBox(width: 12),
          Icon(e.key == 0
              ? Icons.credit_card_rounded
              : Icons.local_shipping_outlined, color: C.n700),
          const SizedBox(width: 10),
          Text(e.value, style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500, fontSize: 14)),
        ])))),
    const SizedBox(height: 4),
    Row(children: [
      Expanded(child: OutBtn(text: 'Back',
          onPressed: () => setState(() => _step = 0))),
      const SizedBox(width: 12),
      Expanded(flex: 2, child: Btn(text: 'Review Order',
          onPressed: () => setState(() => _step = 2))),
    ]),
  ];

  List<Widget> _reviewStep(BuildContext ctx, List<CartItem> items,
      double sub, double ship, double tot, Address? addr) => [
    Text('Order Summary',
      style: GoogleFonts.cormorantGaramond(
          fontSize: 22, fontWeight: FontWeight.w700)),
    const SizedBox(height: 14),
    ...items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: C.border),
          boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
        child: Row(children: [
          ClipRRect(borderRadius: BorderRadius.circular(6),
            child: Img(item.product.images.first, w: 56, h: 64)),
          const SizedBox(width: 10),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.product.name,
              style: GoogleFonts.dmSans(
                  fontSize: 13, fontWeight: FontWeight.w600),
              maxLines: 1, overflow: TextOverflow.ellipsis),
            Text('${item.selectedSize} × ${item.quantity}',
              style: GoogleFonts.dmSans(
                  fontSize: 12, color: C.n500)),
          ])),
          Text('\$${item.total.toStringAsFixed(2)}',
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700, fontSize: 14)),
        ])))),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: C.white, borderRadius: BorderRadius.circular(8),
        border: Border.all(color: C.border),
        boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
      child: Column(children: [
        _SumRow('Subtotal', '\$${sub.toStringAsFixed(2)}'),
        _SumRow('Shipping',
            ship == 0 ? 'FREE' : '\$${ship.toStringAsFixed(2)}',
            valueColor: ship == 0 ? C.success : null),
        const Divider(height: 16),
        _SumRow('Total', '\$${tot.toStringAsFixed(2)}', bold: true),
      ])),
    const SizedBox(height: 20),
    Row(children: [
      Expanded(child: OutBtn(text: 'Back',
          onPressed: () => setState(() => _step = 1))),
      const SizedBox(width: 12),
      Expanded(flex: 2, child: Btn(
        text: 'Place Order', loading: _placing,
        bg: C.gold,
        onPressed: () async {
          setState(() => _placing = true);
          if (addr == null) {
            setState(() => _placing = false);
            return;
          }
          final order = await ref.read(ordersProvider.notifier).place(
              items: items, address: addr,
              payment: _payments[_payment]);
          ref.read(cartProvider.notifier).clear();
          setState(() => _placing = false);
          if (mounted) ctx.pushReplacement('/order-success', extra: order);
        })),
    ]),
  ];
}

// ╔══════════════════════════════════════════════════════════╗
// ║  20 · ORDER SUCCESS                                     ║
// ╚══════════════════════════════════════════════════════════╝

class OrderSuccessScreen extends StatelessWidget {
  final AppOrder order;
  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: C.white,
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 96, height: 96,
          decoration: const BoxDecoration(
              color: Color(0xFFF0FDF4), shape: BoxShape.circle),
          child: const Icon(Icons.check_rounded, color: C.success, size: 52))
            .animate().scale(delay: 200.ms, duration: 600.ms,
            curve: Curves.elasticOut),
        const SizedBox(height: 24),
        Text('Order Placed!',
          style: GoogleFonts.cormorantGaramond(
              fontSize: 32, fontWeight: FontWeight.w700, color: C.ink))
            .animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 8),
        Text('${order.orderNumber} has been confirmed.',
          style: GoogleFonts.dmSans(
              fontSize: 14, color: C.n600, height: 1.5),
          textAlign: TextAlign.center).animate().fadeIn(delay: 500.ms),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: C.n50, borderRadius: BorderRadius.circular(8),
            border: Border.all(color: C.border)),
          child: Column(children: [
            _SumRow('Order', order.orderNumber),
            _SumRow('Payment', order.paymentMethod),
            _SumRow('Est. Delivery',
              '${order.estimatedDelivery?.day}/${order.estimatedDelivery?.month}/${order.estimatedDelivery?.year}'),
            const Divider(height: 16),
            _SumRow('Total',
              '\$${order.total.toStringAsFixed(2)}', bold: true),
          ])).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 32),
        Btn(text: 'Track My Order',
            onPressed: () => ctx.pushReplacement('/orders'))
          .animate().fadeIn(delay: 700.ms),
        const SizedBox(height: 12),
        OutBtn(text: 'Continue Shopping',
            onPressed: () => ctx.go('/'))
          .animate().fadeIn(delay: 800.ms),
      ]))),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  21 · ORDERS SCREEN                                     ║
// ╚══════════════════════════════════════════════════════════╝

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: C.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => ctx.pop())),
      body: orders.isEmpty
          ? const EmptyView(
              icon: Icons.receipt_long_outlined,
              title: 'No orders yet',
              desc: 'Your order history will appear here.')
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _OrderCard(orders[i])),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final AppOrder o;
  const _OrderCard(this.o);

  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: C.white, borderRadius: BorderRadius.circular(8),
      border: Border.all(color: C.border),
      boxShadow: const [BoxShadow(
          color: C.shadowMd, blurRadius: 8, offset: Offset(0, 3))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(o.orderNumber,
          style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700, fontSize: 14, color: C.ink)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: o.status.color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20)),
          child: Text(o.status.label,
            style: GoogleFonts.dmSans(
                fontSize: 11, fontWeight: FontWeight.w600,
                color: o.status.color))),
      ]),
      const SizedBox(height: 6),
      Text('${o.createdAt.day}/${o.createdAt.month}/${o.createdAt.year}',
        style: GoogleFonts.dmSans(fontSize: 12, color: C.n500)),
      const SizedBox(height: 14),
      if (o.status != OrderStatus.cancelled) ...[
        Row(children: List.generate(4, (i) {
          final active = o.status.step >= i;
          return Expanded(child: Row(children: [
            Container(width: 20, height: 20,
              decoration: BoxDecoration(
                color: active ? C.ink : C.n200,
                shape: BoxShape.circle),
              child: Center(child: Icon(Icons.check,
                  size: 12, color: active ? C.white : C.n400))),
            if (i < 3) Expanded(child: Container(
              height: 2,
              color: active && o.status.step > i ? C.ink : C.n200)),
          ]));
        })),
        const SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Placed','Processing','Shipped','Delivered']
              .map((s) => Text(s,
                style: GoogleFonts.dmSans(
                    fontSize: 9, color: C.n400))).toList()),
        const SizedBox(height: 14),
      ],
      const Divider(),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Total', style: GoogleFonts.dmSans(
            fontSize: 14, color: C.n600)),
        Text('\$${o.total.toStringAsFixed(2)}',
          style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700, fontSize: 16, color: C.ink)),
      ]),
    ]),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║  22 · PROFILE SCREEN                                    ║
// ╚══════════════════════════════════════════════════════════╝

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: C.white,
        automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          // Profile card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: C.ink, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(
                width: 58, height: 58,
                decoration: BoxDecoration(
                  color: C.gold, shape: BoxShape.circle),
                child: Center(child: Text(
                  user?.name.isNotEmpty == true
                      ? user!.name[0].toUpperCase() : '?',
                  style: GoogleFonts.cormorantGaramond(
                      fontSize: 28, fontWeight: FontWeight.w700,
                      color: C.white)))),
              const SizedBox(width: 16),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(user?.name ?? 'Guest',
                  style: GoogleFonts.cormorantGaramond(
                      fontWeight: FontWeight.w700, fontSize: 20,
                      color: C.white)),
                Text(user?.email ?? '',
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6))),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: C.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: C.gold.withOpacity(0.4))),
                  child: Text('NOIR Member',
                    style: GoogleFonts.dmSans(
                        color: C.gold, fontSize: 11,
                        fontWeight: FontWeight.w600))),
              ])),
            ])),
          const SizedBox(height: 14),

          // Stats
          Row(children: [
            _StatCard('Orders',
                ref.watch(ordersProvider).length.toString(),
                Icons.receipt_long_outlined),
            const SizedBox(width: 12),
            _StatCard('Saved',
                ref.watch(wishlistProvider).length.toString(),
                Icons.favorite_border_rounded),
            const SizedBox(width: 12),
            const _StatCard('Points', '1,240', Icons.star_border_rounded),
          ]),
          const SizedBox(height: 16),

          _MenuSection('Shopping', [
            _MenuItem(Icons.receipt_long_outlined, 'My Orders',
                () => ctx.push('/orders')),
            _MenuItem(Icons.favorite_border_rounded, 'Saved Items',
                () => ctx.go('/wishlist')),
            _MenuItem(Icons.location_on_outlined, 'Addresses', () {}),
            _MenuItem(Icons.local_offer_outlined, 'Promo Codes', () {}),
          ]),
          const SizedBox(height: 14),
          _MenuSection('Features', [
            _MenuItem(Icons.camera_alt_outlined, 'Virtual Try-On',
                () => ctx.push('/try-on')),
            _MenuItem(Icons.qr_code_scanner_rounded, 'Rack Scanner',
                () => ctx.push('/qr-scanner')),
          ]),
          const SizedBox(height: 14),
          _MenuSection('Account', [
            _MenuItem(Icons.notifications_none_rounded,
                'Notifications', () {}),
            _MenuItem(Icons.help_outline_rounded, 'Help & Support', () {}),
            _MenuItem(Icons.info_outline_rounded, 'About NOIR', () {}),
          ]),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: C.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: C.border),
              boxShadow: const [BoxShadow(
                  color: C.shadow, blurRadius: 6)]),
            child: ListTile(
              leading: const Icon(Icons.logout_rounded, color: C.error),
              title: Text('Sign Out',
                style: GoogleFonts.dmSans(
                    color: C.error, fontWeight: FontWeight.w600)),
              onTap: () => ref.read(authProvider.notifier).signOut())),
          const SizedBox(height: 32),
        ])),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, val;
  final IconData ic;
  const _StatCard(this.label, this.val, this.ic);

  @override
  Widget build(BuildContext ctx) => Expanded(child: Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: C.white, borderRadius: BorderRadius.circular(8),
      border: Border.all(color: C.border),
      boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
    child: Column(children: [
      Icon(ic, color: C.gold, size: 22),
      const SizedBox(height: 6),
      Text(val, style: GoogleFonts.cormorantGaramond(
          fontWeight: FontWeight.w700, fontSize: 20, color: C.ink)),
      Text(label, style: GoogleFonts.dmSans(
          fontSize: 11, color: C.n500)),
    ])));
}

Widget _MenuSection(String title, List<Widget> items) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  Padding(padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(title.toUpperCase(),
      style: GoogleFonts.dmSans(
          fontSize: 10, fontWeight: FontWeight.w600,
          color: C.n400, letterSpacing: 1))),
  Container(
    decoration: BoxDecoration(
      color: C.white, borderRadius: BorderRadius.circular(8),
      border: Border.all(color: C.border),
      boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
    child: Column(children: items.asMap().entries.map((e) =>
        Column(children: [
          e.value,
          if (e.key < items.length - 1)
            const Divider(height: 1, indent: 52),
        ])).toList())),
]);

class _MenuItem extends StatelessWidget {
  final IconData ic;
  final String label;
  final VoidCallback onTap;
  const _MenuItem(this.ic, this.label, this.onTap);

  @override
  Widget build(BuildContext ctx) => ListTile(
    leading: Container(
      width: 34, height: 34,
      decoration: BoxDecoration(
          color: C.goldLight, borderRadius: BorderRadius.circular(8)),
      child: Icon(ic, color: C.gold, size: 18)),
    title: Text(label,
      style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500)),
    trailing: const Icon(Icons.chevron_right_rounded, color: C.n300, size: 20),
    onTap: onTap);
}

// ╔══════════════════════════════════════════════════════════╗
// ║  23 · VIRTUAL TRY-ON                                    ║
// ╚══════════════════════════════════════════════════════════╝

class TryOnScreen extends ConsumerStatefulWidget {
  final Product? product;
  const TryOnScreen({super.key, this.product});

  @override
  ConsumerState<TryOnScreen> createState() => _TOState();
}

class _TOState extends ConsumerState<TryOnScreen> {
  bool _captured = false;
  double _scale = 1.0, _ox = 0, _oy = 0, _rot = 0;
  double _startScale = 1.0, _startRot = 0;
  CameraController? _cam;
  List<CameraDescription>? _cameras;
  int _camIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCam();
  }

  Future<void> _initCam() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _camIndex = _cameras!.indexWhere(
            (c) => c.lensDirection == CameraLensDirection.front);
        if (_camIndex == -1) _camIndex = 0;
        _startCamera(_cameras![_camIndex]);
      }
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  Future<void> _startCamera(CameraDescription d) async {
    final c = CameraController(d, ResolutionPreset.high, enableAudio: false);
    await c.initialize();
    if (mounted) setState(() => _cam = c);
  }

  void _flipCam() {
    if (_cameras == null || _cameras!.length < 2) return;
    _camIndex = (_camIndex + 1) % _cameras!.length;
    _cam?.dispose();
    setState(() => _cam = null);
    _startCamera(_cameras![_camIndex]);
  }

  @override
  void dispose() { _cam?.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext ctx) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: C.black,
      body: Stack(children: [
        if (_cam != null && _cam!.value.isInitialized)
          Positioned.fill(child: CameraPreview(_cam!))
        else
          const Positioned.fill(child: Center(
              child: CircularProgressIndicator(color: C.gold))),

        if (p != null)
          Positioned.fill(child: GestureDetector(
            onScaleStart: (d) {
              _startScale = _scale;
              _startRot = _rot;
            },
            onScaleUpdate: (d) => setState(() {
              _scale = (_startScale * d.scale).clamp(0.5, 3.5);
              _rot = _startRot + d.rotation;
              _ox += d.focalPointDelta.dx;
              _oy += d.focalPointDelta.dy;
            }),
            child: Container(color: Colors.transparent,
              child: Center(child: Transform.translate(
                offset: Offset(_ox, _oy),
                child: Transform.scale(scale: _scale,
                  child: Transform.rotate(angle: _rot,
                    child: Img(p.images.first, w: 220,
                        fit: BoxFit.contain)))))),
          )),

        // Top bar
        Positioned(top: 0, left: 0, right: 0,
          child: SafeArea(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              GestureDetector(onTap: () => ctx.pop(),
                child: Container(padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.black54, shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: C.white, size: 20))),
              const SizedBox(width: 12),
              Expanded(child: Text('AR Try-On',
                style: GoogleFonts.dmSans(
                    color: C.white, fontWeight: FontWeight.w700,
                    fontSize: 16))),
              GestureDetector(onTap: _flipCam,
                child: Container(padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.black54, shape: BoxShape.circle),
                  child: const Icon(Icons.cameraswitch_rounded,
                      color: C.white, size: 20))),
            ])))),

        // Hint
        Positioned(top: 100, left: 0, right: 0,
          child: Center(child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
            child: Text('Drag · Pinch to resize · Two-finger rotate',
              style: GoogleFonts.dmSans(
                  color: C.white, fontSize: 11))))),

        if (_captured)
          Positioned.fill(child: Container(color: C.white)),

        // Controls
        Positioned(bottom: 0, left: 0, right: 0,
          child: SafeArea(child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _TBtn(Icons.remove, () {
                  if (_scale > 0.5) setState(() => _scale -= 0.15);
                }, 'Smaller'),
                const SizedBox(width: 24),
                _TBtn(Icons.refresh_rounded, () => setState(() {
                  _scale = 1; _rot = 0; _ox = 0; _oy = 0;
                }), 'Reset'),
                const SizedBox(width: 24),
                _TBtn(Icons.add, () {
                  if (_scale < 3.5) setState(() => _scale += 0.15);
                }, 'Larger'),
              ]),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() => _captured = true);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    if (mounted) setState(() => _captured = false);
                  });
                  snack(ctx, 'Snapshot captured! 📸');
                },
                child: Container(
                  width: 68, height: 68,
                  decoration: BoxDecoration(
                    color: C.white, shape: BoxShape.circle,
                    border: Border.all(color: C.n300, width: 3)),
                  child: const Center(child: Icon(
                      Icons.camera_alt_rounded, color: C.ink, size: 28)))),
            ])))),
      ]),
    );
  }
}

class _TBtn extends StatelessWidget {
  final IconData ic;
  final VoidCallback onTap;
  final String label;
  const _TBtn(this.ic, this.onTap, this.label);

  @override
  Widget build(BuildContext ctx) => Column(mainAxisSize: MainAxisSize.min, children: [
    GestureDetector(onTap: onTap,
      child: Container(padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: Colors.black54, shape: BoxShape.circle),
        child: Icon(ic, color: C.white, size: 22))),
    const SizedBox(height: 4),
    Text(label, style: GoogleFonts.dmSans(color: C.white, fontSize: 10)),
  ]);
}

// ╔══════════════════════════════════════════════════════════╗
// ║  24 · QR SCANNER                                        ║
// ╚══════════════════════════════════════════════════════════╝

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QRState();
}

class _QRState extends ConsumerState<QrScannerScreen>
    with SingleTickerProviderStateMixin {
  bool _scanned = false;
  String? _scannedRack;
  late AnimationController _scanCtrl;
  late Animation<double> _scanAnim;
  final _camCtrl = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _scanCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))..repeat();
    _scanAnim = Tween<double>(begin: 0, end: 1).animate(_scanCtrl);
  }

  @override
  void dispose() {
    _scanCtrl.dispose();
    _camCtrl.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    for (final bc in capture.barcodes) {
      if (bc.rawValue != null) {
        String rackId = bc.rawValue!;
        if (!kRackNames.containsKey(rackId)) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Demo: Using default rack for "$rackId"'),
            backgroundColor: C.gold,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2)));
          rackId = kRackNames.keys.first;
        }
        setState(() { _scanned = true; _scannedRack = rackId; });
        HapticFeedback.heavyImpact();
        return;
      }
    }
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: C.black,
    body: Stack(children: [
      Positioned.fill(child: MobileScanner(
          controller: _camCtrl, onDetect: _onDetect)),

      Positioned.fill(child: CustomPaint(
          painter: _QRPainter(_scanAnim))),

      // Top bar
      Positioned(top: 0, left: 0, right: 0,
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            GestureDetector(onTap: () => ctx.pop(),
              child: Container(padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.black54, shape: BoxShape.circle),
                child: const Icon(Icons.close, color: C.white, size: 20))),
            const SizedBox(width: 12),
            Text('Rack Scanner',
              style: GoogleFonts.dmSans(
                  color: C.white, fontWeight: FontWeight.w700,
                  fontSize: 16)),
          ])))),

      Positioned(top: 110, left: 0, right: 0,
        child: Text(
          'Point camera at the QR code on a clothing rack',
          style: GoogleFonts.dmSans(
              color: Colors.white.withOpacity(0.75), fontSize: 13),
          textAlign: TextAlign.center)),

      // Result overlay
      if (_scanned && _scannedRack != null)
        Positioned.fill(child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.check_circle_rounded, color: C.success, size: 68)
                .animate().scale(duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),
            Text('Rack Found!',
              style: GoogleFonts.cormorantGaramond(
                  color: C.white, fontWeight: FontWeight.w700, fontSize: 24))
                .animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 6),
            Text(kRackNames[_scannedRack]!,
              style: GoogleFonts.dmSans(
                  color: C.gold, fontSize: 16, fontWeight: FontWeight.w600))
                .animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () => ctx.pushReplacement(
                  '/rack/$_scannedRack',
                  extra: kRackNames[_scannedRack]),
              icon: const Icon(Icons.grid_view_rounded),
              label: const Text('View Rack Items'),
              style: ElevatedButton.styleFrom(
                backgroundColor: C.gold,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)))).
              animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () => setState(() {
                _scanned = false; _scannedRack = null;
              }),
              child: Text('Scan Again',
                style: GoogleFonts.dmSans(color: C.white))),
          ])),
        )),
    ]),
  );
}

class _QRPainter extends CustomPainter {
  final Animation<double> anim;
  _QRPainter(this.anim) : super(repaint: anim);

  @override
  void paint(Canvas canvas, Size sz) {
    final cx = sz.width / 2, cy = sz.height / 2;
    const s = 220.0, r = 16.0;

    // Dim overlay
    canvas.drawPath(
      Path.combine(PathOperation.difference,
        Path()..addRect(Offset.zero & sz),
        Path()..addRRect(RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx, cy), width: s, height: s),
          const Radius.circular(r)))),
      Paint()..color = Colors.black.withOpacity(0.65));

    // Corner brackets
    final p = Paint()..color = C.gold..strokeWidth = 3
        ..style = PaintingStyle.stroke;
    const l = s / 2, bl = 26.0;
    for (final c in [
      Offset(cx - l + r, cy - l + r), Offset(cx + l - r, cy - l + r),
      Offset(cx - l + r, cy + l - r), Offset(cx + l - r, cy + l - r),
    ]) {
      final dx = c.dx < cx ? -1.0 : 1.0;
      final dy = c.dy < cy ? -1.0 : 1.0;
      canvas.drawPath(
        Path()
          ..moveTo(c.dx + dx * bl, c.dy)
          ..lineTo(c.dx, c.dy)
          ..lineTo(c.dx, c.dy + dy * bl),
        p);
    }

    // Scan line
    final scanY = cy - l + r + (s - 2 * r) * anim.value;
    canvas.drawLine(
      Offset(cx - l + r + 4, scanY), Offset(cx + l - r - 4, scanY),
      Paint()..color = C.gold..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(_QRPainter o) => true;
}

// ╔══════════════════════════════════════════════════════════╗
// ║  25 · RACK PRODUCTS SCREEN                              ║
// ╚══════════════════════════════════════════════════════════╝

class RackProductsScreen extends ConsumerWidget {
  final String rackId;
  final Object? extra;
  const RackProductsScreen({super.key, required this.rackId, this.extra});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final rackName = extra is String ? extra as String
        : kRackNames[rackId] ?? 'Rack';
    final ids      = kRackMap[rackId] ?? [];
    final products = kProducts.where((p) => ids.contains(p.id)).toList();

    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Rack Items',
            style: GoogleFonts.dmSans(
                fontSize: 16, fontWeight: FontWeight.w700, color: C.ink)),
          Text(rackName,
            style: GoogleFonts.dmSans(
                fontSize: 11, color: C.gold, fontWeight: FontWeight.w500)),
        ]),
        backgroundColor: C.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => ctx.pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded, color: C.gold),
            onPressed: () => ctx.pushReplacement('/qr-scanner')),
        ]),
      body: products.isEmpty
          ? const EmptyView(
              icon: Icons.checkroom_outlined,
              title: 'No items on this rack',
              desc: 'This rack appears to be empty.')
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.72,
                crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: products.length,
              itemBuilder: (_, i) => RepaintBoundary(
                  child: _ProdCard(products[i]))),
    );
  }
}