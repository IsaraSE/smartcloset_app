// ============================================================
//  STYLESPHERE — Redesigned Flutter App (Single File)
//  Clean Professional UI · Blue & White Theme
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
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ╔══════════════════════════════════════════════════════════╗
// ║                  1 · ENTRY POINT                        ║
// ╚══════════════════════════════════════════════════════════╝

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const ProviderScope(child: StyleSphereApp()));
}

// ╔══════════════════════════════════════════════════════════╗
// ║                  2 · COLORS & THEME                     ║
// ╚══════════════════════════════════════════════════════════╝

class C {
  C._();
  // Primary palette — clean blue & white
  static const primary      = Color(0xFF0F172A);   // Dark navy (main text)
  static const blue         = Color(0xFF2563EB);   // Main blue accent
  static const blueDark     = Color(0xFF1E3A8A);   // Dark blue (buy now btn)
  static const blueLight    = Color(0xFFEFF6FF);   // Light blue surface
  static const blueMid      = Color(0xFF3B82F6);   // Medium blue
  static const secondary    = Color(0xFF2563EB);   // Alias for compat
  static const red          = Color(0xFFEF4444);   // Sale badge
  static const white        = Color(0xFFFFFFFF);
  static const black        = Color(0xFF000000);
  static const bg           = Color(0xFFF8FAFC);   // App background
  static const cardBg       = Color(0xFFFFFFFF);   // Card background
  static const g50          = Color(0xFFF8FAFC);
  static const g100         = Color(0xFFF1F5F9);
  static const g200         = Color(0xFFE2E8F0);
  static const g300         = Color(0xFFCBD5E1);
  static const g400         = Color(0xFF94A3B8);
  static const g500         = Color(0xFF64748B);
  static const g600         = Color(0xFF475569);
  static const g700         = Color(0xFF334155);
  static const g800         = Color(0xFF1E293B);
  static const success      = Color(0xFF22C55E);
  static const warning      = Color(0xFFF59E0B);
  static const error        = Color(0xFFEF4444);
  static const shadow       = Color(0x0A000000);
  static const shadowMd     = Color(0x14000000);
  static const divider      = Color(0xFFE2E8F0);

  static const LinearGradient blueGrad = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
  );
  static const LinearGradient heroGrad = LinearGradient(
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC0F172A)],
  );
  static const LinearGradient navyGrad = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
  );
}

ThemeData _buildTheme() {
  TextStyle p(double sz, FontWeight w, Color col, {double ls = 0, double? h}) =>
      GoogleFonts.poppins(fontSize: sz, fontWeight: w, color: col, letterSpacing: ls, height: h);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: C.blue,
      primary: C.blue,
      secondary: C.blueDark,
      surface: C.white,
      error: C.error,
      onPrimary: C.white,
      onSecondary: C.white,
      onSurface: C.primary,
    ),
    scaffoldBackgroundColor: C.bg,
    textTheme: TextTheme(
      displayLarge:   p(32, FontWeight.w800, C.primary, ls: -1),
      displayMedium:  p(26, FontWeight.w700, C.primary),
      displaySmall:   p(22, FontWeight.w700, C.primary),
      headlineLarge:  p(20, FontWeight.w700, C.primary),
      headlineMedium: p(18, FontWeight.w600, C.primary),
      headlineSmall:  p(16, FontWeight.w600, C.primary),
      titleLarge:     p(16, FontWeight.w600, C.primary),
      titleMedium:    p(14, FontWeight.w500, C.primary),
      titleSmall:     p(12, FontWeight.w500, C.g700),
      bodyLarge:      p(16, FontWeight.w400, C.g800),
      bodyMedium:     p(14, FontWeight.w400, C.g700),
      bodySmall:      p(12, FontWeight.w400, C.g500),
      labelLarge:     p(14, FontWeight.w600, C.white, ls: 0.3),
      labelMedium:    p(12, FontWeight.w500, C.g600),
      labelSmall:     p(10, FontWeight.w400, C.g500),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: C.white, elevation: 0,
      scrolledUnderElevation: 0.5,
      iconTheme: const IconThemeData(color: C.primary),
      titleTextStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: C.primary),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: C.blue, foregroundColor: C.white, elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: C.primary,
        side: const BorderSide(color: C.g300, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: C.g100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.g200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.blue, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.error)),
      hintStyle: GoogleFonts.poppins(fontSize: 14, color: C.g400),
      labelStyle: GoogleFonts.poppins(fontSize: 14, color: C.g500),
    ),
    cardTheme: CardThemeData(
      color: C.white, elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: C.primary,
      contentTextStyle: GoogleFonts.poppins(color: C.white, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
    sliderTheme: const SliderThemeData(activeTrackColor: C.blue, thumbColor: C.blue, inactiveTrackColor: C.g200),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: C.blue),
    dividerTheme: const DividerThemeData(color: C.divider, thickness: 1, space: 1),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? C.blue : C.g200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║                  3 · MODELS                             ║
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
  const CartItem({required this.id, required this.product, required this.quantity,
    required this.selectedSize, required this.selectedColor});
  double get total => product.price * quantity;
  CartItem copyWith({int? quantity}) => CartItem(id: id, product: product,
    selectedSize: selectedSize, selectedColor: selectedColor, quantity: quantity ?? this.quantity);
}

class Address {
  final String id, name, phone, line1, city, state, zip, country;
  final String? line2;
  final bool isDefault;
  const Address({required this.id, required this.name, required this.phone,
    required this.line1, this.line2, required this.city,
    required this.state, required this.zip, required this.country, this.isDefault = false});
  String get full => '$line1${line2 != null ? ', $line2' : ''}, $city, $state $zip, $country';
  String get short => '$line1, $city';
}

class AppUser {
  final String id, name, email;
  final String? photoUrl;
  final List<Address> addresses;
  const AppUser({required this.id, required this.name, required this.email,
    this.photoUrl, this.addresses = const []});
  Address? get defaultAddress =>
      addresses.where((a) => a.isDefault).firstOrNull ?? addresses.firstOrNull;
}

enum OrderStatus { placed, processing, shipped, delivered, cancelled }
extension OrderStatusX on OrderStatus {
  String get label => const {
    OrderStatus.placed: 'Order Placed', OrderStatus.processing: 'Processing',
    OrderStatus.shipped: 'Shipped', OrderStatus.delivered: 'Delivered',
    OrderStatus.cancelled: 'Cancelled',
  }[this]!;
  int get step => const {
    OrderStatus.placed: 0, OrderStatus.processing: 1,
    OrderStatus.shipped: 2, OrderStatus.delivered: 3, OrderStatus.cancelled: -1,
  }[this]!;
  Color get color => this == OrderStatus.delivered ? C.success
      : this == OrderStatus.cancelled ? C.error : C.blue;
}

class AppOrder {
  final String id, orderNumber, paymentMethod;
  final List<CartItem> items;
  final double subtotal, shipping, total, discount;
  final Address address;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;
  const AppOrder({required this.id, required this.orderNumber, required this.items,
    required this.subtotal, required this.shipping, required this.total,
    required this.address, required this.paymentMethod, required this.status,
    required this.createdAt, this.estimatedDelivery, this.discount = 0});
  int get itemCount => items.fold(0, (s, i) => s + i.quantity);
}

class BannerData {
  final String id, imageUrl, title, subtitle, actionLabel, route, tag;
  const BannerData({required this.id, required this.imageUrl, required this.title,
    required this.subtitle, required this.actionLabel, required this.route, this.tag = ''});
}

class CategoryData {
  final String id, name, emoji;
  final Color color, bgColor;
  const CategoryData({required this.id, required this.name,
    required this.emoji, required this.color, required this.bgColor});
}

class BrandData {
  final String id, name, logoUrl;
  const BrandData({required this.id, required this.name, required this.logoUrl});
}

// ╔══════════════════════════════════════════════════════════╗
// ║                  4 · MOCK DATA                          ║
// ╚══════════════════════════════════════════════════════════╝

// Using reliable Unsplash photos with known-good IDs
final kProducts = <Product>[
  Product(
    id: 'p01', name: 'Slim Fit Oxford Shirt', brand: 'Ralph Lauren',
    description: 'A timeless oxford shirt crafted from premium 100% cotton. Features a button-down collar, tailored slim fit, and subtle texture that elevates any formal or smart-casual look.',
    price: 79.99, originalPrice: 120.00, category: 'Men', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=80',
      'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=600&q=80',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['White','Blue','Navy'],
    rating: 4.7, reviewCount: 324, soldCount: 890, isFeatured: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal",
    details: {'Material':'100% Cotton','Fit':'Slim Fit','Care':'Machine Wash','Origin':'Portugal'},
  ),
  Product(
    id: 'p02', name: 'Classic Wool Blazer', brand: 'Tommy Hilfiger',
    description: 'Elevate your wardrobe with this sophisticated wool-blend blazer. Features a single-button closure, notch lapels, and structured shoulders for a sharp professional look.',
    price: 249.99, originalPrice: 380.00, category: 'Men', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1594938298603-c8148c4b2f8e?w=600&q=80',
      'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600&q=80',
    ],
    sizes: ['S','M','L','XL'], colors: ['Charcoal','Navy','Black'],
    rating: 4.9, reviewCount: 187, soldCount: 420, isFeatured: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal",
    details: {'Material':'70% Wool, 30% Poly','Fit':'Slim Fit','Care':'Dry Clean Only','Lining':'Full'},
  ),
  Product(
    id: 'p03', name: 'Slim Chino Trousers', brand: 'Dior',
    description: 'Versatile chino trousers that seamlessly blend comfort and style. Crafted from a lightweight cotton-stretch blend.',
    price: 89.99, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=600&q=80',
      'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=600&q=80',
    ],
    sizes: ['28','30','32','34','36'], colors: ['Khaki','Navy','Olive'],
    rating: 4.5, reviewCount: 458, soldCount: 1200, isNew: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'97% Cotton, 3% Elastane','Fit':'Slim','Rise':'Mid','Care':'Machine Wash'},
  ),
  Product(
    id: 'p04', name: 'Premium Oversized Hoodie', brand: 'Chanel',
    description: 'The ultimate streetwear staple. This heavyweight cotton hoodie features an oversized silhouette and premium fleece interior for exceptional warmth.',
    price: 119.99, originalPrice: 160.00, category: 'Men', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1556821840-3a63f15732ce?w=600&q=80',
      'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=600&q=80',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['Black','Cream','Forest Green'],
    rating: 4.8, reviewCount: 792, soldCount: 2100, isNew: true, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'400gsm Fleece','Fit':'Oversized','Weight':'Heavyweight','Care':'Machine Wash Cold'},
  ),
  Product(
    id: 'p05', name: 'Cargo Tech Pants', brand: 'Versace',
    description: 'Functional meets fashion with these technical cargo pants. Multiple zip pockets, adjustable waistband, and tapered leg silhouette.',
    price: 149.99, originalPrice: 200.00, category: 'Men', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&q=80',
      'https://images.unsplash.com/photo-1517438476312-10d79c077509?w=600&q=80',
    ],
    sizes: ['S','M','L','XL'], colors: ['Black','Khaki','Dark Green'],
    rating: 4.6, reviewCount: 234, soldCount: 560,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'Ripstop Nylon','Pockets':'6 Zip','Feature':'Water Resistant','Care':'Machine Wash'},
  ),
  Product(
    id: 'p06', name: 'Floral Midi Dress', brand: 'Gucci',
    description: 'A stunning floral midi dress featuring a V-neckline, flowy silhouette, and delicate floral print. Crafted from lightweight viscose fabric.',
    price: 129.99, originalPrice: 180.00, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=600&q=80',
      'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=600&q=80',
    ],
    sizes: ['XS','S','M','L','XL'], colors: ['Floral Blue','Floral Pink'],
    rating: 4.8, reviewCount: 567, soldCount: 1340, isNew: true, isFeatured: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'100% Viscose','Fit':'Relaxed','Length':'Midi','Care':'Hand Wash'},
  ),
  Product(
    id: 'p07', name: 'Tailored Blazer Dress', brand: 'Prada',
    description: 'A sophisticated power-dressing piece that commands attention. This tailored blazer dress features peak lapels and a defined waist.',
    price: 219.99, originalPrice: 320.00, category: 'Women', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=600&q=80',
      'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=600&q=80',
    ],
    sizes: ['XS','S','M','L'], colors: ['Black','Ivory','Deep Red'],
    rating: 4.9, reviewCount: 189, soldCount: 380, isFeatured: true,
    rackId: 'rack_women_formal', rackName: "Women's Formal",
    details: {'Material':'Italian Crepe','Fit':'Tailored','Closure':'Single Button','Care':'Dry Clean'},
  ),
  Product(
    id: 'p08', name: 'High-Waist Wide Leg Jeans', brand: 'Calvin Klein',
    description: 'A modern take on the classic wide-leg silhouette. Premium stretch denim that flatters every body type.',
    price: 109.99, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=600&q=80',
      'https://images.unsplash.com/photo-1475178626620-a4d074967452?w=600&q=80',
    ],
    sizes: ['24','25','26','27','28','30'], colors: ['Light Wash','Dark Wash','Black'],
    rating: 4.7, reviewCount: 883, soldCount: 2500,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'93% Cotton, 7% Elastane','Rise':'High','Fit':'Wide Leg','Care':'Machine Wash'},
  ),
  Product(
    id: 'p09', name: 'Cropped Leather Jacket', brand: 'Versace',
    description: 'The definitive statement piece. Crafted from premium vegan leather with silver-tone hardware and asymmetric zip closure.',
    price: 299.99, originalPrice: 450.00, category: 'Women', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=600&q=80',
      'https://images.unsplash.com/photo-1548624313-0396c75e4b1a?w=600&q=80',
    ],
    sizes: ['XS','S','M','L'], colors: ['Black','Burgundy','Tan'],
    rating: 4.9, reviewCount: 342, soldCount: 710, isNew: true, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'Vegan Leather','Fit':'Cropped','Hardware':'Silver','Care':'Wipe Clean'},
  ),
  Product(
    id: 'p10', name: 'Satin Slip Dress', brand: 'Gucci',
    description: 'Effortlessly chic satin slip dress with adjustable spaghetti straps and a bias-cut silhouette.',
    price: 99.99, originalPrice: 150.00, category: 'Women', subCategory: 'Formal',
    images: [
      'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=600&q=80',
      'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=600&q=80',
    ],
    sizes: ['XS','S','M','L'], colors: ['Champagne','Dusty Rose','Black'],
    rating: 4.7, reviewCount: 456, soldCount: 980,
    rackId: 'rack_women_formal', rackName: "Women's Formal",
    details: {'Material':'100% Satin','Fit':'Bias Cut','Straps':'Adjustable','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p11', name: 'Kids Denim Overalls', brand: 'Tommy Hilfiger',
    description: 'Super cute and durable denim overalls. Features adjustable straps and reinforced knees.',
    price: 49.99, originalPrice: 70.00, category: 'Kids', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=600&q=80',
      'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=600&q=80',
    ],
    sizes: ['3T','4T','5T','6','7','8'], colors: ['Light Denim','Dark Denim'],
    rating: 4.8, reviewCount: 234, soldCount: 670,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'Soft Denim','Feature':'Reinforced Knees','Straps':'Adjustable','Care':'Machine Wash'},
  ),
  Product(
    id: 'p12', name: 'Kids Graphic Tee Set', brand: 'Ralph Lauren',
    description: 'Fun graphic tee and matching shorts set. Made from super-soft 100% cotton jersey.',
    price: 39.99, category: 'Kids', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?w=600&q=80',
      'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?w=600&q=80',
    ],
    sizes: ['3T','4T','5T','6','7','8'], colors: ['Blue','Red','Yellow'],
    rating: 4.6, reviewCount: 178, soldCount: 440, isNew: true,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'100% Cotton','Set':'2-Piece','Waistband':'Elastic','Care':'Machine Wash'},
  ),
  Product(
    id: 'p13', name: 'Leather Tote Bag', brand: 'Chanel',
    description: 'A spacious and elegant leather tote made from full-grain leather with gold-tone hardware.',
    price: 189.99, originalPrice: 280.00, category: 'Accessories', subCategory: 'Bags',
    images: [
      'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=600&q=80',
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80',
    ],
    sizes: ['One Size'], colors: ['Tan','Black','Cognac'],
    rating: 4.9, reviewCount: 312, soldCount: 540, isFeatured: true,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'Full-Grain Leather','Hardware':'Gold-Tone','Dimensions':'14x12x5"','Pockets':'Interior'},
  ),
  Product(
    id: 'p14', name: 'Wool Knit Scarf', brand: 'Prada',
    description: 'Luxuriously soft merino wool scarf with a classic ribbed pattern. Extra-long for multiple styling options.',
    price: 69.99, originalPrice: 100.00, category: 'Accessories', subCategory: 'Scarves',
    images: [
      'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=600&q=80',
      'https://images.unsplash.com/photo-1574180566232-aaad1b5b8450?w=600&q=80',
    ],
    sizes: ['One Size'], colors: ['Camel','Charcoal','Cream'],
    rating: 4.8, reviewCount: 145, soldCount: 320,
    rackId: 'rack_accessories', rackName: 'Accessories',
    details: {'Material':'100% Merino Wool','Length':'180cm','Pattern':'Ribbed Knit','Care':'Hand Wash'},
  ),
  Product(
    id: 'p15', name: 'Cable Knit Sweater', brand: 'Gucci',
    description: 'A cozy cable knit sweater perfect for layering or wearing on its own. Crafted with soft yarn for all-day comfort.',
    price: 42.99, originalPrice: 46.77, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600&q=80',
      'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=600&q=80',
    ],
    sizes: ['S','M','L','XL','XXL'], colors: ['Brown','Cream','Grey','Navy'],
    rating: 4.2, reviewCount: 380, soldCount: 1560, isNew: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'100% Merino Wool','Fit':'Regular','Pattern':'Cable Knit','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p16', name: 'Tomorrow Cardigan', brand: 'Ralph Lauren',
    description: 'An iconic cardigan with classic styling. Ribbed collar and cuffs, button front, and premium quality knit.',
    price: 36.99, originalPrice: 46.77, category: 'Men', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1623479322729-28b25c16b011?w=600&q=80',
      'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=600&q=80',
    ],
    sizes: ['S','M','L','XL'], colors: ['Brown','Black','Navy'],
    rating: 4.2, reviewCount: 290, soldCount: 870, isFeatured: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual",
    details: {'Material':'Wool Blend','Buttons':'Brass','Collar':'Ribbed','Care':'Dry Clean Preferred'},
  ),
  Product(
    id: 'p17', name: 'Oversized Knit Sweater', brand: 'Dior',
    description: 'A cozy, oversized knit sweater in a chunky cable-knit pattern. Dropped shoulders and ribbed cuffs.',
    price: 109.99, originalPrice: 155.00, category: 'Women', subCategory: 'Casual',
    images: [
      'https://images.unsplash.com/photo-1434389677669-e08b4cda3a40?w=600&q=80',
      'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600&q=80',
    ],
    sizes: ['XS','S','M','L','XL'], colors: ['Cream','Dusty Rose','Sage'],
    rating: 4.8, reviewCount: 523, soldCount: 1290, isNew: true, isFeatured: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual",
    details: {'Material':'80% Wool, 20% Cashmere','Fit':'Oversized','Pattern':'Cable Knit','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p18', name: 'White Leather Sneakers', brand: 'Versace',
    description: 'Minimalist white leather sneakers with cushioned insole and signature back-tab detail.',
    price: 129.99, category: 'Women', subCategory: 'Streetwear',
    images: [
      'https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=600&q=80',
      'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600&q=80',
    ],
    sizes: ['36','37','38','39','40','41'], colors: ['White','Black'],
    rating: 4.9, reviewCount: 678, soldCount: 2300, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear',
    details: {'Material':'Premium Leather','Sole':'Rubber','Insole':'Memory Foam','Care':'Wipe Clean'},
  ),
];

final kBanners = <BannerData>[
  BannerData(id:'b1', imageUrl:'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
    title:'Enjoy 25% off\non all Fashion', subtitle:"Don't miss this offer", actionLabel:'Shop Now', route:'/explore', tag:'LIMITED'),
  BannerData(id:'b2', imageUrl:'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800&q=80',
    title:"Women's\nNew Season", subtitle:'Explore the Latest Trends', actionLabel:'Discover', route:'/explore', tag:'NEW'),
  BannerData(id:'b3', imageUrl:'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800&q=80',
    title:'Street\nStyle Drop', subtitle:'Urban Fashion for the Bold', actionLabel:'Explore', route:'/explore', tag:'HOT'),
];

final kCategories = <CategoryData>[
  CategoryData(id:'men',   name:'Men',         emoji:'👔', color:C.blue,    bgColor:C.blueLight),
  CategoryData(id:'women', name:'Women',       emoji:'👗', color:const Color(0xFFDB2777), bgColor:const Color(0xFFFDF2F8)),
  CategoryData(id:'kids',  name:'Kids',        emoji:'🎒', color:const Color(0xFF059669), bgColor:const Color(0xFFF0FDF4)),
  CategoryData(id:'accs',  name:'Accessories', emoji:'👜', color:const Color(0xFFD97706), bgColor:const Color(0xFFFFFBEB)),
];

final kBrands = <BrandData>[
  BrandData(id:'polo',    name:'Polo',    logoUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Ralph_Lauren_logo.svg/120px-Ralph_Lauren_logo.svg.png'),
  BrandData(id:'tommy',   name:'Tommy',   logoUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Tommy_Hilfiger_logo.svg/120px-Tommy_Hilfiger_logo.svg.png'),
  BrandData(id:'dior',    name:'Dior',    logoUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Christian_Dior_logo.svg/120px-Christian_Dior_logo.svg.png'),
  BrandData(id:'chanel',  name:'Chanel',  logoUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Chanel_logo_interlocking_cs.svg/120px-Chanel_logo_interlocking_cs.svg.png'),
  BrandData(id:'versace', name:'Versace', logoUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Versace_logo.svg/120px-Versace_logo.svg.png'),
  BrandData(id:'gucci',   name:'Gucci',   logoUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/1960s_Gucci_Logo.svg/120px-1960s_Gucci_Logo.svg.png'),
];

const kRackMap = <String, List<String>>{
  'rack_men_formal':   ['p01','p02'],
  'rack_men_casual':   ['p03','p15','p16'],
  'rack_streetwear':   ['p04','p05','p09','p18'],
  'rack_women_casual': ['p06','p08','p17'],
  'rack_women_formal': ['p07','p10'],
  'rack_kids':         ['p11','p12'],
  'rack_accessories':  ['p13','p14'],
};

const kRackNames = <String, String>{
  'rack_men_formal':   "Men's Formal Section",
  'rack_men_casual':   "Men's Casual Section",
  'rack_streetwear':   'Streetwear Collection',
  'rack_women_casual': "Women's Casual Section",
  'rack_women_formal': "Women's Formal Section",
  'rack_kids':         "Kids' Section",
  'rack_accessories':  'Accessories Section',
};

const _colorMap = <String, Color>{
  'White': Color(0xFFF8F8F8), 'Black': Color(0xFF1A1A1A), 'Blue': Color(0xFF2962FF),
  'Light Blue': Color(0xFF64B5F6), 'Navy': Color(0xFF0D47A1), 'Charcoal': Color(0xFF424242),
  'Khaki': Color(0xFFC8AD7F), 'Olive': Color(0xFF6B8E23), 'Brown': Color(0xFF6B3F2A),
  'Cream': Color(0xFFFFF8DC), 'Forest Green': Color(0xFF228B22), 'Burgundy': Color(0xFF800020),
  'Dark Green': Color(0xFF006400), 'Floral Blue': Color(0xFF6495ED), 'Floral Pink': Color(0xFFF8A4B8),
  'Ivory': Color(0xFFFFFFF0), 'Deep Red': Color(0xFFB71C1C), 'Light Wash': Color(0xFFB3C7E6),
  'Dark Wash': Color(0xFF3A5A8C), 'Light Denim': Color(0xFF7BA3D4), 'Dark Denim': Color(0xFF3B5998),
  'Tan': Color(0xFFD2B48C), 'Champagne': Color(0xFFF7E7CE), 'Dusty Rose': Color(0xFFDCB2A8),
  'Sage': Color(0xFFB2C5B0), 'Sage Green': Color(0xFFB2AC88), 'Red': Color(0xFFE53935),
  'Yellow': Color(0xFFFFEB3B), 'Green': Color(0xFF4CAF50), 'Camel': Color(0xFFC19A6B),
  'Cognac': Color(0xFF9A463D), 'Grey': Color(0xFF9E9E9E), 'Heather Grey': Color(0xFFB6B6B4),
};

// ╔══════════════════════════════════════════════════════════╗
// ║                  5 · PROVIDERS (Riverpod)               ║
// ╚══════════════════════════════════════════════════════════╝

final onboardingCompleteProvider = StateProvider<bool>((_) => false);

final authProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override Future<AppUser?> build() async {
    await Future.delayed(const Duration(milliseconds: 600));
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
    state = AsyncData(AppUser(id: 'u_${DateTime.now().ms}', name: name, email: email));
    return true;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 400));
    state = const AsyncData(null);
  }

  AppUser _makeUser(String email) => AppUser(
    id: 'u001',
    name: email.split('@').first.split('.').map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}').join(' '),
    email: email, addresses: [_defaultAddress()],
  );

  Address _defaultAddress() => const Address(
    id: 'a01', name: 'Home', phone: '+1 234 567 8900',
    line1: 'Vicatoria lane', line2: 'Maryland',
    city: 'New York', state: 'NY', zip: '10001', country: 'USA', isDefault: true,
  );
}

class PFilter {
  final String? category, subCategory, search, sortBy;
  final List<String> sizes, colors;
  final double? minPrice, maxPrice;
  const PFilter({this.category, this.subCategory, this.search,
    this.sortBy = 'popularity', this.sizes = const [],
    this.colors = const [], this.minPrice, this.maxPrice});
  bool get hasFilters => category != null || sizes.isNotEmpty || colors.isNotEmpty || minPrice != null || maxPrice != null || search != null;
  PFilter copyWith({String? category, String? subCategory, String? search,
    String? sortBy, List<String>? sizes, List<String>? colors,
    double? minPrice, double? maxPrice,
    bool clearCategory = false, bool clearSearch = false}) => PFilter(
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
      return p.name.toLowerCase().contains(q) || p.brand.toLowerCase().contains(q)
          || p.category.toLowerCase().contains(q);
    }
    return true;
  }).toList();
  switch (f.sortBy) {
    case 'price_low':  list.sort((a,b) => a.price.compareTo(b.price)); break;
    case 'price_high': list.sort((a,b) => b.price.compareTo(a.price)); break;
    case 'newest':     list.sort((a,b) => b.isNew ? 1 : -1); break;
    case 'rating':     list.sort((a,b) => b.rating.compareTo(a.rating)); break;
    default:           list.sort((a,b) => b.reviewCount.compareTo(a.reviewCount));
  }
  return list;
});

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((_) => CartNotifier());
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);
  void add(Product p, String size, String color, {int qty = 1}) {
    final idx = state.indexWhere((i) => i.product.id == p.id && i.selectedSize == size);
    if (idx >= 0) {
      state = [...state.sublist(0,idx), state[idx].copyWith(quantity: state[idx].quantity+qty), ...state.sublist(idx+1)];
    } else {
      state = [...state, CartItem(id:'${p.id}_$size', product:p, quantity:qty, selectedSize:size, selectedColor:color)];
    }
  }
  void remove(String id) => state = state.where((i) => i.id != id).toList();
  void updateQty(String id, int qty) {
    if (qty <= 0) { remove(id); return; }
    state = state.map((i) => i.id == id ? i.copyWith(quantity:qty) : i).toList();
  }
  void clear() => state = [];
  double get subtotal => state.fold(0, (s,i) => s + i.total);
  double get shipping  => subtotal >= 100 ? 0 : 9.99;
  double get total     => subtotal + shipping;
  int    get count     => state.fold(0, (s,i) => s + i.quantity);
}
final cartCountProvider    = Provider<int>((ref)    => ref.watch(cartProvider.notifier).count);
final cartSubtotalProvider = Provider<double>((ref) => ref.watch(cartProvider.notifier).subtotal);
final cartTotalProvider    = Provider<double>((ref) => ref.watch(cartProvider.notifier).total);

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>((_) => WishlistNotifier());
class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);
  void toggle(Product p) => state = state.any((x) => x.id==p.id)
      ? state.where((x) => x.id!=p.id).toList() : [...state, p];
  bool has(String id) => state.any((x) => x.id==id);
}
final inWishlistProvider = Provider.family<bool,String>((ref, id) => ref.watch(wishlistProvider.notifier).has(id));

final recentlyViewedProvider = StateNotifierProvider<RecentlyViewedNotifier, List<Product>>((_) => RecentlyViewedNotifier());
class RecentlyViewedNotifier extends StateNotifier<List<Product>> {
  RecentlyViewedNotifier() : super([]);
  void add(Product p) => state = [p, ...state.where((x) => x.id!=p.id)].take(8).toList();
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<AppOrder>>((_) => OrdersNotifier());
class OrdersNotifier extends StateNotifier<List<AppOrder>> {
  OrdersNotifier() : super([
    AppOrder(
      id:'o1', orderNumber:'SS-2024-001', items:[], subtotal:329.98, shipping:0, total:329.98,
      address: const Address(id:'a1', name:'Home', phone:'+1 234 567 8900', line1:'123 Fashion St', city:'New York', state:'NY', zip:'10001', country:'USA', isDefault:true),
      paymentMethod:'Card Payment', status:OrderStatus.delivered,
      createdAt:DateTime.now().subtract(const Duration(days:15)),
      estimatedDelivery:DateTime.now().subtract(const Duration(days:5)),
    ),
    AppOrder(
      id:'o2', orderNumber:'SS-2024-002', items:[], subtotal:249.99, shipping:0, total:249.99,
      address: const Address(id:'a1', name:'Home', phone:'+1 234 567 8900', line1:'123 Fashion St', city:'New York', state:'NY', zip:'10001', country:'USA', isDefault:true),
      paymentMethod:'Cash on Delivery', status:OrderStatus.shipped,
      createdAt:DateTime.now().subtract(const Duration(days:3)),
      estimatedDelivery:DateTime.now().add(const Duration(days:2)),
    ),
  ]);

  Future<AppOrder> place({required List<CartItem> items, required Address address, required String payment}) async {
    await Future.delayed(const Duration(seconds: 2));
    final sub = items.fold<double>(0, (s,i) => s+i.total);
    final ship = sub >= 100 ? 0.0 : 9.99;
    final order = AppOrder(
      id:'o_${DateTime.now().ms}', orderNumber:'SS-2024-${(state.length+1).toString().padLeft(3,'0')}',
      items:items, subtotal:sub, shipping:ship, total:sub+ship,
      address:address, paymentMethod:payment, status:OrderStatus.placed,
      createdAt:DateTime.now(), estimatedDelivery:DateTime.now().add(const Duration(days:5)),
    );
    state = [order, ...state];
    return order;
  }
}

extension on DateTime { int get ms => millisecondsSinceEpoch; }

// ╔══════════════════════════════════════════════════════════╗
// ║                  6 · ROUTER                             ║
// ╚══════════════════════════════════════════════════════════╝

final _rootKey  = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  final onboardingDone = ref.watch(onboardingCompleteProvider);
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    redirect: (ctx, state) {
      final isOnboarding = state.matchedLocation == '/onboarding';
      if (!onboardingDone && !isOnboarding) return '/onboarding';
      if (onboardingDone && isOnboarding) {
        return auth.valueOrNull != null ? '/' : '/login';
      }
      final loggedIn = auth.valueOrNull != null;
      final isAuth   = state.matchedLocation.startsWith('/login') || state.matchedLocation.startsWith('/register');
      if (!loggedIn && !isAuth && !isOnboarding) return '/login';
      if (loggedIn  &&  isAuth) return '/';
      return null;
    },
    routes: [
      GoRoute(path:'/onboarding', pageBuilder:(c,s) => _fade(s, const OnboardingScreen())),
      GoRoute(path:'/login',    pageBuilder:(c,s) => _fade(s, const LoginScreen())),
      GoRoute(path:'/register', pageBuilder:(c,s) => _slide(s, const RegisterScreen())),
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (c,s,child) => MainNav(child:child),
        routes: [
          GoRoute(path:'/',          pageBuilder:(c,s) => _none(s, const HomeScreen())),
          GoRoute(path:'/explore',   pageBuilder:(c,s) => _none(s, const ExploreScreen())),
          GoRoute(path:'/cart',      pageBuilder:(c,s) => _none(s, const CartScreen())),
          GoRoute(path:'/wishlist',  pageBuilder:(c,s) => _none(s, const WishlistScreen())),
          GoRoute(path:'/profile',   pageBuilder:(c,s) => _none(s, const ProfileScreen())),
        ],
      ),
      GoRoute(path:'/product/:id',   parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slideUp(s, ProductDetailScreen(product: s.extra as Product?))),
      GoRoute(path:'/checkout',      parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slideUp(s, const CheckoutScreen())),
      GoRoute(path:'/orders',        parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slide(s,  const OrdersScreen())),
      GoRoute(path:'/try-on',        parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _fade(s,   TryOnScreen(product: s.extra as Product?))),
      GoRoute(path:'/qr-scanner',    parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _fade(s,   const QrScannerScreen())),
      GoRoute(path:'/rack/:id',      parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slide(s,  RackProductsScreen(rackId: s.pathParameters['id']!, extra: s.extra))),
      GoRoute(path:'/order-success', parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slideUp(s, OrderSuccessScreen(order: s.extra as AppOrder))),
    ],
  );
});

Page<dynamic> _fade(GoRouterState s, Widget c)    => CustomTransitionPage(key:s.pageKey, child:c, transitionsBuilder:(ctx,a,b,ch) => FadeTransition(opacity:a, child:ch));
Page<dynamic> _none(GoRouterState s, Widget c)    => NoTransitionPage(key:s.pageKey, child:c);
Page<dynamic> _slide(GoRouterState s, Widget c)   => CustomTransitionPage(key:s.pageKey, child:c, transitionsBuilder:(ctx,a,b,ch) => SlideTransition(position:Tween<Offset>(begin:const Offset(1,0),end:Offset.zero).animate(CurvedAnimation(parent:a,curve:Curves.easeOutCubic)), child:ch));
Page<dynamic> _slideUp(GoRouterState s, Widget c) => CustomTransitionPage(key:s.pageKey, child:c, transitionsBuilder:(ctx,a,b,ch) => SlideTransition(position:Tween<Offset>(begin:const Offset(0,1),end:Offset.zero).animate(CurvedAnimation(parent:a,curve:Curves.easeOutCubic)), child:ch));

// ╔══════════════════════════════════════════════════════════╗
// ║                  7 · APP ROOT                           ║
// ╚══════════════════════════════════════════════════════════╝

class StyleSphereApp extends ConsumerWidget {
  const StyleSphereApp({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'StyleSphere',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      routerConfig: router,
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                  8 · SHARED WIDGETS                     ║
// ╚══════════════════════════════════════════════════════════╝

class Img extends StatelessWidget {
  final String url;
  final double? w, h;
  final BoxFit fit;
  final double r;
  const Img(this.url, {super.key, this.w, this.h, this.fit = BoxFit.cover, this.r = 0});
  @override Widget build(BuildContext ctx) => ClipRRect(
    borderRadius: BorderRadius.circular(r),
    child: CachedNetworkImage(
      imageUrl: url, width: w, height: h, fit: fit,
      placeholder: (c, u) => Shimmer.fromColors(
        baseColor: C.g200, highlightColor: C.g100,
        child: Container(width: w, height: h, color: C.g200)),
      errorWidget: (c, u, e) => Container(
        width: w, height: h, color: C.g100,
        child: const Icon(Icons.image_outlined, color: C.g300, size: 32)),
    ),
  );
}

class Btn extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final bool loading;
  final double? w; final IconData? icon; final Color? bg; final double h;
  const Btn({super.key, required this.text, this.onPressed, this.loading=false, this.w, this.icon, this.bg, this.h=52});
  @override Widget build(BuildContext ctx) => SizedBox(width: w ?? double.infinity, height: h,
    child: ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: bg ?? C.blue, disabledBackgroundColor: C.g200),
      child: loading
        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: C.white))
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
            Text(text),
          ]),
    ),
  );
}

class BuyBtn extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final double? w;
  const BuyBtn({super.key, required this.text, this.onPressed, this.w});
  @override Widget build(BuildContext ctx) => SizedBox(width: w ?? double.infinity, height: 52,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: C.blueDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: C.white)),
    ),
  );
}

class OutBtn extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final double? w;
  const OutBtn({super.key, required this.text, this.onPressed, this.w});
  @override Widget build(BuildContext ctx) => SizedBox(width: w ?? double.infinity, height: 52,
    child: OutlinedButton(onPressed: onPressed, child: Text(text)));
}

class SecHeader extends StatelessWidget {
  final String title; final VoidCallback? onAll;
  const SecHeader({super.key, required this.title, this.onAll});
  @override Widget build(BuildContext ctx) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
      if (onAll != null) TextButton(
        onPressed: onAll,
        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text('See All', style: GoogleFonts.poppins(fontSize: 13, color: C.blue, fontWeight: FontWeight.w600)),
      ),
    ],
  );
}

class Stars extends StatelessWidget {
  final double rating; final int count; final double sz;
  const Stars({super.key, required this.rating, this.count = 0, this.sz = 13});
  @override Widget build(BuildContext ctx) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(Icons.star_rounded, color: Colors.amber, size: sz),
    const SizedBox(width: 2),
    Text(rating.toStringAsFixed(1),
      style: GoogleFonts.poppins(fontSize: sz - 2, fontWeight: FontWeight.w600, color: C.g700)),
    if (count > 0) Text(' ($count)', style: GoogleFonts.poppins(fontSize: sz - 2, color: C.g400)),
  ]);
}

class SaleBadge extends StatelessWidget {
  final double pct;
  const SaleBadge({super.key, required this.pct});
  @override Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: C.red, borderRadius: BorderRadius.circular(4)),
    child: Text('-${pct.toInt()}%', style: const TextStyle(color: C.white, fontSize: 9, fontWeight: FontWeight.w800)),
  );
}

class NewBadge extends StatelessWidget {
  const NewBadge({super.key});
  @override Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(color: C.blue, borderRadius: BorderRadius.circular(5)),
    child: const Text('NEW', style: TextStyle(color: C.white, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
  );
}

class PriceRow extends StatelessWidget {
  final double price; final double? orig; final double sz; final double origSz;
  const PriceRow({super.key, required this.price, this.orig, this.sz = 16, this.origSz = 12});
  @override Widget build(BuildContext ctx) => Row(mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
    children: [
      Text('\$${price.toStringAsFixed(2)}',
        style: TextStyle(fontSize: sz, fontWeight: FontWeight.w700, color: C.primary)),
      if (orig != null && orig! > price) ...[const SizedBox(width: 5),
        Text('\$${orig!.toStringAsFixed(2)}',
          style: TextStyle(fontSize: origSz, fontWeight: FontWeight.w400, color: C.g400, decoration: TextDecoration.lineThrough))],
    ]);
}

class EmptyView extends StatelessWidget {
  final IconData icon; final String title, desc; final String? btnLabel; final VoidCallback? onBtn;
  const EmptyView({super.key, required this.icon, required this.title, required this.desc, this.btnLabel, this.onBtn});
  @override Widget build(BuildContext ctx) => Center(child: Padding(padding: const EdgeInsets.all(32),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 90, height: 90, decoration: const BoxDecoration(color: C.g100, shape: BoxShape.circle),
        child: Icon(icon, size: 40, color: C.g300)),
      const SizedBox(height: 20),
      Text(title, style: Theme.of(ctx).textTheme.headlineSmall, textAlign: TextAlign.center),
      const SizedBox(height: 8),
      Text(desc, style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(color: C.g500), textAlign: TextAlign.center),
      if (btnLabel != null && onBtn != null) ...[const SizedBox(height: 28),
        Btn(text: btnLabel!, onPressed: onBtn, w: 180)],
    ])));
}

void snack(BuildContext ctx, String msg, {bool err = false, String? action, VoidCallback? onAction}) =>
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(msg), backgroundColor: err ? C.error : C.primary,
    behavior: SnackBarBehavior.floating, margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    action: action != null ? SnackBarAction(label: action, textColor: const Color(0xFF60A5FA), onPressed: onAction ?? () {}) : null,
  ));

// ╔══════════════════════════════════════════════════════════╗
// ║                  9 · BOTTOM NAVIGATION                  ║
// ╚══════════════════════════════════════════════════════════╝

class MainNav extends ConsumerWidget {
  final Widget child;
  const MainNav({super.key, required this.child});
  static const _routes = ['/', '/explore', '/cart', '/wishlist', '/profile'];
  int _idx(String loc) { for (int i = _routes.length-1; i >= 0; i--) if (loc.startsWith(_routes[i])) return i; return 0; }

  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final loc   = GoRouterState.of(ctx).matchedLocation;
    final cur   = _idx(loc);
    final count = ref.watch(cartCountProvider);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: C.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))]),
        child: SafeArea(child: SizedBox(height: 64, child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NI(Icons.home_outlined,          Icons.home_rounded,            'Home',     cur==0, () => ctx.go('/'),        null),
            _NI(Icons.explore_outlined,       Icons.explore_rounded,         'Explore',  cur==1, () => ctx.go('/explore'), null),
            _NI(Icons.shopping_bag_outlined,  Icons.shopping_bag_rounded,    'Cart',     cur==2, () => ctx.go('/cart'),    count>0?count:null),
            _NI(Icons.favorite_border_rounded, Icons.favorite_rounded,       'Wishlist', cur==3, () => ctx.go('/wishlist'),null),
            _NI(Icons.person_outline_rounded,  Icons.person_rounded,         'Profile',  cur==4, () => ctx.go('/profile'), null),
          ],
        ))),
      ),
    );
  }
}

class _NI extends StatelessWidget {
  final IconData ic, ica; final String lbl; final bool active; final VoidCallback tap; final int? badge;
  const _NI(this.ic, this.ica, this.lbl, this.active, this.tap, this.badge);
  @override Widget build(BuildContext ctx) => GestureDetector(onTap: tap,
    behavior: HitTestBehavior.opaque,
    child: SizedBox(width: 64, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(clipBehavior: Clip.none, children: [
        AnimatedSwitcher(duration: 200.ms, child: Icon(active ? ica : ic,
          key: ValueKey(active), size: 24, color: active ? C.blue : C.g400)),
        if (badge != null) Positioned(right: -6, top: -6, child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(color: C.red, shape: BoxShape.circle),
          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
          child: Text('$badge', style: const TextStyle(color: C.white, fontSize: 9, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
        )),
      ]),
      const SizedBox(height: 3),
      Text(lbl, style: TextStyle(fontSize: 10,
        fontWeight: active ? FontWeight.w600 : FontWeight.w400,
        color: active ? C.blue : C.g400)),
    ])),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║               9B · ONBOARDING SCREEN                    ║
// ╚══════════════════════════════════════════════════════════╝

class _OBPage {
  final String imageUrl, title, subtitle, tag;
  const _OBPage({required this.imageUrl, required this.title, required this.subtitle, required this.tag});
}

final _obPages = <_OBPage>[
  _OBPage(
    imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900&q=85',
    title: 'Discover\nYour Style',
    subtitle: 'Shop curated collections from the world\'s top fashion brands',
    tag: '500+ Brands',
  ),
  _OBPage(
    imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=900&q=85',
    title: 'Try Before\nYou Buy',
    subtitle: 'Virtual try-on technology so you always look your best',
    tag: 'AR Try-On',
  ),
  _OBPage(
    imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=900&q=85',
    title: 'Fast &\nSafe Delivery',
    subtitle: 'Free shipping on orders over \$100. Easy returns guaranteed',
    tag: 'Free Shipping',
  ),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override ConsumerState<OnboardingScreen> createState() => _OBState();
}

class _OBState extends ConsumerState<OnboardingScreen> with TickerProviderStateMixin {
  final _pc = PageController();
  int _cur = 0;
  late AnimationController _fadeCtrl;

  @override void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fadeCtrl.forward();
  }

  @override void dispose() { _pc.dispose(); _fadeCtrl.dispose(); super.dispose(); }

  void _skip() => ref.read(onboardingCompleteProvider.notifier).state = true;

  void _next() {
    if (_cur < _obPages.length - 1) {
      _fadeCtrl.reverse().then((_) {
        _pc.nextPage(duration: 400.ms, curve: Curves.easeInOutCubic);
        _fadeCtrl.forward();
      });
    } else {
      _skip();
    }
  }

  @override Widget build(BuildContext ctx) {
    final page = _obPages[_cur];
    return Scaffold(body: Stack(children: [
      // Full screen image
      Positioned.fill(child: CachedNetworkImage(
        imageUrl: page.imageUrl, fit: BoxFit.cover,
        placeholder: (c, u) => Container(color: C.g100),
        errorWidget: (c, u, e) => Container(decoration: const BoxDecoration(gradient: C.blueGrad)),
      )),
      // Gradient overlay — lighter at top, heavier at bottom
      Positioned.fill(child: Container(decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          stops: const [0.0, 0.4, 0.75, 1.0],
          colors: [
            Colors.black.withOpacity(0.15),
            Colors.black.withOpacity(0.05),
            Colors.black.withOpacity(0.55),
            Colors.black.withOpacity(0.92),
          ],
        ),
      ))),

      // Top — logo & skip
      Positioned(top: 0, left: 0, right: 0, child: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Row(children: [
              Container(width: 34, height: 34,
                decoration: BoxDecoration(color: C.blue, borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text('S', style: TextStyle(color: C.white, fontSize: 18, fontWeight: FontWeight.w900)))),
              const SizedBox(width: 9),
              Text('StyleSphere', style: GoogleFonts.poppins(color: C.white, fontWeight: FontWeight.w700, fontSize: 16)),
            ]),
            // Skip
            GestureDetector(onTap: _skip, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Text('Skip', style: GoogleFonts.poppins(color: C.white, fontSize: 13, fontWeight: FontWeight.w500)),
            )),
          ],
        )),
      )),

      // Page dots (invisible pages — just for swiping)
      Positioned.fill(child: PageView.builder(
        controller: _pc, itemCount: _obPages.length,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (i) {
          setState(() => _cur = i);
          _fadeCtrl.reset();
          _fadeCtrl.forward();
        },
        itemBuilder: (_, __) => const SizedBox.expand(),
      )),

      // Bottom content
      Positioned(bottom: 0, left: 0, right: 0, child: SafeArea(
        child: Padding(padding: const EdgeInsets.fromLTRB(28, 0, 28, 36), child: FadeTransition(
          opacity: _fadeCtrl,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            // Tag pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(color: C.blue, borderRadius: BorderRadius.circular(20)),
              child: Text(page.tag, style: GoogleFonts.poppins(color: C.white, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 14),
            // Title
            Text(page.title, style: GoogleFonts.playfairDisplay(
              fontSize: 46, fontWeight: FontWeight.w800, color: C.white, height: 1.1)),
            const SizedBox(height: 12),
            // Subtitle
            Text(page.subtitle, style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.82), fontSize: 15, height: 1.55)),
            const SizedBox(height: 36),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
              // Indicators
              Row(children: List.generate(_obPages.length, (i) => AnimatedContainer(
                duration: 280.ms,
                margin: const EdgeInsets.only(right: 8),
                width: _cur == i ? 28 : 8, height: 8,
                decoration: BoxDecoration(
                  color: _cur == i ? C.white : Colors.white.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(4)),
              ))),
              // Next / Done button
              GestureDetector(onTap: _next, child: AnimatedContainer(
                duration: 220.ms,
                width: 60, height: 60,
                decoration: BoxDecoration(
                  color: _cur == _obPages.length - 1 ? C.blue : C.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: (_cur == _obPages.length - 1 ? C.blue : Colors.black).withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Icon(
                  _cur == _obPages.length - 1 ? Icons.check_rounded : Icons.arrow_forward_rounded,
                  color: _cur == _obPages.length - 1 ? C.white : C.blue, size: 26),
              )),
            ]),
          ]),
        )),
      )),
    ]));
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 10 · LOGIN SCREEN                       ║
// ╚══════════════════════════════════════════════════════════╝

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override ConsumerState<LoginScreen> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginScreen> {
  final _fk = GlobalKey<FormState>();
  final _ec = TextEditingController();
  final _pc = TextEditingController();
  bool _hide = true, _loading = false;

  @override void dispose() { _ec.dispose(); _pc.dispose(); super.dispose(); }

  Future<void> _login() async {
    if (!_fk.currentState!.validate()) return;
    setState(() => _loading = true);
    final ok = await ref.read(authProvider.notifier).signIn(_ec.text.trim(), _pc.text);
    if (mounted) setState(() => _loading = false);
    if (!ok && mounted) snack(context, 'Invalid credentials', err: true);
  }

  @override Widget build(BuildContext ctx) {
    final h = MediaQuery.of(ctx).size.height;
    return Scaffold(backgroundColor: C.white, body: Stack(children: [
      // Hero image top portion
      Positioned(top: 0, left: 0, right: 0, height: h * 0.42,
        child: Stack(children: [
          CachedNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800&q=80',
            fit: BoxFit.cover, width: double.infinity, height: h * 0.42,
            placeholder: (c, u) => Container(color: C.blueLight),
            errorWidget: (c, u, e) => Container(decoration: const BoxDecoration(gradient: C.blueGrad)),
          ),
          // Gradient overlay
          Container(decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.05), Colors.transparent],
              stops: const [0.0, 0.4, 1.0],
            ),
          )),
          // Top branding
          Positioned(top: MediaQuery.of(ctx).padding.top + 16, left: 24, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: Text('S', style: TextStyle(color: C.blue, fontSize: 20, fontWeight: FontWeight.w900)))),
                const SizedBox(width: 10),
                Text('StyleSphere', style: GoogleFonts.poppins(color: C.white, fontWeight: FontWeight.w700, fontSize: 18)),
              ]).animate().fadeIn(duration: 500.ms),
              const SizedBox(height: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3))),
                child: Text('Premium Fashion', style: GoogleFonts.poppins(color: C.white, fontSize: 12, fontWeight: FontWeight.w500)),
              ).animate().fadeIn(delay: 200.ms),
            ],
          )),
        ]),
      ),

      // White card form
      Positioned(top: h * 0.36, left: 0, right: 0, bottom: 0, child: Container(
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 24, offset: const Offset(0, -6))],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
          child: Form(key: _fk, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Welcome Back 👋', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: C.primary)),
            const SizedBox(height: 4),
            Text('Sign in to continue shopping', style: GoogleFonts.poppins(fontSize: 14, color: C.g500)),
            const SizedBox(height: 28),

            // Email field
            TextFormField(controller: _ec, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
              style: GoogleFonts.poppins(fontSize: 14, color: C.primary),
              decoration: InputDecoration(
                labelText: 'Email address',
                prefixIcon: const Icon(Icons.email_outlined, size: 20, color: C.g400),
                filled: true, fillColor: C.g50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: C.g200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: C.g200)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: C.blue, width: 1.5)),
              ),
              validator: (v) { if (v == null || v.isEmpty) return 'Email required'; if (!v.contains('@')) return 'Invalid email'; return null; },
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 14),

            // Password field
            TextFormField(controller: _pc, obscureText: _hide, textInputAction: TextInputAction.done, onFieldSubmitted: (_) => _login(),
              style: GoogleFonts.poppins(fontSize: 14, color: C.primary),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline, size: 20, color: C.g400),
                suffixIcon: IconButton(icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: C.g400, size: 20), onPressed: () => setState(() => _hide = !_hide)),
                filled: true, fillColor: C.g50,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: C.g200)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: C.g200)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: C.blue, width: 1.5)),
              ),
              validator: (v) { if (v == null || v.isEmpty) return 'Password required'; if (v.length < 6) return 'Min 6 characters'; return null; },
            ).animate().fadeIn(delay: 280.ms).slideY(begin: 0.1, end: 0),

            Align(alignment: Alignment.centerRight, child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: C.blue, padding: const EdgeInsets.symmetric(vertical: 8)),
              child: Text('Forgot Password?', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
            )),

            // Sign In button
            SizedBox(width: double.infinity, height: 52, child: ElevatedButton(
              onPressed: _loading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: C.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: _loading
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: C.white))
                : Text('Sign In', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: C.white)),
            )).animate().fadeIn(delay: 350.ms),

            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: Container(height: 1, color: C.g200)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text('or', style: GoogleFonts.poppins(fontSize: 13, color: C.g400))),
              Expanded(child: Container(height: 1, color: C.g200)),
            ]),
            const SizedBox(height: 20),

            // Google button
            SizedBox(width: double.infinity, height: 52, child: OutlinedButton(
              onPressed: _loading ? null : ref.read(authProvider.notifier).signInWithGoogle,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: C.g200),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                backgroundColor: C.g50,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 22, height: 22, decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF4285F4), Color(0xFF34A853), Color(0xFFFBBC05), Color(0xFFEA4335)]),
                  shape: BoxShape.circle),
                  child: const Center(child: Text('G', style: TextStyle(color: C.white, fontWeight: FontWeight.w800, fontSize: 12)))),
                const SizedBox(width: 10),
                Text('Continue with Google', style: GoogleFonts.poppins(color: C.primary, fontWeight: FontWeight.w500, fontSize: 14)),
              ]),
            )).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 28),
            Center(child: RichText(text: TextSpan(
              text: "Don't have an account? ",
              style: GoogleFonts.poppins(fontSize: 14, color: C.g500),
              children: [WidgetSpan(child: GestureDetector(
                onTap: () => ctx.push('/register'),
                child: Text('Sign Up', style: GoogleFonts.poppins(fontSize: 14, color: C.blue, fontWeight: FontWeight.w700)),
              ))],
            ))),
          ])),
        ),
      )),
    ]));
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 11 · REGISTER SCREEN                    ║
// ╚══════════════════════════════════════════════════════════╝

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override ConsumerState<RegisterScreen> createState() => _RegState();
}

class _RegState extends ConsumerState<RegisterScreen> {
  final _fk = GlobalKey<FormState>();
  final _nc = TextEditingController(); final _ec = TextEditingController();
  final _pc = TextEditingController(); final _cc = TextEditingController();
  bool _hp = true, _hc = true, _load = false, _agreed = false;
  @override void dispose() { _nc.dispose(); _ec.dispose(); _pc.dispose(); _cc.dispose(); super.dispose(); }

  Future<void> _reg() async {
    if (!_fk.currentState!.validate()) return;
    if (!_agreed) { snack(context, 'Please agree to Terms', err: true); return; }
    setState(() => _load = true);
    await ref.read(authProvider.notifier).signUp(_nc.text.trim(), _ec.text.trim(), _pc.text);
    if (mounted) setState(() => _load = false);
  }

  @override Widget build(BuildContext ctx) => Scaffold(backgroundColor: C.white, body: CustomScrollView(slivers: [
    SliverAppBar(backgroundColor: C.white, leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20), onPressed: () => ctx.pop())),
    SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 40), child: Form(key: _fk, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: C.blueLight, borderRadius: BorderRadius.circular(8)),
        child: Text('StyleSphere', style: GoogleFonts.poppins(color: C.blue, fontWeight: FontWeight.w600, fontSize: 12))),
      const SizedBox(height: 14),
      Text('Create Account', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w800, color: C.primary, height: 1.1))
        .animate().fadeIn().slideX(begin: -0.2, end: 0),
      const SizedBox(height: 6),
      Text('Join StyleSphere and explore your style ✨',
        style: GoogleFonts.poppins(fontSize: 14, color: C.g500))
        .animate().fadeIn(delay: 100.ms),
      const SizedBox(height: 28),

      ...[
        TextFormField(controller: _nc, textCapitalization: TextCapitalization.words, textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline, size: 20)),
          validator: (v) { if (v == null || v.trim().isEmpty) return 'Name required'; return null; }),
        const SizedBox(height: 14),
        TextFormField(controller: _ec, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined, size: 20)),
          validator: (v) { if (v == null || v.isEmpty) return 'Email required'; if (!v.contains('@')) return 'Invalid email'; return null; }),
        const SizedBox(height: 14),
        TextFormField(controller: _pc, obscureText: _hp, textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline, size: 20),
            suffixIcon: IconButton(icon: Icon(_hp ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: C.g400), onPressed: () => setState(() => _hp = !_hp))),
          validator: (v) { if (v == null || v.isEmpty) return 'Password required'; if (v.length < 6) return 'Min 6 characters'; return null; }),
        const SizedBox(height: 14),
        TextFormField(controller: _cc, obscureText: _hc, textInputAction: TextInputAction.done,
          decoration: InputDecoration(labelText: 'Confirm Password', prefixIcon: const Icon(Icons.lock_outline, size: 20),
            suffixIcon: IconButton(icon: Icon(_hc ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: C.g400), onPressed: () => setState(() => _hc = !_hc))),
          validator: (v) { if (v != _pc.text) return 'Passwords do not match'; return null; }),
      ].asMap().entries.map((e) => e.value is SizedBox ? e.value : (e.value as Widget).animate().fadeIn(delay: (200 + e.key * 50).ms).slideY(begin: 0.15, end: 0)).toList(),

      const SizedBox(height: 16),
      Row(children: [Checkbox(value: _agreed, onChanged: (v) => setState(() => _agreed = v ?? false)),
        Expanded(child: RichText(text: TextSpan(text: 'I agree to the ',
          style: GoogleFonts.poppins(fontSize: 13, color: C.g600),
          children: [const TextSpan(text: 'Terms of Service', style: TextStyle(color: C.blue, fontWeight: FontWeight.w600)),
            const TextSpan(text: ' & '),
            const TextSpan(text: 'Privacy Policy', style: TextStyle(color: C.blue, fontWeight: FontWeight.w600))])))]),
      const SizedBox(height: 24),
      Btn(text: 'Create Account', loading: _load, onPressed: _reg).animate().fadeIn(delay: 450.ms),
      const SizedBox(height: 22),
      Center(child: RichText(text: TextSpan(text: 'Already have an account? ',
        style: GoogleFonts.poppins(fontSize: 14, color: C.g500),
        children: [WidgetSpan(child: GestureDetector(onTap: () => ctx.pop(),
          child: Text('Sign In', style: GoogleFonts.poppins(fontSize: 14, color: C.blue, fontWeight: FontWeight.w700))))]))),
    ])))),
  ]));
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 12 · HOME SCREEN                        ║
// ╚══════════════════════════════════════════════════════════╝

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final user      = ref.watch(authProvider).valueOrNull;
    final newArrs   = kProducts.where((p) => p.isNew).take(6).toList();
    final featured  = kProducts.where((p) => p.isFeatured).take(6).toList();

    return Scaffold(backgroundColor: C.bg, body: CustomScrollView(slivers: [
      // — AppBar —
      SliverAppBar(
        pinned: true, floating: true, expandedHeight: 0,
        backgroundColor: C.white, automaticallyImplyLeading: false,
        title: Row(children: [
          Container(width: 32, height: 32,
            decoration: BoxDecoration(color: C.blue, borderRadius: BorderRadius.circular(9)),
            child: const Center(child: Text('S', style: TextStyle(color: C.white, fontSize: 18, fontWeight: FontWeight.w900)))),
          const SizedBox(width: 9),
          Text('StyleSphere', style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: C.primary)),
        ]),
        actions: [
          IconButton(icon: const Icon(Icons.qr_code_scanner_rounded, color: C.g700), onPressed: () => ctx.push('/qr-scanner'), tooltip: 'Rack Scanner'),
          IconButton(icon: const Icon(Icons.search_rounded, color: C.g700), onPressed: () => ctx.go('/explore')),
          const SizedBox(width: 4),
        ],
      ),

      SliverToBoxAdapter(child: Column(children: [
        // — Delivery Location Bar —
        Padding(padding: const EdgeInsets.fromLTRB(16, 14, 16, 0), child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: C.white, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: C.g200),
            boxShadow: [BoxShadow(color: C.shadow, blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Row(children: [
            Container(width: 28, height: 28, decoration: BoxDecoration(color: C.blueLight, shape: BoxShape.circle),
              child: const Icon(Icons.location_on_outlined, color: C.blue, size: 16)),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Send to', style: GoogleFonts.poppins(fontSize: 10, color: C.g400, fontWeight: FontWeight.w500)),
              Text(user?.defaultAddress?.short ?? 'Set delivery address',
                style: GoogleFonts.poppins(fontSize: 12, color: C.primary, fontWeight: FontWeight.w600)),
            ])),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: C.blue, foregroundColor: C.white, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              child: const Text('Change'),
            ),
          ]),
        )),

        // — Banner Slider —
        const SizedBox(height: 14),
        _BannerSlider(),

        // — Categories —
        Padding(padding: const EdgeInsets.fromLTRB(16, 20, 16, 0), child: Column(children: [
          SecHeader(title: 'Categories', onAll: () => ctx.go('/explore')),
          const SizedBox(height: 14),
          Row(children: kCategories.map((cat) => Expanded(child: GestureDetector(
            onTap: () { ref.read(filterProvider.notifier).update((s) => s.copyWith(category: cat.name)); ctx.go('/explore'); },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: cat.bgColor, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: cat.color.withOpacity(0.15)),
              ),
              child: Column(children: [
                Text(cat.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 4),
                Text(cat.name, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: cat.color)),
              ]),
            ),
          ))).toList()),
        ])),

        // — Popular Brands —
        Padding(padding: const EdgeInsets.fromLTRB(16, 20, 16, 0), child: Column(children: [
          SecHeader(title: 'Popular Brands', onAll: () => ctx.go('/explore')),
          const SizedBox(height: 12),
          SizedBox(height: 80, child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: EdgeInsets.zero,
            itemCount: kBrands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final b = kBrands[i];
              return Container(
                width: 72, padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: C.white, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: C.g200),
                  boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6, offset: const Offset(0, 2))],
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 34, height: 34, decoration: const BoxDecoration(color: C.g50, shape: BoxShape.circle),
                    child: Center(child: Text(b.name[0], style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800, color: C.primary)))),
                  const SizedBox(height: 4),
                  Text(b.name, style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.w600, color: C.g600), overflow: TextOverflow.ellipsis),
                ]),
              );
            },
          )),
        ])),

        // — Featured —
        Padding(padding: const EdgeInsets.fromLTRB(16, 20, 16, 0), child: Column(children: [
          SecHeader(title: 'Featured', onAll: () => ctx.go('/explore')),
          const SizedBox(height: 12),
          SizedBox(height: 245, child: ListView.separated(
            scrollDirection: Axis.horizontal, padding: EdgeInsets.zero,
            itemCount: featured.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => _ProdCard(featured[i], wide: true),
          )),
        ])),

        // — New Arrivals —
        Padding(padding: const EdgeInsets.fromLTRB(16, 20, 16, 20), child: Column(children: [
          SecHeader(title: 'New Arrivals', onAll: () => ctx.go('/explore')),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.71, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemCount: newArrs.length,
            itemBuilder: (_, i) => _ProdCard(newArrs[i]),
          ),
        ])),
      ])),
    ]));
  }
}

// Banner Slider
class _BannerSlider extends StatefulWidget {
  @override State<_BannerSlider> createState() => _BSState();
}

class _BSState extends State<_BannerSlider> {
  final _ctrl = PageController();
  int _cur = 0;
  Timer? _timer;
  @override void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_cur + 1) % kBanners.length;
      _ctrl.animateToPage(next, duration: 500.ms, curve: Curves.easeInOutCubic);
    });
  }
  @override void dispose() { _timer?.cancel(); _ctrl.dispose(); super.dispose(); }

  @override Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(children: [
      SizedBox(height: 180, child: PageView.builder(
        controller: _ctrl, itemCount: kBanners.length,
        onPageChanged: (i) => setState(() => _cur = i),
        itemBuilder: (_, i) {
          final b = kBanners[i];
          return GestureDetector(onTap: () => context.go(b.route), child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(children: [
              CachedNetworkImage(imageUrl: b.imageUrl, width: double.infinity, height: 180, fit: BoxFit.cover,
                placeholder: (c, u) => Container(color: C.blueLight),
                errorWidget: (c, u, e) => Container(decoration: const BoxDecoration(gradient: C.blueGrad))),
              Container(decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.centerRight, end: Alignment.centerLeft,
                colors: [C.blueDark.withOpacity(0.9), C.blueDark.withOpacity(0.6), Colors.transparent],
                stops: const [0.0, 0.5, 1.0],
              ))),
              Padding(padding: const EdgeInsets.all(20), child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                    child: Text(b.tag, style: GoogleFonts.poppins(color: C.white, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1))),
                  const SizedBox(height: 6),
                  Text(b.title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: C.white, height: 1.2)),
                  const SizedBox(height: 4),
                  Text(b.subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white.withOpacity(0.85))),
                  const SizedBox(height: 12),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(20)),
                    child: Text(b.actionLabel, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: C.blue))),
                ],
              )),
            ]),
          ));
        },
      )),
      const SizedBox(height: 10),
      AnimatedSmoothIndicator(activeIndex: _cur, count: kBanners.length,
        effect: const WormEffect(dotHeight: 6, dotWidth: 6, activeDotColor: C.blue, dotColor: C.g300, spacing: 6)),
    ]),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 13 · PRODUCT CARD                       ║
// ╚══════════════════════════════════════════════════════════╝

class _ProdCard extends ConsumerWidget {
  final Product p; final bool wide;
  const _ProdCard(this.p, {this.wide = false});

  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final inWish = ref.watch(inWishlistProvider(p.id));
    return GestureDetector(
      onTap: () { ref.read(recentlyViewedProvider.notifier).add(p); ctx.push('/product/${p.id}', extra: p); },
      child: Container(
        width: wide ? 155 : null,
        decoration: BoxDecoration(
          color: C.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: C.shadowMd, blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Image
          Stack(children: [
            ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Img(p.images.first, w: double.infinity, h: wide ? 140 : 140)),
            // Badges
            Positioned(top: 8, left: 8, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (p.hasDiscount) SaleBadge(pct: p.discount),
              if (p.isNew) ...[const SizedBox(height: 4), const NewBadge()],
            ])),
            // Wishlist
            Positioned(top: 6, right: 6, child: GestureDetector(
              onTap: () => ref.read(wishlistProvider.notifier).toggle(p),
              child: Container(padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: C.white.withOpacity(0.95), shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: C.shadowMd, blurRadius: 4)]),
                child: Icon(inWish ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: inWish ? C.red : C.g400, size: 16)),
            )),
          ]),
          // Info
          Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(10, 9, 10, 10), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            // Brand + rating row
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Text(p.brand,
                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500, color: C.g500),
                overflow: TextOverflow.ellipsis)),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 11),
                const SizedBox(width: 2),
                Text(p.rating.toStringAsFixed(1), style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: C.g700)),
              ]),
            ]),
            const SizedBox(height: 2),
            Text(p.name,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: C.primary),
              maxLines: 1, overflow: TextOverflow.ellipsis),
            const Spacer(),
            // Price
            Row(children: [
              Text('\$${p.price.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: C.primary)),
              if (p.hasDiscount) ...[const SizedBox(width: 5),
                Text('\$${p.originalPrice!.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(fontSize: 10, color: C.g400, decoration: TextDecoration.lineThrough))],
            ]),
          ]))),
        ]),
      ),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 14 · EXPLORE SCREEN                     ║
// ╚══════════════════════════════════════════════════════════╝

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});
  @override ConsumerState<ExploreScreen> createState() => _ExploreState();
}

class _ExploreState extends ConsumerState<ExploreScreen> {
  final _sc = TextEditingController();
  @override void dispose() { _sc.dispose(); super.dispose(); }

  @override Widget build(BuildContext ctx) {
    final products = ref.watch(filteredProductsProvider);
    final filter   = ref.watch(filterProvider);
    return Scaffold(backgroundColor: C.bg, body: CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true, floating: true, backgroundColor: C.white,
        automaticallyImplyLeading: false, title: const Text('Explore'),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(60), child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10), child: Row(children: [
          Expanded(child: Container(
            decoration: BoxDecoration(color: C.g50, borderRadius: BorderRadius.circular(12), border: Border.all(color: C.g200)),
            child: TextField(controller: _sc,
              onChanged: (q) => ref.read(filterProvider.notifier).update((s) => s.copyWith(search: q.isEmpty ? null : q)),
              style: GoogleFonts.poppins(fontSize: 14, color: C.primary),
              decoration: InputDecoration(
                hintText: 'Search brands, clothes...',
                hintStyle: GoogleFonts.poppins(fontSize: 14, color: C.g400),
                prefixIcon: const Icon(Icons.search_rounded, color: C.g400, size: 20),
                border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none,
                filled: false, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                suffixIcon: _sc.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear, size: 18, color: C.g400),
                  onPressed: () { _sc.clear(); ref.read(filterProvider.notifier).update((s) => s.copyWith(clearSearch: true)); setState(() {}); }) : null,
              )),
          )),
          const SizedBox(width: 10),
          GestureDetector(onTap: () => _showFilters(ctx), child: AnimatedContainer(duration: 200.ms,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(color: filter.hasFilters ? C.blue : C.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: filter.hasFilters ? C.blue : C.g200)),
            child: Icon(Icons.tune_rounded, color: filter.hasFilters ? C.white : C.g700, size: 22))),
        ]))),
        actions: [
          PopupMenuButton<String>(icon: const Icon(Icons.sort_rounded, color: C.g700),
            onSelected: (v) => ref.read(filterProvider.notifier).update((s) => s.copyWith(sortBy: v)),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'popularity', child: Text('Popularity')),
              const PopupMenuItem(value: 'price_low', child: Text('Price: Low to High')),
              const PopupMenuItem(value: 'price_high', child: Text('Price: High to Low')),
              const PopupMenuItem(value: 'newest', child: Text('Newest First')),
              const PopupMenuItem(value: 'rating', child: Text('Top Rated')),
            ]),
        ],
      ),

      // Category chips
      SliverToBoxAdapter(child: SingleChildScrollView(scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Row(children: [
          _CatChip('All', filter.category == null, () => ref.read(filterProvider.notifier).update((s) => s.copyWith(clearCategory: true))),
          ...['Men', 'Women', 'Kids', 'Accessories'].map((c) => _CatChip(c, filter.category == c,
            () => ref.read(filterProvider.notifier).update((s) => s.copyWith(category: c)))),
        ]),
      )),

      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
        child: Text('${products.length} items found', style: GoogleFonts.poppins(fontSize: 12, color: C.g500)))),

      products.isEmpty
        ? SliverFillRemaining(child: EmptyView(icon: Icons.search_off_rounded, title: 'No results found',
            desc: 'Try adjusting your search or filters', btnLabel: 'Clear Filters',
            onBtn: () => ref.read(filterProvider.notifier).update((_) => const PFilter())))
        : SliverPadding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((c, i) => _ProdCard(products[i]), childCount: products.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.71, crossAxisSpacing: 12, mainAxisSpacing: 12),
            )),
    ]));
  }

  void _showFilters(BuildContext ctx) => showModalBottomSheet(
    context: ctx, isScrollControlled: true, backgroundColor: Colors.transparent,
    builder: (_) => const _FilterSheet(),
  );
}

class _CatChip extends StatelessWidget {
  final String label; final bool selected; final VoidCallback onTap;
  const _CatChip(this.label, this.selected, this.onTap);
  @override Widget build(BuildContext ctx) => GestureDetector(onTap: onTap, child: AnimatedContainer(duration: 200.ms,
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    decoration: BoxDecoration(
      color: selected ? C.blue : C.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: selected ? C.blue : C.g200),
      boxShadow: selected ? [BoxShadow(color: C.blue.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 3))] : [],
    ),
    child: Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: selected ? C.white : C.g700))));
}

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet();
  @override ConsumerState<_FilterSheet> createState() => _FSState();
}

class _FSState extends ConsumerState<_FilterSheet> {
  late PFilter _f;
  @override void initState() { super.initState(); _f = ref.read(filterProvider); }
  void _toggleSize(String s) => setState(() => _f = _f.copyWith(sizes: _f.sizes.contains(s) ? _f.sizes.where((x) => x != s).toList() : [..._f.sizes, s]));

  @override Widget build(BuildContext ctx) => Container(
    decoration: const BoxDecoration(color: C.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
    child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: C.g200, borderRadius: BorderRadius.circular(2)))),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Filters', style: Theme.of(ctx).textTheme.headlineMedium),
        TextButton(onPressed: () => setState(() => _f = const PFilter()), child: const Text('Clear All', style: TextStyle(color: C.blue))),
      ]),
      const SizedBox(height: 16),
      Text('Sizes', style: Theme.of(ctx).textTheme.titleMedium),
      const SizedBox(height: 10),
      Wrap(spacing: 10, runSpacing: 10, children: ['XS','S','M','L','XL','XXL'].map((s) => GestureDetector(
        onTap: () => _toggleSize(s),
        child: AnimatedContainer(duration: 200.ms,
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: _f.sizes.contains(s) ? C.blue : C.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _f.sizes.contains(s) ? C.blue : C.g300),
          ),
          child: Center(child: Text(s, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
            color: _f.sizes.contains(s) ? C.white : C.primary)))),
      )).toList()),
      const SizedBox(height: 18),
      Text('Price Range', style: Theme.of(ctx).textTheme.titleMedium),
      RangeSlider(
        values: RangeValues(_f.minPrice ?? 0, _f.maxPrice ?? 500),
        min: 0, max: 500,
        onChanged: (v) => setState(() => _f = _f.copyWith(minPrice: v.start, maxPrice: v.end)),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('\$${(_f.minPrice ?? 0).toInt()}', style: Theme.of(ctx).textTheme.bodySmall),
        Text('\$${(_f.maxPrice ?? 500).toInt()}', style: Theme.of(ctx).textTheme.bodySmall),
      ]),
      const SizedBox(height: 20),
      Btn(text: 'Apply Filters', onPressed: () { ref.read(filterProvider.notifier).state = _f; Navigator.pop(ctx); }),
    ])),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 15 · PRODUCT DETAIL                     ║
// ╚══════════════════════════════════════════════════════════╝

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductDetailScreen({super.key, this.product});
  @override ConsumerState<ProductDetailScreen> createState() => _PDState();
}

class _PDState extends ConsumerState<ProductDetailScreen> {
  int _imgIdx = 0;
  String? _selSize;
  String? _selColor;
  late PageController _pc;

  @override void initState() { super.initState(); _pc = PageController(); }
  @override void dispose() { _pc.dispose(); super.dispose(); }

  @override Widget build(BuildContext ctx) {
    final p = widget.product;
    if (p == null) return const Scaffold(body: Center(child: Text('Product not found')));
    final inWish = ref.watch(inWishlistProvider(p.id));
    final size   = MediaQuery.of(ctx).size;

    return Scaffold(backgroundColor: C.white, body: Stack(children: [
      // Main scrollable content
      CustomScrollView(slivers: [
        // Image gallery
        SliverAppBar(
          expandedHeight: size.height * 0.50,
          pinned: true, backgroundColor: C.white,
          leading: GestureDetector(onTap: () => ctx.pop(), child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: C.white.withOpacity(0.9), shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: C.shadowMd, blurRadius: 8)]),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: C.primary))),
          actions: [
            GestureDetector(onTap: () => ref.read(wishlistProvider.notifier).toggle(p), child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: C.white.withOpacity(0.9), shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: C.shadowMd, blurRadius: 8)]),
              child: Padding(padding: const EdgeInsets.all(7),
                child: Icon(inWish ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: inWish ? C.red : C.g500, size: 20)))),
            const SizedBox(width: 4),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(children: [
              // Images
              PageView.builder(controller: _pc, itemCount: p.images.length,
                onPageChanged: (i) => setState(() => _imgIdx = i),
                itemBuilder: (_, i) => Container(
                  color: C.g50,
                  child: CachedNetworkImage(imageUrl: p.images[i], fit: BoxFit.contain,
                    width: double.infinity, height: size.height * 0.50,
                    placeholder: (c, u) => Shimmer.fromColors(baseColor: C.g100, highlightColor: C.g50,
                      child: Container(color: C.g100)),
                    errorWidget: (c, u, e) => Container(color: C.g50,
                      child: const Icon(Icons.image_outlined, size: 48, color: C.g300)))),
              ),
              // Image indicator — centered at bottom like reference "1/8"
              Positioned(bottom: 14, left: 0, right: 0, child: Center(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), borderRadius: BorderRadius.circular(20)),
                child: Text('${_imgIdx + 1}/${p.images.length}',
                  style: GoogleFonts.poppins(color: C.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ))),
            ]),
          ),
        ),

        // Product details
        SliverToBoxAdapter(child: Container(
          decoration: const BoxDecoration(color: C.white),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Brand + rating row
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(width: 22, height: 22, decoration: BoxDecoration(color: C.g100, shape: BoxShape.circle),
                  child: Center(child: Text(p.brand[0], style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: C.primary)))),
                const SizedBox(width: 6),
                Text(p.brand, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: C.g700)),
              ]),
              Stars(rating: p.rating, sz: 14),
            ]),
            const SizedBox(height: 8),

            // Product name
            Text(p.name, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: C.primary, height: 1.2)),
            const SizedBox(height: 10),

            // Price + discount + sold count
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text('\$${p.price.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: C.primary)),
              if (p.hasDiscount) ...[const SizedBox(width: 8),
                Text('\$${p.originalPrice!.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(fontSize: 14, color: C.g400, decoration: TextDecoration.lineThrough)),
                const SizedBox(width: 8),
                SaleBadge(pct: p.discount)],
              const Spacer(),
              if (p.soldCount > 0) Text('${p.soldCount}+ Sold',
                style: GoogleFonts.poppins(fontSize: 12, color: C.g500, fontWeight: FontWeight.w500)),
            ]),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Size selector
            Text('Size:', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: C.primary)),
            const SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 10, children: p.sizes.map((s) => GestureDetector(
              onTap: () => setState(() => _selSize = s),
              child: AnimatedContainer(duration: 200.ms,
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: _selSize == s ? C.blue : C.g50,
                  shape: BoxShape.circle,
                  border: Border.all(color: _selSize == s ? C.blue : C.g200, width: _selSize == s ? 2 : 1),
                  boxShadow: _selSize == s ? [BoxShadow(color: C.blue.withOpacity(0.3), blurRadius: 8)] : [],
                ),
                child: Center(child: Text(s, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600,
                  color: _selSize == s ? C.white : C.g700)))),
            )).toList()),
            const SizedBox(height: 18),

            // Color selector
            Text('Color', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: C.primary)),
            const SizedBox(height: 10),
            Wrap(spacing: 12, runSpacing: 10, children: p.colors.map((c) {
              final col = _colorMap[c] ?? C.g300;
              final sel = _selColor == c;
              final isLight = col.computeLuminance() > 0.75;
              return GestureDetector(
                onTap: () => setState(() => _selColor = c),
                child: AnimatedContainer(duration: 200.ms,
                  width: 36, height: 36, decoration: BoxDecoration(
                    color: col, shape: BoxShape.circle,
                    border: Border.all(color: sel ? C.blue : (isLight ? C.g300 : Colors.transparent), width: sel ? 2.5 : 1),
                    boxShadow: sel ? [BoxShadow(color: C.blue.withOpacity(0.35), blurRadius: 8, spreadRadius: 1)] : [],
                  ),
                  child: sel ? Icon(Icons.check_rounded, color: isLight ? C.primary : C.white, size: 18) : null),
              );
            }).toList()),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Description
            Text('Description', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: C.primary)),
            const SizedBox(height: 8),
            Text(p.description, style: GoogleFonts.poppins(fontSize: 14, color: C.g600, height: 1.65)),
            const SizedBox(height: 20),

            // Product details
            if (p.details.isNotEmpty) ...[
              Text('Product Details', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: C.primary)),
              const SizedBox(height: 12),
              Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: C.g50, borderRadius: BorderRadius.circular(12)),
                child: Column(children: p.details.entries.map((e) => Padding(padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    SizedBox(width: 90, child: Text(e.key, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: C.g500))),
                    Expanded(child: Text(e.value, style: GoogleFonts.poppins(fontSize: 12, color: C.primary))),
                  ]))).toList())),
              const SizedBox(height: 20),
            ],

            // Virtual Try-On banner
            Container(padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: C.blueLight, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: C.blue.withOpacity(0.2)),
              ),
              child: Row(children: [
                Container(width: 42, height: 42, decoration: BoxDecoration(color: C.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.camera_alt_rounded, color: C.white, size: 22)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Virtual Try-On', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: C.blueDark, fontSize: 14)),
                  Text('See how it looks on you', style: GoogleFonts.poppins(color: C.blue, fontSize: 12)),
                ])),
                ElevatedButton(
                  onPressed: () => ctx.push('/try-on', extra: p),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: C.blue, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: Text('Try It', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: C.white)),
                ),
              ]),
            ),
          ]),
        )),
      ]),

      // Bottom CTA bar
      Positioned(bottom: 0, left: 0, right: 0, child: Container(
        decoration: BoxDecoration(
          color: C.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -4))],
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: SafeArea(child: Row(children: [
          // Add to cart button (outlined)
          Expanded(flex: 1, child: SizedBox(height: 50, child: OutlinedButton(
            onPressed: () {
              if (_selSize == null) { snack(context, 'Please select a size', err: true); return; }
              ref.read(cartProvider.notifier).add(p, _selSize!, _selColor ?? p.colors.first);
              snack(context, '${p.name} added to cart', action: 'View Cart', onAction: () => context.go('/cart'));
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              side: const BorderSide(color: C.g300, width: 1.5),
            ),
            child: Text('Add to cart', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: C.primary)),
          ))),
          const SizedBox(width: 12),
          // Buy now button
          Expanded(flex: 1, child: SizedBox(height: 50, child: ElevatedButton(
            onPressed: () {
              if (_selSize == null) { snack(context, 'Please select a size', err: true); return; }
              ref.read(cartProvider.notifier).add(p, _selSize!, _selColor ?? p.colors.first);
              ctx.push('/checkout');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: C.blueDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              elevation: 0,
            ),
            child: Text('Buy now', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: C.white)),
          ))),
        ])),
      )),
    ]));
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 16 · CART SCREEN                        ║
// ╚══════════════════════════════════════════════════════════╝

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});
  @override ConsumerState<CartScreen> createState() => _CartState();
}

class _CartState extends ConsumerState<CartScreen> {
  final _promoCtrl = TextEditingController();
  double _discount = 0;
  @override void dispose() { _promoCtrl.dispose(); super.dispose(); }

  @override Widget build(BuildContext ctx) {
    final items    = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final sub  = notifier.subtotal;
    final ship = notifier.shipping;
    final tot  = sub - _discount + ship;

    if (items.isEmpty) return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(title: const Text('My Cart'), backgroundColor: C.white, automaticallyImplyLeading: false),
      body: EmptyView(icon: Icons.shopping_bag_outlined, title: 'Your cart is empty',
        desc: "Looks like you haven't added anything yet.",
        btnLabel: 'Start Shopping', onBtn: () => ctx.go('/explore')));

    return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(title: const Text('My Cart'), backgroundColor: C.white, automaticallyImplyLeading: false,
        actions: [TextButton(onPressed: () { ref.read(cartProvider.notifier).clear(); setState(() => _discount = 0); },
          child: const Text('Clear', style: TextStyle(color: C.red)))]),
      body: Column(children: [
        Expanded(child: ListView.separated(padding: const EdgeInsets.all(16), itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) { final item = items[i]; return _CartTile(item,
            onRemove: () => ref.read(cartProvider.notifier).remove(item.id),
            onQtyChange: (q) => ref.read(cartProvider.notifier).updateQty(item.id, q)); })),

        Container(padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(color: C.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))]),
          child: Column(children: [
            Row(children: [
              Expanded(child: TextField(controller: _promoCtrl,
                style: GoogleFonts.poppins(fontSize: 14),
                decoration: InputDecoration(hintText: 'Promo code', hintStyle: GoogleFonts.poppins(color: C.g400, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: C.g200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: C.g200)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: C.blue))))),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () {
                if (_promoCtrl.text == 'STYLE20') { setState(() => _discount = sub * 0.2); snack(ctx, '20% discount applied! 🎉'); }
                else snack(ctx, 'Invalid promo code', err: true);
              }, child: const Text('Apply')),
            ]),
            const SizedBox(height: 14),
            _SumRow('Subtotal', '\$${sub.toStringAsFixed(2)}'),
            if (_discount > 0) _SumRow('Discount (STYLE20)', '-\$${_discount.toStringAsFixed(2)}', valueColor: C.success),
            _SumRow('Shipping', ship == 0 ? 'FREE' : '\$${ship.toStringAsFixed(2)}', valueColor: ship == 0 ? C.success : null),
            const Divider(height: 20),
            _SumRow('Total', '\$${tot.toStringAsFixed(2)}', bold: true),
            const SizedBox(height: 14),
            SafeArea(child: Btn(text: 'Proceed to Checkout', onPressed: () => ctx.push('/checkout'))),
            const SizedBox(height: 8),
          ])),
      ]),
    );
  }
}

Widget _SumRow(String label, String val, {Color? valueColor, bool bold = false}) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: GoogleFonts.poppins(fontSize: 14, color: C.g600, fontWeight: bold ? FontWeight.w600 : FontWeight.w400)),
    Text(val, style: GoogleFonts.poppins(fontSize: 14, fontWeight: bold ? FontWeight.w700 : FontWeight.w500, color: valueColor ?? C.primary)),
  ]),
);

class _CartTile extends StatelessWidget {
  final CartItem item; final VoidCallback onRemove; final ValueChanged<int> onQtyChange;
  const _CartTile(this.item, {required this.onRemove, required this.onQtyChange});
  @override Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: C.shadow, blurRadius: 8, offset: const Offset(0, 3))]),
    child: Row(children: [
      Container(width: 80, height: 90, decoration: BoxDecoration(color: C.g50, borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(borderRadius: BorderRadius.circular(10),
          child: Img(item.product.images.first, w: 80, h: 90, fit: BoxFit.contain))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(item.product.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: C.primary), maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 3),
        Text('${item.selectedSize} · ${item.selectedColor}', style: GoogleFonts.poppins(fontSize: 11, color: C.g400)),
        const SizedBox(height: 6),
        Text('\$${item.product.price.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: C.primary)),
      ])),
      Column(children: [
        IconButton(icon: const Icon(Icons.delete_outline_rounded, color: C.g300, size: 20), onPressed: onRemove, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        const SizedBox(height: 8),
        Row(children: [
          _QBtn(Icons.remove, () => onQtyChange(item.quantity - 1)),
          SizedBox(width: 32, child: Text('${item.quantity}', textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14))),
          _QBtn(Icons.add, () => onQtyChange(item.quantity + 1)),
        ]),
      ]),
    ]),
  );
}

class _QBtn extends StatelessWidget {
  final IconData ic; final VoidCallback onTap;
  const _QBtn(this.ic, this.onTap);
  @override Widget build(BuildContext ctx) => GestureDetector(onTap: onTap,
    child: Container(width: 28, height: 28, decoration: BoxDecoration(color: C.g100, borderRadius: BorderRadius.circular(7)),
      child: Icon(ic, size: 16, color: C.primary)));
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 17 · WISHLIST SCREEN                    ║
// ╚══════════════════════════════════════════════════════════╝

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});
  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final items = ref.watch(wishlistProvider);
    return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(title: const Text('Wishlist'), backgroundColor: C.white, automaticallyImplyLeading: false),
      body: items.isEmpty
        ? EmptyView(icon: Icons.favorite_border_rounded, title: 'Your wishlist is empty',
            desc: 'Save items you love here.', btnLabel: 'Explore Now', onBtn: () => ctx.go('/explore'))
        : GridView.builder(padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.71, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemCount: items.length, itemBuilder: (_, i) => _ProdCard(items[i])),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 18 · CHECKOUT SCREEN                    ║
// ╚══════════════════════════════════════════════════════════╝

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});
  @override ConsumerState<CheckoutScreen> createState() => _COState();
}

class _COState extends ConsumerState<CheckoutScreen> {
  int _step = 0, _payment = 0;
  bool _placing = false;
  static const _payments = ['Cash on Delivery', 'Card Payment'];

  @override Widget build(BuildContext ctx) {
    final user  = ref.watch(authProvider).valueOrNull;
    final items = ref.watch(cartProvider);
    final sub   = ref.read(cartProvider.notifier).subtotal;
    final ship  = ref.read(cartProvider.notifier).shipping;
    final tot   = sub + ship;
    final addr  = user?.defaultAddress;

    return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(title: const Text('Checkout'), backgroundColor: C.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20), onPressed: () => ctx.pop())),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Stepper
        Row(children: ['Address', 'Payment', 'Review'].asMap().entries.map((e) => Expanded(child: Row(children: [
          Expanded(child: Column(children: [
            Container(width: 28, height: 28,
              decoration: BoxDecoration(color: _step >= e.key ? C.blue : C.g200, shape: BoxShape.circle),
              child: Center(child: _step > e.key
                ? const Icon(Icons.check, color: C.white, size: 16)
                : Text('${e.key+1}', style: TextStyle(color: _step >= e.key ? C.white : C.g500, fontSize: 12, fontWeight: FontWeight.w700)))),
            const SizedBox(height: 4),
            Text(e.value, style: GoogleFonts.poppins(fontSize: 10, color: _step >= e.key ? C.blue : C.g400, fontWeight: FontWeight.w500)),
          ])),
          if (e.key < 2) Expanded(child: Container(height: 2, color: _step > e.key ? C.blue : C.g200)),
        ]))).toList()),
        const SizedBox(height: 24),

        if (_step == 0) ...[
          Text('Delivery Address', style: Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height: 12),
          if (addr != null) Container(padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14),
              border: Border.all(color: C.blue, width: 1.5),
              boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: C.blueLight, shape: BoxShape.circle),
                child: const Icon(Icons.location_on_outlined, color: C.blue)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(addr.name, style: Theme.of(ctx).textTheme.titleMedium),
                Text(addr.full, style: Theme.of(ctx).textTheme.bodySmall?.copyWith(height: 1.5)),
                Text(addr.phone, style: Theme.of(ctx).textTheme.bodySmall),
              ])),
              const Icon(Icons.check_circle_rounded, color: C.blue),
            ])),
          const SizedBox(height: 28),
          Btn(text: 'Continue to Payment', onPressed: () => setState(() => _step = 1)),
        ],

        if (_step == 1) ...[
          Text('Payment Method', style: Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height: 12),
          ..._payments.asMap().entries.map((e) => GestureDetector(
            onTap: () => setState(() => _payment = e.key),
            child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _payment == e.key ? C.blue : C.g200, width: _payment == e.key ? 1.5 : 1),
                boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]),
              child: Row(children: [
                Icon(_payment == e.key ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
                  color: _payment == e.key ? C.blue : C.g300),
                const SizedBox(width: 12),
                Icon(e.key == 0 ? Icons.local_shipping_outlined : Icons.credit_card_rounded, color: C.primary),
                const SizedBox(width: 10),
                Text(e.value, style: Theme.of(ctx).textTheme.titleMedium),
              ])),
          )),
          Row(children: [
            Expanded(child: OutBtn(text: 'Back', onPressed: () => setState(() => _step = 0))),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: Btn(text: 'Review Order', onPressed: () => setState(() => _step = 2))),
          ]),
        ],

        if (_step == 2) ...[
          Text('Order Summary', style: Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]),
            child: Row(children: [
              Container(width: 56, height: 64, decoration: BoxDecoration(color: C.g50, borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Img(item.product.images.first, w: 56, h: 64, fit: BoxFit.contain))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.product.name, style: Theme.of(ctx).textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${item.selectedSize} × ${item.quantity}', style: Theme.of(ctx).textTheme.bodySmall),
              ])),
              Text('\$${item.total.toStringAsFixed(2)}', style: Theme.of(ctx).textTheme.titleSmall?.copyWith(color: C.primary)),
            ])))),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]), child: Column(children: [
            _SumRow('Subtotal', '\$${sub.toStringAsFixed(2)}'),
            _SumRow('Shipping', ship == 0 ? 'FREE' : '\$${ship.toStringAsFixed(2)}', valueColor: ship == 0 ? C.success : null),
            const Divider(height: 16),
            _SumRow('Total', '\$${tot.toStringAsFixed(2)}', bold: true),
          ])),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: OutBtn(text: 'Back', onPressed: () => setState(() => _step = 1))),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: Btn(text: 'Place Order', loading: _placing, onPressed: () async {
              setState(() => _placing = true);
              if (addr == null) { setState(() => _placing = false); return; }
              final order = await ref.read(ordersProvider.notifier).place(items: items, address: addr, payment: _payments[_payment]);
              ref.read(cartProvider.notifier).clear();
              setState(() => _placing = false);
              if (mounted) ctx.pushReplacement('/order-success', extra: order);
            })),
          ]),
        ],
      ])),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 19 · ORDER SUCCESS                      ║
// ╚══════════════════════════════════════════════════════════╝

class OrderSuccessScreen extends StatelessWidget {
  final AppOrder order;
  const OrderSuccessScreen({super.key, required this.order});

  @override Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: C.white,
    body: SafeArea(child: Padding(padding: const EdgeInsets.all(32), child: Column(
      mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 100, height: 100, decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
        child: const Icon(Icons.check_circle_rounded, color: C.success, size: 60))
          .animate().scale(delay: 200.ms, duration: 500.ms, curve: Curves.elasticOut),
      const SizedBox(height: 24),
      Text('Order Placed!', style: Theme.of(ctx).textTheme.displaySmall).animate().fadeIn(delay: 400.ms),
      const SizedBox(height: 8),
      Text('Your order ${order.orderNumber} has been placed successfully.',
        style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(color: C.g600, height: 1.5),
        textAlign: TextAlign.center).animate().fadeIn(delay: 500.ms),
      const SizedBox(height: 32),
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: C.g50, borderRadius: BorderRadius.circular(16)), child: Column(children: [
        _SumRow('Order No.', order.orderNumber),
        _SumRow('Payment', order.paymentMethod),
        _SumRow('Est. Delivery', '${order.estimatedDelivery?.day}/${order.estimatedDelivery?.month}/${order.estimatedDelivery?.year}'),
        const Divider(height: 16),
        _SumRow('Total', '\$${order.total.toStringAsFixed(2)}', bold: true),
      ])).animate().fadeIn(delay: 600.ms),
      const SizedBox(height: 32),
      Btn(text: 'Track My Order', onPressed: () => ctx.pushReplacement('/orders')).animate().fadeIn(delay: 700.ms),
      const SizedBox(height: 12),
      OutBtn(text: 'Continue Shopping', onPressed: () => ctx.go('/')).animate().fadeIn(delay: 800.ms),
    ]))),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 20 · ORDERS SCREEN                      ║
// ╚══════════════════════════════════════════════════════════╝

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});
  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(title: const Text('My Orders'), backgroundColor: C.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20), onPressed: () => ctx.pop())),
      body: orders.isEmpty
        ? const EmptyView(icon: Icons.receipt_long_outlined, title: 'No orders yet', desc: 'Your order history will appear here.')
        : ListView.separated(padding: const EdgeInsets.all(16), itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => _OrderCard(orders[i])),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final AppOrder o;
  const _OrderCard(this.o);
  @override Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: C.shadowMd, blurRadius: 8, offset: const Offset(0, 3))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(o.orderNumber, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, color: C.primary)),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: o.status.color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Text(o.status.label, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: o.status.color))),
      ]),
      const SizedBox(height: 6),
      Text('${o.createdAt.day}/${o.createdAt.month}/${o.createdAt.year}', style: Theme.of(ctx).textTheme.bodySmall?.copyWith(color: C.g500)),
      const SizedBox(height: 12),
      if (o.status != OrderStatus.cancelled) ...[
        Row(children: List.generate(4, (i) {
          final active = o.status.step >= i;
          return Expanded(child: Row(children: [
            Container(width: 20, height: 20, decoration: BoxDecoration(color: active ? C.blue : C.g200, shape: BoxShape.circle),
              child: Center(child: Icon(Icons.check, size: 12, color: active ? C.white : C.g400))),
            if (i < 3) Expanded(child: Container(height: 2, color: active && o.status.step > i ? C.blue : C.g200)),
          ]));
        })),
        const SizedBox(height: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['Placed', 'Processing', 'Shipped', 'Delivered']
            .map((s) => Text(s, style: GoogleFonts.poppins(fontSize: 9, color: C.g400))).toList()),
        const SizedBox(height: 12),
      ],
      const Divider(),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Total', style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(color: C.g600)),
        Text('\$${o.total.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15, color: C.primary)),
      ]),
    ]),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 21 · PROFILE SCREEN                     ║
// ╚══════════════════════════════════════════════════════════╝

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(title: const Text('My Profile'), backgroundColor: C.white, automaticallyImplyLeading: false),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
        // Profile card
        Container(padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB), Color(0xFF3B82F6)]),
            borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            CircleAvatar(radius: 32, backgroundColor: Colors.white.withOpacity(0.2),
              child: Text(user?.name.isNotEmpty == true ? user!.name[0].toUpperCase() : '?',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: C.white))),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user?.name ?? 'Guest', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 17, color: C.white)),
              Text(user?.email ?? '', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white.withOpacity(0.75))),
              const SizedBox(height: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3))),
                child: const Text('Premium Member', style: TextStyle(color: C.white, fontSize: 11, fontWeight: FontWeight.w600))),
            ])),
          ])),
        const SizedBox(height: 14),

        // Stats
        Row(children: [
          _StatCard('Orders',  ref.watch(ordersProvider).length.toString(), Icons.receipt_long_outlined),
          const SizedBox(width: 12),
          _StatCard('Wishlist', ref.watch(wishlistProvider).length.toString(), Icons.favorite_border_rounded),
          const SizedBox(width: 12),
          _StatCard('Reviews', '5', Icons.star_border_rounded),
        ]),
        const SizedBox(height: 14),

        _MenuSection('Shopping', [
          _MenuItem(Icons.receipt_long_outlined, 'My Orders', () => ctx.push('/orders')),
          _MenuItem(Icons.favorite_border_rounded, 'Wishlist', () => ctx.go('/wishlist')),
          _MenuItem(Icons.location_on_outlined, 'Addresses', () {}),
          _MenuItem(Icons.local_offer_outlined, 'Promo Codes', () {}),
        ]),
        const SizedBox(height: 12),
        _MenuSection('Features', [
          _MenuItem(Icons.camera_alt_outlined, 'Virtual Try-On', () => ctx.push('/try-on')),
          _MenuItem(Icons.qr_code_scanner_rounded, 'QR Rack Scanner', () => ctx.push('/qr-scanner')),
        ]),
        const SizedBox(height: 12),
        _MenuSection('Account', [
          _MenuItem(Icons.notifications_none_rounded, 'Notifications', () {}),
          _MenuItem(Icons.help_outline_rounded, 'Help & Support', () {}),
          _MenuItem(Icons.info_outline_rounded, 'About StyleSphere', () {}),
        ]),
        const SizedBox(height: 12),
        Container(decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]),
          child: ListTile(leading: const Icon(Icons.logout_rounded, color: C.error),
            title: Text('Logout', style: GoogleFonts.poppins(color: C.error, fontWeight: FontWeight.w600)),
            onTap: () => ref.read(authProvider.notifier).signOut())),
        const SizedBox(height: 24),
      ])),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, val; final IconData ic;
  const _StatCard(this.label, this.val, this.ic);
  @override Widget build(BuildContext ctx) => Expanded(child: Container(padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]),
    child: Column(children: [Icon(ic, color: C.blue, size: 22), const SizedBox(height: 6),
      Text(val, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: C.primary)),
      Text(label, style: GoogleFonts.poppins(fontSize: 11, color: C.g500))])));
}

Widget _MenuSection(String title, List<Widget> items) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  Padding(padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(title, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: C.g400, letterSpacing: 0.5))),
  Container(decoration: BoxDecoration(color: C.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: C.shadow, blurRadius: 6)]),
    child: Column(children: items.asMap().entries.map((e) => Column(children: [e.value, if (e.key < items.length - 1) const Divider(height: 1, indent: 52)])).toList())),
]);

class _MenuItem extends StatelessWidget {
  final IconData ic; final String label; final VoidCallback onTap;
  const _MenuItem(this.ic, this.label, this.onTap);
  @override Widget build(BuildContext ctx) => ListTile(
    leading: Container(width: 34, height: 34, decoration: BoxDecoration(color: C.blueLight, borderRadius: BorderRadius.circular(9)),
      child: Icon(ic, color: C.blue, size: 18)),
    title: Text(label, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
    trailing: const Icon(Icons.chevron_right_rounded, color: C.g300), onTap: onTap);
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 22 · VIRTUAL TRY-ON                     ║
// ╚══════════════════════════════════════════════════════════╝

class TryOnScreen extends ConsumerStatefulWidget {
  final Product? product;
  const TryOnScreen({super.key, this.product});
  @override ConsumerState<TryOnScreen> createState() => _TOState();
}

class _TOState extends ConsumerState<TryOnScreen> with SingleTickerProviderStateMixin {
  bool _detecting = true, _bodyFound = false, _captured = false;
  double _scale = 1.0, _ox = 0, _oy = -40;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  @override void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
    Future.delayed(const Duration(seconds: 2), () { if (mounted) setState(() => _bodyFound = true); });
    Future.delayed(const Duration(seconds: 3), () { if (mounted) setState(() => _detecting = false); });
  }
  @override void dispose() { _pulseCtrl.dispose(); super.dispose(); }

  @override Widget build(BuildContext ctx) {
    final p = widget.product;
    return Scaffold(backgroundColor: C.black, body: Stack(children: [
      Positioned.fill(child: CustomPaint(painter: _CamPainter())),

      if (_bodyFound && p != null) Positioned.fill(child: GestureDetector(
        onScaleUpdate: (d) { setState(() { _scale = (_scale * d.scale).clamp(0.5, 2.5); _ox += d.focalPointDelta.dx; _oy += d.focalPointDelta.dy; }); },
        child: Center(child: Transform.translate(offset: Offset(_ox, _oy), child: ScaleTransition(scale: _pulse,
          child: Transform.scale(scale: _scale, child: AnimatedOpacity(opacity: _bodyFound ? 1 : 0, duration: 600.ms,
            child: Container(width: 200, height: 280,
              decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Color(0xFF2563EB), Color(0xFF1E3A8A)]),
                borderRadius: BorderRadius.circular(12), border: Border.all(color: C.white.withOpacity(0.25))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.checkroom_rounded, color: C.white, size: 44),
                const SizedBox(height: 8),
                Text(p.name, style: GoogleFonts.poppins(color: C.white, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center, maxLines: 2),
                Text('AR Preview', style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.7), fontSize: 10)),
              ]))))))))),

      if (_detecting) Positioned.fill(child: Container(color: Colors.black.withOpacity(0.35),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(color: C.blue, strokeWidth: 3),
          const SizedBox(height: 16),
          Text('Detecting body pose...', style: GoogleFonts.poppins(color: C.white, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text('Stand 2-3 feet from camera', style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.6), fontSize: 12)),
        ])))),

      Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
        GestureDetector(onTap: () => ctx.pop(), child: Container(padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
          child: const Icon(Icons.close, color: C.white, size: 20))),
        const SizedBox(width: 12),
        Expanded(child: Text('Virtual Try-On', style: GoogleFonts.poppins(color: C.white, fontWeight: FontWeight.w700, fontSize: 16))),
        if (_bodyFound) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(color: C.success, borderRadius: BorderRadius.circular(20)),
          child: Row(children: [const Icon(Icons.person, color: C.white, size: 14), const SizedBox(width: 4),
            Text('Body Detected', style: GoogleFonts.poppins(color: C.white, fontSize: 11, fontWeight: FontWeight.w600))])),
      ])))),

      if (!_detecting) Positioned(top: 100, left: 0, right: 0, child: Center(child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
        child: Text('Pinch to resize · Drag to reposition', style: GoogleFonts.poppins(color: C.white, fontSize: 12))))),

      if (_captured) Positioned.fill(child: Container(color: C.white)),

      Positioned(bottom: 0, left: 0, right: 0, child: SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 20), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _TBtn(Icons.remove, () { if (_scale > 0.5) setState(() => _scale -= 0.1); }, 'Smaller'),
          const SizedBox(width: 20),
          _TBtn(Icons.refresh_rounded, () { setState(() { _scale = 1; _ox = 0; _oy = -40; }); }, 'Reset'),
          const SizedBox(width: 20),
          _TBtn(Icons.add, () { if (_scale < 2.5) setState(() => _scale += 0.1); }, 'Larger'),
        ]),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () { setState(() => _captured = true); Future.delayed(200.ms, () { if (mounted) setState(() => _captured = false); }); snack(ctx, 'Screenshot saved! 📸'); },
          child: Container(width: 70, height: 70, decoration: BoxDecoration(color: C.white, shape: BoxShape.circle, border: Border.all(color: C.g300, width: 3)),
            child: const Center(child: Icon(Icons.camera_alt_rounded, color: C.primary, size: 30)))),
      ])))),
    ]));
  }
}

class _TBtn extends StatelessWidget {
  final IconData ic; final VoidCallback onTap; final String label;
  const _TBtn(this.ic, this.onTap, this.label);
  @override Widget build(BuildContext ctx) => Column(mainAxisSize: MainAxisSize.min, children: [
    GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
      child: Icon(ic, color: C.white, size: 22))),
    const SizedBox(height: 4),
    Text(label, style: GoogleFonts.poppins(color: C.white, fontSize: 10)),
  ]);
}

class _CamPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..shader = const LinearGradient(
      begin: Alignment.topCenter, end: Alignment.bottomCenter,
      colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F172A)],
    ).createShader(Offset.zero & size));
    final cx = size.width / 2, cy = size.height * 0.45;
    canvas.drawCircle(Offset(cx, cy - 160), 36, Paint()..color = const Color(0xFF8B6F47).withOpacity(0.7));
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx, cy), width: 130, height: 200), const Radius.circular(20)),
      Paint()..color = const Color(0xFF6B5B45).withOpacity(0.6));
    final dp = Paint()..color = C.blue.withOpacity(0.9);
    for (final o in [Offset(cx,cy-180),Offset(cx-60,cy-120),Offset(cx+60,cy-120),Offset(cx-70,cy-60),Offset(cx+70,cy-60),Offset(cx,cy-60),Offset(cx-50,cy+60),Offset(cx+50,cy+60),Offset(cx-50,cy+160),Offset(cx+50,cy+160)])
      canvas.drawCircle(o, 5, dp);
    final lp = Paint()..color = C.blue.withOpacity(0.4)..strokeWidth = 2;
    void ln(Offset a, Offset b) => canvas.drawLine(a, b, lp);
    ln(Offset(cx,cy-180),Offset(cx,cy-60)); ln(Offset(cx,cy-120),Offset(cx-70,cy-60));
    ln(Offset(cx,cy-120),Offset(cx+70,cy-60)); ln(Offset(cx,cy-60),Offset(cx-50,cy+60));
    ln(Offset(cx,cy-60),Offset(cx+50,cy+60)); ln(Offset(cx-50,cy+60),Offset(cx-50,cy+160));
    ln(Offset(cx+50,cy+60),Offset(cx+50,cy+160));
    const m = 40.0, bl = 25.0;
    final br = Paint()..color = C.blue..strokeWidth = 3..style = PaintingStyle.stroke;
    for (final c in [Offset(m,m),Offset(size.width-m,m),Offset(m,size.height-m),Offset(size.width-m,size.height-m)]) {
      final dx = c.dx < size.width/2 ? 1.0 : -1.0, dy = c.dy < size.height/2 ? 1.0 : -1.0;
      canvas.drawPath(Path()..moveTo(c.dx,c.dy+dy*bl)..lineTo(c.dx,c.dy)..lineTo(c.dx+dx*bl,c.dy), br);
    }
  }
  @override bool shouldRepaint(_CamPainter o) => false;
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 23 · QR SCANNER SCREEN                  ║
// ╚══════════════════════════════════════════════════════════╝

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});
  @override ConsumerState<QrScannerScreen> createState() => _QRState();
}

class _QRState extends ConsumerState<QrScannerScreen> with SingleTickerProviderStateMixin {
  bool _scanned = false;
  String? _scannedRack;
  late AnimationController _scanCtrl;
  late Animation<double> _scanAnim;
  final MobileScannerController _cameraController = MobileScannerController();

  @override void initState() {
    super.initState();
    _scanCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _scanAnim = Tween<double>(begin: 0, end: 1).animate(_scanCtrl);
  }
  @override void dispose() { _scanCtrl.dispose(); _cameraController.dispose(); super.dispose(); }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        String rackId = barcode.rawValue!;
        if (!kRackNames.containsKey(rackId)) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Demo: Unrecognized QR ($rackId). Using default rack!'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            backgroundColor: C.blue,
          ));
          rackId = kRackNames.keys.first;
        }
        
        setState(() { _scanned = true; _scannedRack = rackId; });
        HapticFeedback.heavyImpact();
        return;
      }
    }
  }

  @override Widget build(BuildContext ctx) => Scaffold(backgroundColor: C.black, body: Stack(children: [
    Positioned.fill(child: MobileScanner(
      controller: _cameraController,
      onDetect: _onDetect,
    )),

    Positioned.fill(child: CustomPaint(painter: _QRFramePainter(_scanAnim))),

    Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
      GestureDetector(onTap: () => ctx.pop(), child: Container(padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
        child: const Icon(Icons.close, color: C.white, size: 20))),
      const SizedBox(width: 12),
      Text('Rack Scanner', style: GoogleFonts.poppins(color: C.white, fontWeight: FontWeight.w700, fontSize: 16)),
    ])))),

    Positioned(top: 120, left: 40, right: 40, child: Text(
      'Point camera at the QR code on any clothing rack',
      style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 14), textAlign: TextAlign.center)),

    if (_scanned && _scannedRack != null) Positioned.fill(child: Container(
      color: Colors.black.withOpacity(0.65),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.check_circle_rounded, color: C.success, size: 70).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
        const SizedBox(height: 16),
        Text('Rack Found!', style: GoogleFonts.poppins(color: C.white, fontWeight: FontWeight.w700, fontSize: 22)).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 6),
        Text(kRackNames[_scannedRack]!, style: GoogleFonts.poppins(color: C.blue, fontSize: 16, fontWeight: FontWeight.w600)).animate().fadeIn(delay: 300.ms),
        const SizedBox(height: 28),
        ElevatedButton.icon(
          onPressed: () => ctx.pushReplacement('/rack/$_scannedRack', extra: kRackNames[_scannedRack]),
          icon: const Icon(Icons.grid_view_rounded), label: const Text('View Rack Items'),
          style: ElevatedButton.styleFrom(backgroundColor: C.blue, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 12),
        TextButton(onPressed: () { setState(() { _scanned = false; _scannedRack = null; }); },
          child: const Text('Scan Again', style: TextStyle(color: C.white))),
      ])),
    )),
  ]));
}

class _QRFramePainter extends CustomPainter {
  final Animation<double> anim;
  _QRFramePainter(this.anim) : super(repaint: anim);
  @override void paint(Canvas canvas, Size sz) {
    final cx = sz.width/2, cy = sz.height/2, s = 220.0, r = 16.0;
    canvas.drawPath(Path.combine(PathOperation.difference,
      Path()..addRect(Offset.zero & sz),
      Path()..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx, cy), width: s, height: s), Radius.circular(r)))),
      Paint()..color = Colors.black.withOpacity(0.7));
    final p = Paint()..color = C.blue..strokeWidth = 4..style = PaintingStyle.stroke;
    final l = s/2, bl = 28.0;
    for (final c in [Offset(cx-l+r,cy-l+r),Offset(cx+l-r,cy-l+r),Offset(cx-l+r,cy+l-r),Offset(cx+l-r,cy+l-r)]) {
      final dx = c.dx < cx ? -1.0 : 1.0, dy = c.dy < cy ? -1.0 : 1.0;
      canvas.drawPath(Path()..moveTo(c.dx+dx*bl,c.dy)..lineTo(c.dx,c.dy)..lineTo(c.dx,c.dy+dy*bl), p);
    }
    final scanY = cy - l + r + (s - 2*r) * anim.value;
    canvas.drawLine(Offset(cx-l+r+4, scanY), Offset(cx+l-r-4, scanY), Paint()..color = C.blue..strokeWidth = 2.5);
  }
  @override bool shouldRepaint(_QRFramePainter o) => true;
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 24 · RACK PRODUCTS SCREEN               ║
// ╚══════════════════════════════════════════════════════════╝

class RackProductsScreen extends ConsumerWidget {
  final String rackId;
  final Object? extra;
  const RackProductsScreen({super.key, required this.rackId, this.extra});

  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final rackName = extra is String ? extra as String : kRackNames[rackId] ?? 'Rack';
    final ids      = kRackMap[rackId] ?? [];
    final products = kProducts.where((p) => ids.contains(p.id)).toList();

    return Scaffold(backgroundColor: C.bg,
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Rack Items', style: TextStyle(fontSize: 16)),
          Text(rackName, style: GoogleFonts.poppins(fontSize: 11, color: C.blue, fontWeight: FontWeight.w500)),
        ]),
        backgroundColor: C.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20), onPressed: () => ctx.pop()),
        actions: [IconButton(icon: const Icon(Icons.qr_code_scanner_rounded, color: C.blue), onPressed: () => ctx.pushReplacement('/qr-scanner'))],
      ),
      body: products.isEmpty
        ? const EmptyView(icon: Icons.checkroom_outlined, title: 'No items on this rack', desc: 'This rack appears to be empty.')
        : GridView.builder(padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.71, crossAxisSpacing: 12, mainAxisSpacing: 12),
            itemCount: products.length, itemBuilder: (_, i) => _ProdCard(products[i])),
    );
  }
}