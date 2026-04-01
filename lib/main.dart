// ============================================================
//  STYLESPHERE — Complete Flutter App (Single File)
//  Premium Fashion Retail · AR Try-On · QR Rack Scanner
// ============================================================

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ╔══════════════════════════════════════════════════════════╗
// ║                  1 · ENTRY POINT                        ║
// ╚══════════════════════════════════════════════════════════╝

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
  static const primary      = Color(0xFF1A1A2E);
  static const secondary    = Color(0xFFE94560);
  static const accent       = Color(0xFFF5F5F5);
  static const primaryLight = Color(0xFF16213E);
  static const white        = Color(0xFFFFFFFF);
  static const black        = Color(0xFF000000);
  static const g100 = Color(0xFFF8F8F8);
  static const g200 = Color(0xFFEEEEEE);
  static const g300 = Color(0xFFE0E0E0);
  static const g400 = Color(0xFFBDBDBD);
  static const g500 = Color(0xFF9E9E9E);
  static const g600 = Color(0xFF757575);
  static const g700 = Color(0xFF616161);
  static const g800 = Color(0xFF424242);
  static const success  = Color(0xFF4CAF50);
  static const warning  = Color(0xFFFFC107);
  static const error    = Color(0xFFF44336);
  static const shadow   = Color(0x14000000);
  static const divider  = Color(0xFFEEEEEE);

  static const LinearGradient heroGrad = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xDD1A1A2E)],
  );
  static const LinearGradient primaryGrad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );
}

ThemeData _buildTheme() {
  final base = GoogleFonts.poppinsTextTheme();
  TextStyle p(double sz, FontWeight w, Color col, {double ls = 0}) =>
      GoogleFonts.poppins(fontSize: sz, fontWeight: w, color: col, letterSpacing: ls);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: C.primary,
      primary: C.primary,
      secondary: C.secondary,
      surface: C.white,
      error: C.error,
      onPrimary: C.white,
      onSecondary: C.white,
      onSurface: C.primary,
    ),
    scaffoldBackgroundColor: C.g100,
    textTheme: base.copyWith(
      displayLarge:  p(32, FontWeight.w800, C.primary, ls: -1),
      displayMedium: p(26, FontWeight.w700, C.primary),
      displaySmall:  p(22, FontWeight.w700, C.primary),
      headlineLarge: p(20, FontWeight.w700, C.primary),
      headlineMedium:p(18, FontWeight.w600, C.primary),
      headlineSmall: p(16, FontWeight.w600, C.primary),
      titleLarge:    p(16, FontWeight.w600, C.primary),
      titleMedium:   p(14, FontWeight.w500, C.primary),
      titleSmall:    p(12, FontWeight.w500, C.g700),
      bodyLarge:     p(16, FontWeight.w400, C.g800),
      bodyMedium:    p(14, FontWeight.w400, C.g700),
      bodySmall:     p(12, FontWeight.w400, C.g500),
      labelLarge:    p(14, FontWeight.w600, C.white, ls: 0.5),
      labelMedium:   p(12, FontWeight.w500, C.g600),
      labelSmall:    p(10, FontWeight.w400, C.g500),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: C.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      iconTheme: const IconThemeData(color: C.primary),
      titleTextStyle: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w700, color: C.primary),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: C.secondary,
        foregroundColor: C.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: C.primary,
        side: const BorderSide(color: C.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: C.g100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.g200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.secondary, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.error)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: C.error, width: 1.5)),
      hintStyle: GoogleFonts.poppins(fontSize: 14, color: C.g400),
      labelStyle: GoogleFonts.poppins(fontSize: 14, color: C.g600),
    ),
    cardTheme: CardThemeData(
      color: C.white, elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: C.g100,
      selectedColor: C.primary,
      labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: C.primary,
      contentTextStyle: GoogleFonts.poppins(color: C.white, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
    sliderTheme: const SliderThemeData(activeTrackColor: C.secondary, thumbColor: C.secondary, inactiveTrackColor: C.g300),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: C.secondary),
    tabBarTheme: TabBarThemeData(
      labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
      labelColor: C.secondary,
      unselectedLabelColor: C.g500,
      indicatorColor: C.secondary,
    ),
    dividerTheme: const DividerThemeData(color: C.divider, thickness: 1, space: 1),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((s) => s.contains(MaterialState.selected) ? C.secondary : C.g300),
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
  final int reviewCount;
  final bool isNew, isFeatured, isInStock;
  final String? rackId, rackName;
  final Map<String, String> details;

  const Product({
    required this.id, required this.name, required this.brand,
    required this.description, required this.category, required this.subCategory,
    required this.price, this.originalPrice,
    required this.images, required this.sizes, required this.colors,
    required this.rating, required this.reviewCount,
    this.isNew = false, this.isFeatured = false, this.isInStock = true,
    this.rackId, this.rackName, this.details = const {},
  });

  double get discount =>
      (originalPrice != null && originalPrice! > price)
          ? ((originalPrice! - price) / originalPrice! * 100).roundToDouble()
          : 0;
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
    id: id, product: product, selectedSize: selectedSize,
    selectedColor: selectedColor, quantity: quantity ?? this.quantity,
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
      : this == OrderStatus.cancelled ? C.error : C.secondary;
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
  final String id, imageUrl, title, subtitle, actionLabel, route;
  const BannerData({required this.id, required this.imageUrl, required this.title,
    required this.subtitle, required this.actionLabel, required this.route});
}

class CategoryData {
  final String id, name, imageUrl, emoji;
  final Color color;
  const CategoryData({required this.id, required this.name, required this.imageUrl,
    required this.emoji, required this.color});
}

// ╔══════════════════════════════════════════════════════════╗
// ║                  4 · MOCK DATA                          ║
// ╚══════════════════════════════════════════════════════════╝

const _u = 'https://images.unsplash.com';

final kProducts = <Product>[
  Product(
    id: 'p01', name: 'Slim Fit Oxford Shirt', brand: 'StyleSphere',
    description: 'A timeless oxford shirt crafted from premium 100% cotton. Features a button-down collar, tailored slim fit, and subtle texture that elevates any formal or smart-casual look. Perfect for the boardroom or an evening out.',
    price: 79.99, originalPrice: 120.00, category: 'Men', subCategory: 'Formal',
    images: ['$_u/photo-1602810318383-e386cc2a3ccf?w=800&q=80', '$_u/photo-1596755094514-f87e34085b2c?w=800&q=80', '$_u/photo-1620012253295-c15cc3e65df4?w=800&q=80'],
    sizes: ['S','M','L','XL','XXL'], colors: ['White','Blue','Light Blue'],
    rating: 4.7, reviewCount: 324, isFeatured: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal Section",
    details: {'Material':'100% Premium Cotton','Fit':'Slim Fit','Care':'Machine Wash Cold','Origin':'Made in Portugal'},
  ),
  Product(
    id: 'p02', name: 'Classic Wool Blazer', brand: 'StyleSphere',
    description: 'Elevate your wardrobe with this sophisticated wool-blend blazer. Features a single-button closure, notch lapels, and structured shoulders. The slim silhouette creates a sharp, professional look.',
    price: 249.99, originalPrice: 380.00, category: 'Men', subCategory: 'Formal',
    images: ['$_u/photo-1507679799987-c73779587ccf?w=800&q=80', '$_u/photo-1593030761757-71fae45fa0e7?w=800&q=80'],
    sizes: ['S','M','L','XL'], colors: ['Charcoal','Navy','Black'],
    rating: 4.9, reviewCount: 187, isFeatured: true,
    rackId: 'rack_men_formal', rackName: "Men's Formal Section",
    details: {'Material':'70% Wool, 30% Polyester','Fit':'Slim Fit','Care':'Dry Clean Only','Lining':'Full Lining'},
  ),
  Product(
    id: 'p03', name: 'Slim Chino Trousers', brand: 'StyleSphere',
    description: 'Versatile chino trousers that seamlessly blend comfort and style. Crafted from a lightweight cotton-stretch blend with a clean, tailored silhouette.',
    price: 89.99, category: 'Men', subCategory: 'Casual',
    images: ['$_u/photo-1473966968600-fa801b869a1a?w=800&q=80', '$_u/photo-1624378439575-d8705ad7ae80?w=800&q=80'],
    sizes: ['28','30','32','34','36'], colors: ['Khaki','Navy','Olive','Stone'],
    rating: 4.5, reviewCount: 458, isNew: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual Section",
    details: {'Material':'97% Cotton, 3% Elastane','Fit':'Slim Fit','Rise':'Mid Rise','Care':'Machine Wash'},
  ),
  Product(
    id: 'p04', name: 'Premium Oversized Hoodie', brand: 'StyleSphere',
    description: 'The ultimate streetwear staple. This heavyweight cotton hoodie features an oversized silhouette, kangaroo pocket, and ribbed cuffs. The premium fleece interior provides exceptional warmth.',
    price: 119.99, originalPrice: 160.00, category: 'Men', subCategory: 'Streetwear',
    images: ['$_u/photo-1556821840-3a63f15732ce?w=800&q=80', '$_u/photo-1578587018452-892bacefd3f2?w=800&q=80', '$_u/photo-1620799140408-edc6dcb6d633?w=800&q=80'],
    sizes: ['S','M','L','XL','XXL'], colors: ['Black','Cream','Forest Green','Burgundy'],
    rating: 4.8, reviewCount: 792, isNew: true, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear Collection',
    details: {'Material':'400gsm Cotton Fleece','Fit':'Oversized','Weight':'Heavyweight','Care':'Machine Wash Cold'},
  ),
  Product(
    id: 'p05', name: 'Cargo Tech Pants', brand: 'StyleSphere',
    description: 'Functional meets fashion with these technical cargo pants. Multiple zip pockets, adjustable waistband, and a tapered leg silhouette.',
    price: 149.99, originalPrice: 200.00, category: 'Men', subCategory: 'Streetwear',
    images: ['$_u/photo-1542272604-787c3835535d?w=800&q=80', '$_u/photo-1517438476312-10d79c077509?w=800&q=80'],
    sizes: ['S','M','L','XL'], colors: ['Black','Khaki','Dark Green'],
    rating: 4.6, reviewCount: 234,
    rackId: 'rack_streetwear', rackName: 'Streetwear Collection',
    details: {'Material':'Ripstop Nylon','Pockets':'6 Zip Pockets','Feature':'Water Resistant','Care':'Machine Wash'},
  ),
  Product(
    id: 'p06', name: 'Floral Midi Dress', brand: 'StyleSphere',
    description: 'A stunning floral midi dress featuring a V-neckline, flowy silhouette, and delicate floral print. Crafted from lightweight viscose fabric that drapes beautifully.',
    price: 129.99, originalPrice: 180.00, category: 'Women', subCategory: 'Casual',
    images: ['$_u/photo-1572804013309-59a88b7e92f1?w=800&q=80', '$_u/photo-1508163223045-1880bc36e222?w=800&q=80', '$_u/photo-1595777457583-95e059d581b8?w=800&q=80'],
    sizes: ['XS','S','M','L','XL'], colors: ['Floral Blue','Floral Pink','Floral Green'],
    rating: 4.8, reviewCount: 567, isNew: true, isFeatured: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual Section",
    details: {'Material':'100% Viscose','Fit':'Relaxed','Length':'Midi (Below Knee)','Care':'Hand Wash'},
  ),
  Product(
    id: 'p07', name: 'Tailored Blazer Dress', brand: 'StyleSphere',
    description: 'A sophisticated power-dressing piece that commands attention. This tailored blazer dress features peak lapels, a defined waist, and a thigh-length hemline.',
    price: 219.99, originalPrice: 320.00, category: 'Women', subCategory: 'Formal',
    images: ['$_u/photo-1594938298603-c8148c4b2f8e?w=800&q=80', '$_u/photo-1539109136881-3be0616acf4b?w=800&q=80'],
    sizes: ['XS','S','M','L'], colors: ['Black','Ivory','Deep Red'],
    rating: 4.9, reviewCount: 189, isFeatured: true,
    rackId: 'rack_women_formal', rackName: "Women's Formal Section",
    details: {'Material':'Italian Crepe Fabric','Fit':'Tailored','Closure':'Single Button','Care':'Dry Clean'},
  ),
  Product(
    id: 'p08', name: 'High-Waist Wide Leg Jeans', brand: 'StyleSphere',
    description: 'A modern take on the classic wide-leg silhouette. Features a high-waist design, raw hem, and premium stretch denim that flatters every body type.',
    price: 109.99, category: 'Women', subCategory: 'Casual',
    images: ['$_u/photo-1541099649105-f69ad21f3246?w=800&q=80', '$_u/photo-1475178626620-a4d074967452?w=800&q=80'],
    sizes: ['24','25','26','27','28','30'], colors: ['Light Wash','Dark Wash','Black'],
    rating: 4.7, reviewCount: 883,
    rackId: 'rack_women_casual', rackName: "Women's Casual Section",
    details: {'Material':'93% Cotton, 7% Elastane','Rise':'High Rise','Fit':'Wide Leg','Care':'Machine Wash'},
  ),
  Product(
    id: 'p09', name: 'Cropped Leather Jacket', brand: 'StyleSphere',
    description: 'The definitive statement piece. This cropped moto jacket is crafted from premium vegan leather with silver-tone hardware and asymmetric zip closure.',
    price: 299.99, originalPrice: 450.00, category: 'Women', subCategory: 'Streetwear',
    images: ['$_u/photo-1551028719-00167b16eac5?w=800&q=80', '$_u/photo-1521223890158-f9f7c3d5d504?w=800&q=80'],
    sizes: ['XS','S','M','L'], colors: ['Black','Burgundy','Tan'],
    rating: 4.9, reviewCount: 342, isNew: true, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear Collection',
    details: {'Material':'Premium Vegan Leather','Fit':'Cropped','Hardware':'Silver-Tone','Care':'Wipe Clean'},
  ),
  Product(
    id: 'p10', name: 'Satin Slip Dress', brand: 'StyleSphere',
    description: 'Effortlessly chic satin slip dress that works for any occasion. Features adjustable spaghetti straps and a bias-cut silhouette that skims the body beautifully.',
    price: 99.99, originalPrice: 150.00, category: 'Women', subCategory: 'Formal',
    images: ['$_u/photo-1566174053879-31528523f8ae?w=800&q=80', '$_u/photo-1515372039744-b8f02a3ae446?w=800&q=80'],
    sizes: ['XS','S','M','L'], colors: ['Champagne','Dusty Rose','Sage Green','Black'],
    rating: 4.7, reviewCount: 456,
    rackId: 'rack_women_formal', rackName: "Women's Formal Section",
    details: {'Material':'100% Satin','Fit':'Bias Cut','Straps':'Adjustable','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p11', name: 'Kids Denim Overalls', brand: 'StyleSphere',
    description: 'Super cute and durable denim overalls for active kids. Features adjustable straps, multiple pockets, and reinforced knees.',
    price: 49.99, originalPrice: 70.00, category: 'Kids', subCategory: 'Casual',
    images: ['$_u/photo-1519238263530-99bdd11df2ea?w=800&q=80', '$_u/photo-1543854589-fdd815240077?w=800&q=80'],
    sizes: ['3T','4T','5T','6','7','8'], colors: ['Light Denim','Dark Denim'],
    rating: 4.8, reviewCount: 234,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'Soft Denim','Feature':'Reinforced Knees','Straps':'Adjustable','Care':'Machine Wash'},
  ),
  Product(
    id: 'p12', name: 'Kids Graphic Tee Set', brand: 'StyleSphere',
    description: 'Fun graphic tee and matching shorts set for active kids. Made from super-soft 100% cotton jersey with playful prints.',
    price: 39.99, category: 'Kids', subCategory: 'Casual',
    images: ['$_u/photo-1519238263530-99bdd11df2ea?w=800&q=80', '$_u/photo-1518831959646-742c3a14ebf7?w=800&q=80'],
    sizes: ['3T','4T','5T','6','7','8','10'], colors: ['Blue','Red','Yellow','Green'],
    rating: 4.6, reviewCount: 178, isNew: true,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'100% Cotton Jersey','Set':'2-Piece (Tee + Shorts)','Waistband':'Elastic','Care':'Machine Wash'},
  ),
  Product(
    id: 'p13', name: 'Leather Tote Bag', brand: 'StyleSphere',
    description: 'A spacious and elegant leather tote that combines functionality with luxury. Made from full-grain leather with gold-tone hardware.',
    price: 189.99, originalPrice: 280.00, category: 'Accessories', subCategory: 'Bags',
    images: ['$_u/photo-1590874103328-eac38a683ce7?w=800&q=80', '$_u/photo-1553062407-98eeb64c6a62?w=800&q=80'],
    sizes: ['One Size'], colors: ['Tan','Black','Cognac'],
    rating: 4.9, reviewCount: 312, isFeatured: true,
    rackId: 'rack_accessories', rackName: 'Accessories Section',
    details: {'Material':'Full-Grain Leather','Hardware':'Gold-Tone','Dimensions':'14" x 12" x 5"','Pockets':'Interior Organizer'},
  ),
  Product(
    id: 'p14', name: 'Wool Knit Scarf', brand: 'StyleSphere',
    description: 'Luxuriously soft merino wool scarf with a classic ribbed pattern. Extra-long length allows for multiple styling options.',
    price: 69.99, originalPrice: 100.00, category: 'Accessories', subCategory: 'Scarves',
    images: ['$_u/photo-1520903920243-00d872a2d1c9?w=800&q=80', '$_u/photo-1574180566232-aaad1b5b8450?w=800&q=80'],
    sizes: ['One Size'], colors: ['Camel','Charcoal','Cream','Burgundy'],
    rating: 4.8, reviewCount: 145,
    rackId: 'rack_accessories', rackName: 'Accessories Section',
    details: {'Material':'100% Merino Wool','Length':'180cm','Pattern':'Ribbed Knit','Care':'Hand Wash'},
  ),
  // ── NEW PRODUCTS ──
  Product(
    id: 'p15', name: 'Classic Polo Shirt', brand: 'StyleSphere',
    description: 'A versatile polo shirt in premium piqué cotton. Features a ribbed collar, two-button placket, and a relaxed fit that works for both casual and smart-casual occasions.',
    price: 59.99, originalPrice: 85.00, category: 'Men', subCategory: 'Casual',
    images: ['$_u/photo-1586363104862-3a5e2ab60d99?w=800&q=80', '$_u/photo-1581655353564-df123a1eb820?w=800&q=80'],
    sizes: ['S','M','L','XL','XXL'], colors: ['White','Navy','Black','Burgundy'],
    rating: 4.6, reviewCount: 412, isNew: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual Section",
    details: {'Material':'100% Piqué Cotton','Fit':'Regular','Collar':'Ribbed','Care':'Machine Wash'},
  ),
  Product(
    id: 'p16', name: 'Rugged Denim Jacket', brand: 'StyleSphere',
    description: 'An iconic denim jacket with a vintage-washed finish. Features copper-tone buttons, chest pockets, and a tailored fit that layers perfectly over any outfit.',
    price: 139.99, originalPrice: 190.00, category: 'Men', subCategory: 'Casual',
    images: ['$_u/photo-1576995853123-5a10305d93c0?w=800&q=80', '$_u/photo-1551537482-f2075a1d41f2?w=800&q=80'],
    sizes: ['S','M','L','XL'], colors: ['Light Wash','Dark Wash','Black'],
    rating: 4.7, reviewCount: 289, isFeatured: true,
    rackId: 'rack_men_casual', rackName: "Men's Casual Section",
    details: {'Material':'100% Cotton Denim','Buttons':'Copper-Tone','Fit':'Tailored','Care':'Machine Wash Cold'},
  ),
  Product(
    id: 'p17', name: 'Tapered Jogger Pants', brand: 'StyleSphere',
    description: 'Athletic-inspired joggers with a modern tapered silhouette. Elasticised cuffs, drawstring waist, and side zip pockets. Perfect for athleisure or relaxed weekends.',
    price: 79.99, category: 'Men', subCategory: 'Streetwear',
    images: ['$_u/photo-1580906853149-f9b7fc919417?w=800&q=80', '$_u/photo-1562157873-818bc0726f68?w=800&q=80'],
    sizes: ['S','M','L','XL','XXL'], colors: ['Black','Grey','Navy'],
    rating: 4.5, reviewCount: 356, isNew: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear Collection',
    details: {'Material':'French Terry Cotton','Fit':'Tapered','Waist':'Drawstring','Care':'Machine Wash'},
  ),
  Product(
    id: 'p18', name: 'Italian Leather Belt', brand: 'StyleSphere',
    description: 'Handcrafted Italian leather belt with a polished nickel buckle. The perfect finishing touch for any outfit — from jeans to dress trousers.',
    price: 89.99, originalPrice: 130.00, category: 'Accessories', subCategory: 'Belts',
    images: ['$_u/photo-1553062407-98eeb64c6a62?w=800&q=80', '$_u/photo-1624222247344-550fb60583dc?w=800&q=80'],
    sizes: ['30','32','34','36','38'], colors: ['Black','Tan','Cognac'],
    rating: 4.8, reviewCount: 198,
    rackId: 'rack_accessories', rackName: 'Accessories Section',
    details: {'Material':'Italian Full-Grain Leather','Buckle':'Polished Nickel','Width':'3.5cm','Care':'Leather Conditioner'},
  ),
  Product(
    id: 'p19', name: 'Oversized Knit Sweater', brand: 'StyleSphere',
    description: 'A cozy, oversized knit sweater in a chunky cable-knit pattern. Features dropped shoulders, ribbed cuffs, and a relaxed fit that feels like a warm hug.',
    price: 109.99, originalPrice: 155.00, category: 'Women', subCategory: 'Casual',
    images: ['$_u/photo-1576566588028-4147f3842f27?w=800&q=80', '$_u/photo-1583743814966-8936f5b7be1a?w=800&q=80'],
    sizes: ['XS','S','M','L','XL'], colors: ['Cream','Dusty Rose','Sage Green','Mocha'],
    rating: 4.8, reviewCount: 523, isNew: true, isFeatured: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual Section",
    details: {'Material':'80% Wool, 20% Cashmere','Fit':'Oversized','Pattern':'Cable Knit','Care':'Hand Wash Cold'},
  ),
  Product(
    id: 'p20', name: 'Pleated Midi Skirt', brand: 'StyleSphere',
    description: 'An elegant pleated midi skirt that flows beautifully with every step. Features a hidden side zip, satin lining, and a versatile silhouette for day to night.',
    price: 89.99, originalPrice: 130.00, category: 'Women', subCategory: 'Formal',
    images: ['$_u/photo-1583496661160-fb5886a0aaaa?w=800&q=80', '$_u/photo-1577900232427-18219b9166a0?w=800&q=80'],
    sizes: ['XS','S','M','L'], colors: ['Black','Navy','Champagne','Dusty Rose'],
    rating: 4.7, reviewCount: 267,
    rackId: 'rack_women_formal', rackName: "Women's Formal Section",
    details: {'Material':'Polyester Georgette','Lining':'Satin','Closure':'Hidden Side Zip','Care':'Dry Clean'},
  ),
  Product(
    id: 'p21', name: 'Bohemian Maxi Dress', brand: 'StyleSphere',
    description: 'A free-spirited bohemian maxi dress with intricate print details, a cinched waist, and a dramatic floor-length skirt that moves beautifully in the breeze.',
    price: 149.99, originalPrice: 210.00, category: 'Women', subCategory: 'Casual',
    images: ['$_u/photo-1496747611176-843222e1e57c?w=800&q=80', '$_u/photo-1502716119720-b23a1e3b4c0d?w=800&q=80'],
    sizes: ['XS','S','M','L','XL'], colors: ['Coral','Teal','Lavender'],
    rating: 4.6, reviewCount: 391, isNew: true,
    rackId: 'rack_women_casual', rackName: "Women's Casual Section",
    details: {'Material':'100% Rayon','Fit':'Cinched Waist','Length':'Maxi (Floor Length)','Care':'Hand Wash'},
  ),
  Product(
    id: 'p22', name: 'White Leather Sneakers', brand: 'StyleSphere',
    description: 'Minimalist white leather sneakers that go with absolutely everything. Premium leather upper with a cushioned insole and signature back-tab detail.',
    price: 129.99, category: 'Women', subCategory: 'Streetwear',
    images: ['$_u/photo-1560769629-975ec94e6a86?w=800&q=80', '$_u/photo-1549298916-b41d501d3772?w=800&q=80'],
    sizes: ['36','37','38','39','40','41'], colors: ['White','White','Black'],
    rating: 4.9, reviewCount: 678, isFeatured: true,
    rackId: 'rack_streetwear', rackName: 'Streetwear Collection',
    details: {'Material':'Premium Leather','Sole':'Rubber','Insole':'Memory Foam','Care':'Wipe Clean'},
  ),
  Product(
    id: 'p23', name: 'Kids Hooded Raincoat', brand: 'StyleSphere',
    description: 'Bright and waterproof hooded raincoat to keep little ones dry on rainy days. Features reflective strips, snap closures, and a fun print lining.',
    price: 59.99, originalPrice: 80.00, category: 'Kids', subCategory: 'Casual',
    images: ['$_u/photo-1503919545889-aef636e10ad4?w=800&q=80', '$_u/photo-1471286174890-9c112ffca5b4?w=800&q=80'],
    sizes: ['3T','4T','5T','6','7','8'], colors: ['Yellow','Red','Navy'],
    rating: 4.7, reviewCount: 156, isNew: true,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'Waterproof Polyester','Feature':'Reflective Strips','Closures':'Snap Buttons','Care':'Machine Wash'},
  ),
  Product(
    id: 'p24', name: 'Kids Canvas Sneakers', brand: 'StyleSphere',
    description: 'Cool and comfortable canvas sneakers for everyday adventures. Features a reinforced toe cap, elastic laces for easy on/off, and a non-slip rubber sole.',
    price: 44.99, category: 'Kids', subCategory: 'Casual',
    images: ['$_u/photo-1514989940723-e8e51635b782?w=800&q=80', '$_u/photo-1506629082955-511b1aa562c8?w=800&q=80'],
    sizes: ['10C','11C','12C','13C','1Y','2Y','3Y'], colors: ['Red','Blue','White','Green'],
    rating: 4.5, reviewCount: 203,
    rackId: 'rack_kids', rackName: "Kids' Section",
    details: {'Material':'Canvas Upper','Sole':'Non-Slip Rubber','Laces':'Elastic','Care':'Machine Wash Cold'},
  ),
];

final kBanners = <BannerData>[
  BannerData(id:'b1', imageUrl:'$_u/photo-1490481651871-ab68de25d43d?w=1200&q=80', title:'New Season\nCollection', subtitle:'Up to 40% Off', actionLabel:'Shop Now', route:'/explore'),
  BannerData(id:'b2', imageUrl:'$_u/photo-1469334031218-e382a71b716b?w=1200&q=80', title:"Women's\nEdition", subtitle:'Explore the Latest Trends', actionLabel:'Discover', route:'/explore'),
  BannerData(id:'b3', imageUrl:'$_u/photo-1441984904996-e0b6ba687e04?w=1200&q=80', title:'Street\nStyle', subtitle:'Urban Fashion for the Bold', actionLabel:'Explore', route:'/explore'),
];

final kCategories = <CategoryData>[
  CategoryData(id:'men',   name:'Men',        imageUrl:'$_u/photo-1507679799987-c73779587ccf?w=400&q=80', emoji:'👔', color:C.primary),
  CategoryData(id:'women', name:'Women',      imageUrl:'$_u/photo-1515886657613-9f3515b0c78f?w=400&q=80', emoji:'👗', color:C.secondary),
  CategoryData(id:'kids',  name:'Kids',       imageUrl:'$_u/photo-1519238263530-99bdd11df2ea?w=400&q=80', emoji:'🎒', color:C.success),
  CategoryData(id:'accs',  name:'Accessories',imageUrl:'$_u/photo-1590874103328-eac38a683ce7?w=400&q=80', emoji:'👜', color:C.warning),
];

const kRackMap = <String, List<String>>{
  'rack_men_formal':   ['p01','p02'],
  'rack_men_casual':   ['p03','p15','p16'],
  'rack_streetwear':   ['p04','p05','p09','p17','p22'],
  'rack_women_casual': ['p06','p08','p19','p21'],
  'rack_women_formal': ['p07','p10','p20'],
  'rack_kids':         ['p11','p12','p23','p24'],
  'rack_accessories':  ['p13','p14','p18'],
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

// ╔══════════════════════════════════════════════════════════╗
// ║                  5 · PROVIDERS (Riverpod)               ║
// ╚══════════════════════════════════════════════════════════╝

// — Auth —
final authProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
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
    email: email,
    addresses: [_defaultAddress()],
  );

  Address _defaultAddress() => const Address(
    id: 'a01', name: 'Home', phone: '+1 234 567 8900',
    line1: '123 Fashion Street', line2: 'Apt 4B',
    city: 'New York', state: 'NY', zip: '10001', country: 'USA', isDefault: true,
  );
}

// — Product Filter —
class PFilter {
  final String? category, subCategory, search, sortBy;
  final List<String> sizes, colors;
  final double? minPrice, maxPrice;
  const PFilter({
    this.category, this.subCategory, this.search,
    this.sortBy = 'popularity', this.sizes = const [],
    this.colors = const [], this.minPrice, this.maxPrice,
  });
  bool get hasFilters => category != null || sizes.isNotEmpty || colors.isNotEmpty || minPrice != null || maxPrice != null || search != null;
  PFilter copyWith({
    String? category, String? subCategory, String? search,
    String? sortBy, List<String>? sizes, List<String>? colors,
    double? minPrice, double? maxPrice,
    bool clearCategory = false, bool clearSearch = false,
  }) => PFilter(
    category:    clearCategory ? null : category ?? this.category,
    subCategory: subCategory ?? this.subCategory,
    search:      clearSearch  ? null : search   ?? this.search,
    sortBy:      sortBy   ?? this.sortBy,
    sizes:       sizes    ?? this.sizes,
    colors:      colors   ?? this.colors,
    minPrice:    minPrice ?? this.minPrice,
    maxPrice:    maxPrice ?? this.maxPrice,
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

// — Cart —
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

// — Wishlist —
final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>((_) => WishlistNotifier());
class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);
  void toggle(Product p) => state = state.any((x) => x.id==p.id)
      ? state.where((x) => x.id!=p.id).toList()
      : [...state, p];
  bool has(String id) => state.any((x) => x.id==id);
}
final inWishlistProvider = Provider.family<bool,String>((ref, id) => ref.watch(wishlistProvider.notifier).has(id));

// — Recently Viewed —
final recentlyViewedProvider = StateNotifierProvider<RecentlyViewedNotifier, List<Product>>((_) => RecentlyViewedNotifier());
class RecentlyViewedNotifier extends StateNotifier<List<Product>> {
  RecentlyViewedNotifier() : super([]);
  void add(Product p) => state = [p, ...state.where((x) => x.id!=p.id)].take(8).toList();
}

// — Orders —
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

  Future<AppOrder> place({
    required List<CartItem> items, required Address address, required String payment,
  }) async {
    await Future.delayed(const Duration(seconds:2));
    final sub = items.fold<double>(0,(s,i) => s+i.total);
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
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    redirect: (ctx, state) {
      final loggedIn  = auth.valueOrNull != null;
      final isAuth    = state.matchedLocation.startsWith('/login') || state.matchedLocation.startsWith('/register');
      if (!loggedIn && !isAuth) return '/login';
      if (loggedIn  &&  isAuth) return '/';
      return null;
    },
    routes: [
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
      GoRoute(path:'/product/:id',     parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slideUp(s, ProductDetailScreen(product: s.extra as Product?))),
      GoRoute(path:'/checkout',        parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slideUp(s, const CheckoutScreen())),
      GoRoute(path:'/orders',          parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slide(s,  const OrdersScreen())),
      GoRoute(path:'/try-on',          parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _fade(s,   TryOnScreen(product: s.extra as Product?))),
      GoRoute(path:'/qr-scanner',      parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _fade(s,   const QrScannerScreen())),
      GoRoute(path:'/rack/:id',        parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slide(s,  RackProductsScreen(rackId: s.pathParameters['id']!, extra: s.extra))),
      GoRoute(path:'/order-success',   parentNavigatorKey:_rootKey, pageBuilder:(c,s) => _slideUp(s, OrderSuccessScreen(order: s.extra as AppOrder))),
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  const Img(this.url,{super.key, this.w, this.h, this.fit=BoxFit.cover, this.r=0});
  @override
  Widget build(BuildContext ctx) => ClipRRect(
    borderRadius: BorderRadius.circular(r),
    child: CachedNetworkImage(
      imageUrl: url, width:w, height:h, fit:fit,
      placeholder:(c,u)=>Shimmer.fromColors(baseColor:C.g200, highlightColor:C.g100, child:Container(width:w,height:h,color:C.g200)),
      errorWidget:(c,u,e)=>Container(width:w,height:h,color:C.g200,child:const Icon(Icons.image_not_supported_outlined,color:C.g400,size:28)),
    ),
  );
}

class Btn extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final bool loading;
  final double? w; final IconData? icon; final Color? bg; final double h;
  const Btn({super.key,required this.text,this.onPressed,this.loading=false,this.w,this.icon,this.bg,this.h=52});
  @override
  Widget build(BuildContext ctx) => SizedBox(width:w??double.infinity, height:h,
    child: ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor:bg??C.secondary, disabledBackgroundColor:C.g300),
      child: loading
        ? const SizedBox(width:20,height:20, child:_SmallLoader())
        : Row(mainAxisAlignment:MainAxisAlignment.center, children:[
            if(icon!=null)...[Icon(icon,size:18),const SizedBox(width:8)],
            Text(text),
          ]),
    ),
  );
}

class OutBtn extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final double? w;
  const OutBtn({super.key,required this.text,this.onPressed,this.w});
  @override
  Widget build(BuildContext ctx) => SizedBox(width:w??double.infinity, height:52,
    child: OutlinedButton(onPressed:onPressed, child:Text(text)));
}

class SecHeader extends StatelessWidget {
  final String title; final VoidCallback? onAll;
  const SecHeader({super.key,required this.title,this.onAll});
  @override
  Widget build(BuildContext ctx) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style:Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w700)),
      if(onAll!=null) TextButton(
        onPressed:onAll,
        style: TextButton.styleFrom(padding:EdgeInsets.zero, minimumSize:Size.zero, tapTargetSize:MaterialTapTargetSize.shrinkWrap),
        child: Row(children:[
          Text('See All', style:Theme.of(ctx).textTheme.bodySmall?.copyWith(color:C.secondary,fontWeight:FontWeight.w600)),
          const Icon(Icons.chevron_right_rounded,size:16,color:C.secondary),
        ]),
      ),
    ],
  );
}

class Stars extends StatelessWidget {
  final double rating; final int count; final double sz;
  const Stars({super.key,required this.rating,this.count=0,this.sz=14});
  @override
  Widget build(BuildContext ctx) => Row(mainAxisSize:MainAxisSize.min, children:[
    Icon(Icons.star_rounded, color:Colors.amber, size:sz),
    const SizedBox(width:2),
    Text(rating.toStringAsFixed(1), style:Theme.of(ctx).textTheme.bodySmall?.copyWith(fontWeight:FontWeight.w600,color:C.g700,fontSize:sz-2)),
    if(count>0) Text(' ($count)', style:Theme.of(ctx).textTheme.bodySmall?.copyWith(color:C.g400,fontSize:sz-2)),
  ]);
}

class DiscBadge extends StatelessWidget {
  final double pct;
  const DiscBadge({super.key,required this.pct});
  @override
  Widget build(BuildContext ctx) => Container(
    padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),
    decoration:BoxDecoration(color:C.secondary,borderRadius:BorderRadius.circular(5)),
    child:Text('-${pct.toInt()}%', style:const TextStyle(color:C.white,fontSize:10,fontWeight:FontWeight.w700)),
  );
}

class NewBadge extends StatelessWidget {
  const NewBadge({super.key});
  @override
  Widget build(BuildContext ctx) => Container(
    padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),
    decoration:BoxDecoration(color:C.primary,borderRadius:BorderRadius.circular(5)),
    child:const Text('NEW', style:TextStyle(color:C.white,fontSize:9,fontWeight:FontWeight.w800,letterSpacing:0.5)),
  );
}

class PriceRow extends StatelessWidget {
  final double price; final double? orig; final double sz; final double origSz;
  const PriceRow({super.key,required this.price,this.orig,this.sz=18,this.origSz=13});
  @override
  Widget build(BuildContext ctx) => Row(mainAxisSize:MainAxisSize.min, crossAxisAlignment:CrossAxisAlignment.baseline, textBaseline:TextBaseline.alphabetic, children:[
    Text('\$${price.toStringAsFixed(2)}', style:TextStyle(fontSize:sz,fontWeight:FontWeight.w700,color:C.primary)),
    if(orig!=null&&orig!>price)...[const SizedBox(width:5),
      Text('\$${orig!.toStringAsFixed(2)}', style:TextStyle(fontSize:origSz,fontWeight:FontWeight.w400,color:C.g400,decoration:TextDecoration.lineThrough))],
  ]);
}

class EmptyView extends StatelessWidget {
  final IconData icon; final String title, desc; final String? btnLabel; final VoidCallback? onBtn;
  const EmptyView({super.key,required this.icon,required this.title,required this.desc,this.btnLabel,this.onBtn});
  @override
  Widget build(BuildContext ctx) => Center(child:Padding(padding:const EdgeInsets.all(32), child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[
    Container(width:90,height:90, decoration:BoxDecoration(color:C.g100,shape:BoxShape.circle),
      child:Icon(icon,size:42,color:C.g400)),
    const SizedBox(height:20),
    Text(title,style:Theme.of(ctx).textTheme.headlineSmall,textAlign:TextAlign.center),
    const SizedBox(height:8),
    Text(desc,style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g500),textAlign:TextAlign.center),
    if(btnLabel!=null&&onBtn!=null)...[const SizedBox(height:28),Btn(text:btnLabel!,onPressed:onBtn,w:180)],
  ])));
}

class _SmallLoader extends StatelessWidget {
  const _SmallLoader();
  @override
  Widget build(BuildContext ctx) => const SizedBox(width:20,height:20, child:CircularProgressIndicator(strokeWidth:2,color:C.white));
}

class SizeChip extends StatelessWidget {
  final String size; final bool selected, available; final VoidCallback onTap;
  const SizeChip({super.key,required this.size,required this.selected,required this.available,required this.onTap});
  @override
  Widget build(BuildContext ctx) => GestureDetector(onTap:available?onTap:null, child:AnimatedContainer(
    duration:200.ms, width:48, height:48,
    decoration:BoxDecoration(
      color:selected?C.primary:available?C.white:C.g100,
      borderRadius:BorderRadius.circular(10),
      border:Border.all(color:selected?C.primary:C.g300,width:selected?2:1),
    ),
    child:Center(child:Text(size, style:TextStyle(fontSize:12,fontWeight:FontWeight.w600,
      color:selected?C.white:available?C.primary:C.g400,
      decoration:!available?TextDecoration.lineThrough:null))),
  ));
}

void snack(BuildContext ctx, String msg, {bool err=false, String? action, VoidCallback? onAction}) =>
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content:Text(msg), backgroundColor:err?C.error:C.primary,
    behavior:SnackBarBehavior.floating, margin:const EdgeInsets.all(16),
    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
    action: action!=null ? SnackBarAction(label:action, textColor:C.secondary, onPressed:onAction??(){}) : null,
  ));

// ╔══════════════════════════════════════════════════════════╗
// ║                  9 · BOTTOM NAVIGATION                  ║
// ╚══════════════════════════════════════════════════════════╝

class MainNav extends ConsumerWidget {
  final Widget child;
  const MainNav({super.key, required this.child});
  static const _routes = ['/','/explore','/cart','/wishlist','/profile'];
  int _idx(String loc) { for(int i=_routes.length-1;i>=0;i--) if(loc.startsWith(_routes[i])) return i; return 0; }
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final loc   = GoRouterState.of(ctx).matchedLocation;
    final cur   = _idx(loc);
    final count = ref.watch(cartCountProvider);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration:BoxDecoration(color:C.white, boxShadow:[BoxShadow(color:Colors.black.withOpacity(.08),blurRadius:20,offset:const Offset(0,-4))]),
        child:SafeArea(child:SizedBox(height:64, child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround, children:[
          _NI(Icons.home_outlined,        Icons.home_rounded,            'Home',      cur==0, ()=>ctx.go('/'),         null),
          _NI(Icons.explore_outlined,     Icons.explore_rounded,         'Explore',   cur==1, ()=>ctx.go('/explore'),  null),
          _NI(Icons.shopping_bag_outlined, Icons.shopping_bag_rounded,   'Cart',      cur==2, ()=>ctx.go('/cart'),     count>0?count:null),
          _NI(Icons.favorite_border_rounded, Icons.favorite_rounded,     'Wishlist',  cur==3, ()=>ctx.go('/wishlist'), null),
          _NI(Icons.person_outline_rounded,  Icons.person_rounded,       'Profile',   cur==4, ()=>ctx.go('/profile'),  null),
        ]))),
      ),
    );
  }
}

class _NI extends StatelessWidget {
  final IconData ic, ica; final String lbl; final bool active; final VoidCallback tap; final int? badge;
  const _NI(this.ic,this.ica,this.lbl,this.active,this.tap,this.badge);
  @override
  Widget build(BuildContext ctx) => GestureDetector(onTap:tap, behavior:HitTestBehavior.opaque,
    child:SizedBox(width:64, child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[
      Stack(clipBehavior:Clip.none, children:[
        AnimatedSwitcher(duration:200.ms, child:Icon(active?ica:ic, key:ValueKey(active), size:24, color:active?C.secondary:C.g400)),
        if(badge!=null) Positioned(right:-6,top:-6, child:Container(
          padding:const EdgeInsets.all(3),
          decoration:const BoxDecoration(color:C.secondary,shape:BoxShape.circle),
          constraints:const BoxConstraints(minWidth:16,minHeight:16),
          child:Text('$badge', style:const TextStyle(color:C.white,fontSize:9,fontWeight:FontWeight.w700), textAlign:TextAlign.center),
        )),
      ]),
      const SizedBox(height:3),
      Text(lbl, style:TextStyle(fontSize:10, fontWeight:active?FontWeight.w600:FontWeight.w400, color:active?C.secondary:C.g400)),
    ])),
  );
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
    setState(()=>_loading=true);
    final ok = await ref.read(authProvider.notifier).signIn(_ec.text.trim(), _pc.text);
    if(mounted) setState(()=>_loading=false);
    if(!ok && mounted) snack(context,'Invalid credentials', err:true);
  }

  @override
  Widget build(BuildContext ctx) {
    final h = MediaQuery.of(ctx).size.height;
    return Scaffold(body:Stack(children:[
      // ── hero background ──
      Container(height:h*.44, decoration:const BoxDecoration(color:C.primary), child:Stack(children:[
        Positioned.fill(child:CustomPaint(painter:_DiagPainter())),
        Padding(padding:EdgeInsets.fromLTRB(28,MediaQuery.of(ctx).padding.top+44,28,0), child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),
            decoration:BoxDecoration(color:C.secondary,borderRadius:BorderRadius.circular(7)),
            child:const Text('SS',style:TextStyle(color:C.white,fontSize:18,fontWeight:FontWeight.w800)),
          ).animate().fadeIn(duration:400.ms).slideY(begin:-.3,end:0),
          const SizedBox(height:18),
          Text('StyleSphere', style:GoogleFonts.poppins(fontSize:36,fontWeight:FontWeight.w800,color:C.white,letterSpacing:-1))
            .animate().fadeIn(delay:100.ms).slideX(begin:-.2,end:0),
          const SizedBox(height:6),
          Text('Dress Your World', style:GoogleFonts.poppins(fontSize:15,color:C.white.withOpacity(.6),fontWeight:FontWeight.w300,letterSpacing:2))
            .animate().fadeIn(delay:200.ms).slideX(begin:-.2,end:0),
        ])),
      ])),
      // ── white card ──
      Positioned(top:h*.32,left:0,right:0,bottom:0,child:Container(
        decoration:const BoxDecoration(color:C.white,borderRadius:BorderRadius.vertical(top:Radius.circular(30))),
        child:SingleChildScrollView(padding:const EdgeInsets.fromLTRB(28,30,28,30),child:Form(key:_fk,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Welcome back',style:Theme.of(ctx).textTheme.headlineMedium).animate().fadeIn(delay:300.ms),
          const SizedBox(height:4),
          Text('Sign in to continue',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g500)).animate().fadeIn(delay:350.ms),
          const SizedBox(height:26),
          TextFormField(controller:_ec, keyboardType:TextInputType.emailAddress, textInputAction:TextInputAction.next,
            decoration:const InputDecoration(labelText:'Email',prefixIcon:Icon(Icons.email_outlined)),
            validator:(v){if(v==null||v.isEmpty)return 'Email required';if(!v.contains('@'))return 'Invalid email';return null;},
          ).animate().fadeIn(delay:400.ms).slideY(begin:.2,end:0),
          const SizedBox(height:14),
          TextFormField(controller:_pc, obscureText:_hide, textInputAction:TextInputAction.done, onFieldSubmitted:(_)=>_login(),
            decoration:InputDecoration(labelText:'Password',prefixIcon:const Icon(Icons.lock_outline),
              suffixIcon:IconButton(icon:Icon(_hide?Icons.visibility_off_outlined:Icons.visibility_outlined,color:C.g400),onPressed:()=>setState(()=>_hide=!_hide))),
            validator:(v){if(v==null||v.isEmpty)return 'Password required';if(v.length<6)return 'Min 6 characters';return null;},
          ).animate().fadeIn(delay:450.ms).slideY(begin:.2,end:0),
          Align(alignment:Alignment.centerRight,child:TextButton(onPressed:(){},child:const Text('Forgot Password?'))),
          const SizedBox(height:6),
          Btn(text:'Sign In',loading:_loading,onPressed:_login).animate().fadeIn(delay:500.ms),
          const SizedBox(height:22),
          Row(children:[const Expanded(child:Divider()),
            Padding(padding:const EdgeInsets.symmetric(horizontal:14),child:Text('or sign in with',style:Theme.of(ctx).textTheme.bodySmall?.copyWith(color:C.g400))),
            const Expanded(child:Divider())]),
          const SizedBox(height:22),
          _GoogleBtn(onPressed:ref.read(authProvider.notifier).signInWithGoogle, loading:_loading).animate().fadeIn(delay:550.ms),
          const SizedBox(height:28),
          Center(child:RichText(text:TextSpan(text:"Don't have an account? ",style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g500),
            children:[WidgetSpan(child:GestureDetector(onTap:()=>ctx.push('/register'),child:Text('Sign Up',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.secondary,fontWeight:FontWeight.w700))))]))),
        ])))),
      ),
    ]));
  }
}

class _GoogleBtn extends StatelessWidget {
  final Future<void> Function() onPressed; final bool loading;
  const _GoogleBtn({required this.onPressed, required this.loading});
  @override Widget build(BuildContext ctx) => SizedBox(width:double.infinity,height:52,
    child:OutlinedButton(
      onPressed:loading?null:onPressed,
      style:OutlinedButton.styleFrom(side:const BorderSide(color:C.g300),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))),
      child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[
        const Text('G',style:TextStyle(color:C.secondary,fontWeight:FontWeight.w800,fontSize:17)),
        const SizedBox(width:10),
        Text('Continue with Google',style:GoogleFonts.poppins(color:C.primary,fontWeight:FontWeight.w500,fontSize:14)),
      ]),
    ),
  );
}

class _DiagPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final p = Paint()..color=Colors.white.withOpacity(.04)..strokeWidth=1;
    for(double i=-size.height;i<size.width;i+=40)
      canvas.drawLine(Offset(i,0), Offset(i+size.height,size.height), p);
  }
  @override bool shouldRepaint(_DiagPainter o) => false;
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 11 · REGISTER SCREEN                    ║
// ╚══════════════════════════════════════════════════════════╝

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override ConsumerState<RegisterScreen> createState() => _RegState();
}
class _RegState extends ConsumerState<RegisterScreen> {
  final _fk=GlobalKey<FormState>(); final _nc=TextEditingController();
  final _ec=TextEditingController(); final _pc=TextEditingController(); final _cc=TextEditingController();
  bool _hp=true,_hc=true,_load=false,_agreed=false;
  @override void dispose(){_nc.dispose();_ec.dispose();_pc.dispose();_cc.dispose();super.dispose();}

  Future<void> _reg() async {
    if(!_fk.currentState!.validate()) return;
    if(!_agreed){snack(context,'Please agree to Terms',err:true);return;}
    setState(()=>_load=true);
    await ref.read(authProvider.notifier).signUp(_nc.text.trim(),_ec.text.trim(),_pc.text);
    if(mounted) setState(()=>_load=false);
  }

  @override Widget build(BuildContext ctx) => Scaffold(backgroundColor:C.white,body:CustomScrollView(slivers:[
    SliverAppBar(backgroundColor:C.white,leading:IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded,size:20),onPressed:()=>ctx.pop())),
    SliverToBoxAdapter(child:Padding(padding:const EdgeInsets.fromLTRB(28,0,28,40),child:Form(key:_fk,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Container(padding:const EdgeInsets.symmetric(horizontal:11,vertical:5),
        decoration:BoxDecoration(color:C.secondary.withOpacity(.1),borderRadius:BorderRadius.circular(6)),
        child:const Text('StyleSphere',style:TextStyle(color:C.secondary,fontWeight:FontWeight.w700,fontSize:12,letterSpacing:1))),
      const SizedBox(height:14),
      Text('Create\nAccount',style:Theme.of(ctx).textTheme.displaySmall?.copyWith(height:1.2)).animate().fadeIn().slideX(begin:-.2,end:0),
      const SizedBox(height:8),
      Text('Join StyleSphere and discover your style',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g500)).animate().fadeIn(delay:100.ms),
      const SizedBox(height:32),
      TextFormField(controller:_nc,textCapitalization:TextCapitalization.words,textInputAction:TextInputAction.next,
        decoration:const InputDecoration(labelText:'Full Name',prefixIcon:Icon(Icons.person_outline)),
        validator:(v){if(v==null||v.trim().isEmpty)return 'Name required';return null;},
      ).animate().fadeIn(delay:200.ms).slideY(begin:.2,end:0),
      const SizedBox(height:14),
      TextFormField(controller:_ec,keyboardType:TextInputType.emailAddress,textInputAction:TextInputAction.next,
        decoration:const InputDecoration(labelText:'Email',prefixIcon:Icon(Icons.email_outlined)),
        validator:(v){if(v==null||v.isEmpty)return 'Email required';if(!v.contains('@'))return 'Invalid email';return null;},
      ).animate().fadeIn(delay:250.ms).slideY(begin:.2,end:0),
      const SizedBox(height:14),
      TextFormField(controller:_pc,obscureText:_hp,textInputAction:TextInputAction.next,
        decoration:InputDecoration(labelText:'Password',prefixIcon:const Icon(Icons.lock_outline),
          suffixIcon:IconButton(icon:Icon(_hp?Icons.visibility_off_outlined:Icons.visibility_outlined,color:C.g400),onPressed:()=>setState(()=>_hp=!_hp))),
        validator:(v){if(v==null||v.isEmpty)return 'Password required';if(v.length<6)return 'Min 6 characters';return null;},
      ).animate().fadeIn(delay:300.ms).slideY(begin:.2,end:0),
      const SizedBox(height:14),
      TextFormField(controller:_cc,obscureText:_hc,textInputAction:TextInputAction.done,
        decoration:InputDecoration(labelText:'Confirm Password',prefixIcon:const Icon(Icons.lock_outline),
          suffixIcon:IconButton(icon:Icon(_hc?Icons.visibility_off_outlined:Icons.visibility_outlined,color:C.g400),onPressed:()=>setState(()=>_hc=!_hc))),
        validator:(v){if(v!=_pc.text)return 'Passwords do not match';return null;},
      ).animate().fadeIn(delay:350.ms).slideY(begin:.2,end:0),
      const SizedBox(height:18),
      Row(children:[Checkbox(value:_agreed,onChanged:(v)=>setState(()=>_agreed=v??false)),
        Expanded(child:RichText(text:TextSpan(text:'I agree to the ',style:Theme.of(ctx).textTheme.bodySmall?.copyWith(color:C.g600),
          children:[const TextSpan(text:'Terms of Service',style:TextStyle(color:C.secondary,fontWeight:FontWeight.w600)),
            const TextSpan(text:' & '),
            const TextSpan(text:'Privacy Policy',style:TextStyle(color:C.secondary,fontWeight:FontWeight.w600))])))]),
      const SizedBox(height:24),
      Btn(text:'Sign Up',loading:_load,onPressed:_reg).animate().fadeIn(delay:400.ms),
      const SizedBox(height:22),
      Center(child:RichText(text:TextSpan(text:'Already have an account? ',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g500),
        children:[WidgetSpan(child:GestureDetector(onTap:()=>ctx.pop(),child:Text('Sign In',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.secondary,fontWeight:FontWeight.w700))))]))),
    ])))),
  ]));
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 12 · HOME SCREEN                        ║
// ╚══════════════════════════════════════════════════════════╝

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    final newArrivals = kProducts.where((p)=>p.isNew).toList();
    final featured    = kProducts.where((p)=>p.isFeatured).toList();

    return Scaffold(backgroundColor:C.g100, body:CustomScrollView(slivers:[
      // — App Bar —
      SliverAppBar(
        pinned:true, floating:true, expandedHeight:0,
        backgroundColor:C.white,
        automaticallyImplyLeading:false,
        title:Row(children:[
          Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:5),
            decoration:BoxDecoration(color:C.secondary,borderRadius:BorderRadius.circular(6)),
            child:const Text('SS',style:TextStyle(color:C.white,fontSize:14,fontWeight:FontWeight.w800))),
          const SizedBox(width:10),
          Text('StyleSphere',style:GoogleFonts.poppins(fontSize:17,fontWeight:FontWeight.w700,color:C.primary)),
        ]),
        actions:[
          IconButton(icon:const Icon(Icons.qr_code_scanner_rounded,color:C.primary), onPressed:()=>ctx.push('/qr-scanner'),tooltip:'Rack Scanner'),
          IconButton(icon:const Icon(Icons.notifications_none_rounded,color:C.primary), onPressed:(){}),
          const SizedBox(width:4),
        ],
      ),

      SliverToBoxAdapter(child:Column(children:[
        // — Search bar —
        Padding(padding:const EdgeInsets.fromLTRB(16,16,16,0),child:GestureDetector(
          onTap:()=>ctx.go('/explore'),
          child:Container(
            padding:const EdgeInsets.symmetric(horizontal:16,vertical:14),
            decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(12),
              boxShadow:[BoxShadow(color:C.shadow,blurRadius:8,offset:const Offset(0,2))]),
            child:Row(children:[
              const Icon(Icons.search_rounded,color:C.g400,size:22),
              const SizedBox(width:10),
              Text('Search clothes, brands...',style:GoogleFonts.poppins(fontSize:14,color:C.g400)),
              const Spacer(),
              const Icon(Icons.tune_rounded,color:C.primary,size:20),
            ]),
          ),
        )),

        // — Banner Slider —
        const SizedBox(height:16),
        _BannerSlider(),

        // — Categories —
        Padding(padding:const EdgeInsets.fromLTRB(16,20,16,0),child:Column(children:[
          SecHeader(title:'Categories', onAll:()=>ctx.go('/explore')),
          const SizedBox(height:14),
          SizedBox(height:100, child:ListView.separated(
            scrollDirection:Axis.horizontal, padding:EdgeInsets.zero,
            itemCount:kCategories.length,
            separatorBuilder:(_,__)=>const SizedBox(width:12),
            itemBuilder:(_,i){final cat=kCategories[i]; return GestureDetector(
              onTap:(){ ref.read(filterProvider.notifier).update((s)=>s.copyWith(category:cat.name)); ctx.go('/explore'); },
              child:Column(children:[
                Container(width:64,height:64, decoration:BoxDecoration(borderRadius:BorderRadius.circular(14),
                  boxShadow:[BoxShadow(color:cat.color.withOpacity(.15),blurRadius:8,offset:const Offset(0,4))]),
                  child:ClipRRect(borderRadius:BorderRadius.circular(14), child:Stack(children:[
                    Img(cat.imageUrl,w:64,h:64),
                    Container(decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,cat.color.withOpacity(.6)]))),
                    Center(child:Text(cat.emoji,style:const TextStyle(fontSize:26))),
                  ]))),
                const SizedBox(height:6),
                Text(cat.name,style:GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w600,color:C.primary)),
              ]),
            );},
          )),
        ])),

        // — Featured —
        Padding(padding:const EdgeInsets.fromLTRB(16,20,16,0),child:Column(children:[
          SecHeader(title:'Featured', onAll:()=>ctx.go('/explore')),
          const SizedBox(height:12),
          SizedBox(height:260, child:ListView.separated(
            scrollDirection:Axis.horizontal, padding:EdgeInsets.zero,
            itemCount:featured.length,
            separatorBuilder:(_,__)=>const SizedBox(width:12),
            itemBuilder:(_,i)=>_ProdCard(featured[i], wide:true),
          )),
        ])),

        // — New Arrivals —
        Padding(padding:const EdgeInsets.fromLTRB(16,20,16,16),child:Column(children:[
          SecHeader(title:'New Arrivals', onAll:()=>ctx.go('/explore')),
          const SizedBox(height:12),
          GridView.builder(
            shrinkWrap:true, physics:const NeverScrollableScrollPhysics(),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:.72,crossAxisSpacing:12,mainAxisSpacing:12),
            itemCount:newArrivals.length,
            itemBuilder:(_,i)=>_ProdCard(newArrivals[i]),
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
  @override void initState(){super.initState(); _timer=Timer.periodic(const Duration(seconds:4),(_){ if(_cur<kBanners.length-1) _cur++; else _cur=0; _ctrl.animateToPage(_cur,duration:600.ms,curve:Curves.easeInOutCubic); });}
  @override void dispose(){_timer?.cancel();_ctrl.dispose();super.dispose();}
  @override Widget build(BuildContext ctx) => Column(children:[
    SizedBox(height:200, child:PageView.builder(controller:_ctrl, itemCount:kBanners.length,
      onPageChanged:(i)=>setState(()=>_cur=i),
      itemBuilder:(_,i){ final b=kBanners[i]; return Padding(padding:const EdgeInsets.symmetric(horizontal:16),
        child:GestureDetector(onTap:()=>ctx.go(b.route), child:ClipRRect(borderRadius:BorderRadius.circular(18),
          child:Stack(children:[
            Img(b.imageUrl,w:double.infinity,h:200),
            Container(decoration:const BoxDecoration(gradient:C.heroGrad)),
            Padding(padding:const EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.end,children:[
              Text(b.title,style:GoogleFonts.poppins(fontSize:22,fontWeight:FontWeight.w800,color:C.white,height:1.2)),
              const SizedBox(height:4),
              Text(b.subtitle,style:GoogleFonts.poppins(fontSize:13,color:C.white.withOpacity(.85))),
              const SizedBox(height:10),
              Container(padding:const EdgeInsets.symmetric(horizontal:14,vertical:7),
                decoration:BoxDecoration(color:C.secondary,borderRadius:BorderRadius.circular(20)),
                child:Text(b.actionLabel,style:GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w600,color:C.white))),
            ])),
          ]))),
      );},
    )),
    const SizedBox(height:10),
    AnimatedSmoothIndicator(activeIndex:_cur, count:kBanners.length,
      effect:const WormEffect(dotHeight:7,dotWidth:7,activeDotColor:C.secondary,dotColor:C.g300,spacing:6)),
  ]);
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 13 · PRODUCT CARD                       ║
// ╚══════════════════════════════════════════════════════════╝

class _ProdCard extends ConsumerWidget {
  final Product p; final bool wide;
  const _ProdCard(this.p, {this.wide=false});
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final inWish = ref.watch(inWishlistProvider(p.id));
    return GestureDetector(
      onTap:(){ref.read(recentlyViewedProvider.notifier).add(p); ctx.push('/product/${p.id}',extra:p);},
      child:Container(width:wide?160:null,
        decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(16),
          boxShadow:[BoxShadow(color:C.shadow,blurRadius:8,offset:const Offset(0,3))]),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          // image
          Stack(children:[
            ClipRRect(borderRadius:const BorderRadius.vertical(top:Radius.circular(16)),
              child:Img(p.images.first, w:double.infinity, h:wide?160:160)),
            // badges
            Positioned(top:10,left:10,child:Column(children:[
              if(p.hasDiscount) DiscBadge(pct:p.discount),
              if(p.isNew) const SizedBox(height:4),
              if(p.isNew) const NewBadge(),
            ])),
            // wishlist
            Positioned(top:6,right:6,child:GestureDetector(
              onTap:()=>ref.read(wishlistProvider.notifier).toggle(p),
              child:Container(padding:const EdgeInsets.all(6),
                decoration:BoxDecoration(color:C.white.withOpacity(.9),shape:BoxShape.circle),
                child:Icon(inWish?Icons.favorite_rounded:Icons.favorite_border_rounded,
                  color:inWish?C.secondary:C.g400, size:18)),
            )),
          ]),
          // info
          Padding(padding:const EdgeInsets.fromLTRB(10,10,10,12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text(p.brand,style:GoogleFonts.poppins(fontSize:10,fontWeight:FontWeight.w500,color:C.g500,letterSpacing:.5)),
            const SizedBox(height:2),
            Text(p.name,style:GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w600,color:C.primary),maxLines:2,overflow:TextOverflow.ellipsis),
            const SizedBox(height:5),
            Stars(rating:p.rating,count:p.reviewCount,sz:12),
            const SizedBox(height:6),
            PriceRow(price:p.price,orig:p.originalPrice,sz:15,origSz:12),
          ])),
        ]),
      ),
    );
  }
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 14 · EXPLORE / LISTING SCREEN           ║
// ╚══════════════════════════════════════════════════════════╝

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});
  @override ConsumerState<ExploreScreen> createState() => _ExploreState();
}
class _ExploreState extends ConsumerState<ExploreScreen> {
  final _sc = TextEditingController();

  @override void dispose(){_sc.dispose();super.dispose();}

  @override Widget build(BuildContext ctx) {
    final products = ref.watch(filteredProductsProvider);
    final filter   = ref.watch(filterProvider);
    return Scaffold(backgroundColor:C.g100,body:CustomScrollView(slivers:[
      SliverAppBar(pinned:true,floating:true,backgroundColor:C.white,automaticallyImplyLeading:false,
        title:const Text('Explore'),
        bottom:PreferredSize(preferredSize:const Size.fromHeight(70),child:Padding(padding:const EdgeInsets.fromLTRB(16,0,16,10),child:Row(children:[
          Expanded(child:Container(
            decoration:BoxDecoration(color:C.g100,borderRadius:BorderRadius.circular(12),border:Border.all(color:C.g200)),
            child:TextField(controller:_sc,
              onChanged:(q)=>ref.read(filterProvider.notifier).update((s)=>s.copyWith(search:q.isEmpty?null:q)),
              style:GoogleFonts.poppins(fontSize:14,color:C.primary),
              decoration:InputDecoration(hintText:'Search clothes, brands...',hintStyle:GoogleFonts.poppins(fontSize:14,color:C.g400),
                prefixIcon:const Icon(Icons.search_rounded,color:C.g400,size:20),
                border:InputBorder.none,enabledBorder:InputBorder.none,focusedBorder:InputBorder.none,filled:false,
                contentPadding:const EdgeInsets.symmetric(horizontal:12,vertical:12),
                suffixIcon:_sc.text.isNotEmpty?IconButton(icon:const Icon(Icons.clear,size:18,color:C.g400),
                  onPressed:(){ _sc.clear(); ref.read(filterProvider.notifier).update((s)=>s.copyWith(clearSearch:true)); setState((){}); }):null,
              )),
          )),
          const SizedBox(width:10),
          GestureDetector(onTap:()=>_showFilters(ctx),child:AnimatedContainer(duration:200.ms,
            padding:const EdgeInsets.all(12),
            decoration:BoxDecoration(color:filter.hasFilters?C.secondary:C.white,borderRadius:BorderRadius.circular(12),border:Border.all(color:filter.hasFilters?C.secondary:C.g200)),
            child:Icon(Icons.tune_rounded,color:filter.hasFilters?C.white:C.primary,size:22))),
        ]))),
        actions:[
          PopupMenuButton<String>(icon:const Icon(Icons.sort_rounded,color:C.primary),
            onSelected:(v)=>ref.read(filterProvider.notifier).update((s)=>s.copyWith(sortBy:v)),
            itemBuilder:(_)=>[
              const PopupMenuItem(value:'popularity',child:Text('Popularity')),
              const PopupMenuItem(value:'price_low',child:Text('Price: Low to High')),
              const PopupMenuItem(value:'price_high',child:Text('Price: High to Low')),
              const PopupMenuItem(value:'newest',child:Text('Newest First')),
              const PopupMenuItem(value:'rating',child:Text('Top Rated')),
            ]),
        ],
      ),

      // Category chips
      SliverToBoxAdapter(child:SingleChildScrollView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.fromLTRB(16,12,16,0),
        child:Row(children:[
          _CatChip('All',filter.category==null,()=>ref.read(filterProvider.notifier).update((s)=>s.copyWith(clearCategory:true))),
          ...['Men','Women','Kids','Accessories'].map((c)=>_CatChip(c,filter.category==c,()=>ref.read(filterProvider.notifier).update((s)=>s.copyWith(category:c)))),
        ]),
      )),

      // Count
      SliverToBoxAdapter(child:Padding(padding:const EdgeInsets.fromLTRB(16,14,16,6),
        child:Text('${products.length} items found',style:GoogleFonts.poppins(fontSize:12,color:C.g500)))),

      // Grid
      products.isEmpty
        ? SliverFillRemaining(child:EmptyView(icon:Icons.search_off_rounded,title:'No results found',desc:'Try adjusting your search or filters',btnLabel:'Clear Filters',onBtn:()=>ref.read(filterProvider.notifier).update((_)=>const PFilter())))
        : SliverPadding(padding:const EdgeInsets.fromLTRB(16,0,16,100),
            sliver:SliverGrid(
              delegate:SliverChildBuilderDelegate((c,i)=>_ProdCard(products[i]),childCount:products.length),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:.72,crossAxisSpacing:12,mainAxisSpacing:12),
            )),
    ]));
  }

  void _showFilters(BuildContext ctx) => showModalBottomSheet(
    context:ctx, isScrollControlled:true, backgroundColor:Colors.transparent,
    builder:(_)=>const _FilterSheet(),
  );
}

class _CatChip extends StatelessWidget {
  final String label; final bool selected; final VoidCallback onTap;
  const _CatChip(this.label,this.selected,this.onTap);
  @override Widget build(BuildContext ctx) => GestureDetector(onTap:onTap,child:AnimatedContainer(duration:200.ms,
    margin:const EdgeInsets.only(right:10),padding:const EdgeInsets.symmetric(horizontal:16,vertical:8),
    decoration:BoxDecoration(color:selected?C.primary:C.white,borderRadius:BorderRadius.circular(20),
      border:Border.all(color:selected?C.primary:C.g300)),
    child:Text(label,style:GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w500,color:selected?C.white:C.g700))));
}

// Filter Bottom Sheet
class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet();
  @override ConsumerState<_FilterSheet> createState() => _FSState();
}
class _FSState extends ConsumerState<_FilterSheet> {
  late PFilter _f;
  @override void initState(){super.initState(); _f=ref.read(filterProvider);}
  void _toggleSize(String s)=>setState(()=>_f=_f.copyWith(sizes:_f.sizes.contains(s)?_f.sizes.where((x)=>x!=s).toList():[..._f.sizes,s]));
  void _toggleColor(String c)=>setState(()=>_f=_f.copyWith(colors:_f.colors.contains(c)?_f.colors.where((x)=>x!=c).toList():[..._f.colors,c]));
  @override Widget build(BuildContext ctx)=>Container(
    decoration:const BoxDecoration(color:C.white,borderRadius:BorderRadius.vertical(top:Radius.circular(24))),
    padding:const EdgeInsets.fromLTRB(20,16,20,30),
    child:SingleChildScrollView(child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[
      // handle
      Center(child:Container(width:40,height:4,decoration:BoxDecoration(color:C.g300,borderRadius:BorderRadius.circular(2)))),
      const SizedBox(height:16),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
        Text('Filters',style:Theme.of(ctx).textTheme.headlineMedium),
        TextButton(onPressed:()=>setState(()=>_f=const PFilter()),child:const Text('Clear All',style:TextStyle(color:C.secondary))),
      ]),
      const SizedBox(height:16),
      // Sizes
      Text('Sizes',style:Theme.of(ctx).textTheme.titleMedium),
      const SizedBox(height:10),
      Wrap(spacing:10,runSpacing:10,children:['XS','S','M','L','XL','XXL'].map((s)=>GestureDetector(
        onTap:()=>_toggleSize(s),
        child:AnimatedContainer(duration:200.ms,padding:const EdgeInsets.symmetric(horizontal:16,vertical:8),
          decoration:BoxDecoration(color:_f.sizes.contains(s)?C.primary:C.white,borderRadius:BorderRadius.circular(10),
            border:Border.all(color:_f.sizes.contains(s)?C.primary:C.g300)),
          child:Text(s,style:TextStyle(fontWeight:FontWeight.w600,color:_f.sizes.contains(s)?C.white:C.primary))),
      )).toList()),
      const SizedBox(height:18),
      // Price
      Text('Price Range',style:Theme.of(ctx).textTheme.titleMedium),
      RangeSlider(
        values:RangeValues(_f.minPrice??0, _f.maxPrice??500),
        min:0, max:500,
        onChanged:(v)=>setState(()=>_f=_f.copyWith(minPrice:v.start,maxPrice:v.end)),
      ),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
        Text('\$${(_f.minPrice??0).toInt()}',style:Theme.of(ctx).textTheme.bodySmall),
        Text('\$${(_f.maxPrice??500).toInt()}',style:Theme.of(ctx).textTheme.bodySmall),
      ]),
      const SizedBox(height:18),
      // Sort
      Text('Sort By',style:Theme.of(ctx).textTheme.titleMedium),
      const SizedBox(height:10),
      ...['popularity','price_low','price_high','newest','rating'].map((s){
        final labels={'popularity':'Popularity','price_low':'Price: Low to High','price_high':'Price: High to Low','newest':'Newest First','rating':'Top Rated'};
        return RadioListTile<String>(value:s,groupValue:_f.sortBy,onChanged:(v)=>setState(()=>_f=_f.copyWith(sortBy:v)),
          title:Text(labels[s]!,style:Theme.of(ctx).textTheme.bodyMedium),
          activeColor:C.secondary,dense:true,contentPadding:EdgeInsets.zero);
      }),
      const SizedBox(height:20),
      Btn(text:'Apply Filters',onPressed:(){ ref.read(filterProvider.notifier).state=_f; Navigator.pop(ctx); }),
    ])),
  );
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 15 · PRODUCT DETAIL SCREEN              ║
// ╚══════════════════════════════════════════════════════════╝

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductDetailScreen({super.key, this.product});
  @override ConsumerState<ProductDetailScreen> createState() => _PDState();
}
class _PDState extends ConsumerState<ProductDetailScreen> {
  int _imgIdx=0;
  String? _selSize;
  late PageController _pc;

  @override void initState(){super.initState(); _pc=PageController();}
  @override void dispose(){_pc.dispose();super.dispose();}

  @override Widget build(BuildContext ctx) {
    final p = widget.product;
    if(p==null) return const Scaffold(body:Center(child:Text('Product not found')));
    final inWish = ref.watch(inWishlistProvider(p.id));
    final size   = MediaQuery.of(ctx).size;

    return Scaffold(backgroundColor:C.white, body:CustomScrollView(slivers:[
      // — Image gallery app bar —
      SliverAppBar(
        expandedHeight: size.height * .48,
        pinned:true, backgroundColor:C.white,
        leading:IconButton(icon:Container(padding:const EdgeInsets.all(6),decoration:BoxDecoration(color:C.white.withOpacity(.9),shape:BoxShape.circle),child:const Icon(Icons.arrow_back_ios_new_rounded,size:18,color:C.primary)),onPressed:()=>ctx.pop()),
        actions:[
          IconButton(icon:Container(padding:const EdgeInsets.all(6),decoration:BoxDecoration(color:C.white.withOpacity(.9),shape:BoxShape.circle),
            child:Icon(inWish?Icons.favorite_rounded:Icons.favorite_border_rounded,size:20,color:inWish?C.secondary:C.primary)),
            onPressed:()=>ref.read(wishlistProvider.notifier).toggle(p)),
          IconButton(icon:Container(padding:const EdgeInsets.all(6),decoration:BoxDecoration(color:C.white.withOpacity(.9),shape:BoxShape.circle),child:const Icon(Icons.share_outlined,size:20,color:C.primary)),onPressed:(){}),
          const SizedBox(width:4),
        ],
        flexibleSpace:FlexibleSpaceBar(
          background:Stack(children:[
            PageView.builder(controller:_pc,itemCount:p.images.length,onPageChanged:(i)=>setState(()=>_imgIdx=i),
              itemBuilder:(_,i)=>Img(p.images[i],w:double.infinity,h:size.height*.48)),
            Positioned(bottom:16,left:0,right:0,child:Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(p.images.length,(i)=>
              AnimatedContainer(duration:200.ms,margin:const EdgeInsets.symmetric(horizontal:3),width:_imgIdx==i?20:7,height:7,
                decoration:BoxDecoration(color:_imgIdx==i?C.secondary:C.white.withOpacity(.7),borderRadius:BorderRadius.circular(4)))))),
          ]),
        ),
      ),

      // — Details —
      SliverToBoxAdapter(child:Padding(padding:const EdgeInsets.fromLTRB(20,20,20,120),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text(p.brand,style:GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w500,color:C.secondary,letterSpacing:.5)),
            const SizedBox(height:4),
            Text(p.name,style:Theme.of(ctx).textTheme.headlineMedium),
          ])),
          Column(crossAxisAlignment:CrossAxisAlignment.end,children:[
            PriceRow(price:p.price,orig:p.originalPrice,sz:22,origSz:15),
            if(p.hasDiscount) const SizedBox(height:4),
            if(p.hasDiscount) DiscBadge(pct:p.discount),
          ]),
        ]),
        const SizedBox(height:10),
        Row(children:[
          Stars(rating:p.rating,count:p.reviewCount,sz:14),
          const SizedBox(width:12),
          Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:4),
            decoration:BoxDecoration(color:p.isInStock?C.success.withOpacity(.1):C.error.withOpacity(.1),borderRadius:BorderRadius.circular(20)),
            child:Text(p.isInStock?'In Stock':'Out of Stock',style:GoogleFonts.poppins(fontSize:11,fontWeight:FontWeight.w600,color:p.isInStock?C.success:C.error))),
        ]),
        const SizedBox(height:20),
        const Divider(),
        const SizedBox(height:16),
        // Sizes
        Text('Select Size',style:Theme.of(ctx).textTheme.titleMedium),
        const SizedBox(height:12),
        Wrap(spacing:10,runSpacing:10,children:p.sizes.map((s)=>SizeChip(size:s,selected:_selSize==s,available:true,onTap:()=>setState(()=>_selSize=s))).toList()),
        const SizedBox(height:20),
        // Colors
        Text('Available Colors',style:Theme.of(ctx).textTheme.titleMedium),
        const SizedBox(height:8),
        Wrap(spacing:8,children:p.colors.map((c)=>Chip(label:Text(c),backgroundColor:C.g100,labelStyle:GoogleFonts.poppins(fontSize:12))).toList()),
        const SizedBox(height:20),
        const Divider(),
        const SizedBox(height:16),
        // Description
        Text('Description',style:Theme.of(ctx).textTheme.titleMedium),
        const SizedBox(height:8),
        Text(p.description,style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(height:1.7)),
        const SizedBox(height:20),
        // Details
        if(p.details.isNotEmpty)...[
          Text('Product Details',style:Theme.of(ctx).textTheme.titleMedium),
          const SizedBox(height:12),
          Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:C.g100,borderRadius:BorderRadius.circular(12)),
            child:Column(children:p.details.entries.map((e)=>Padding(padding:const EdgeInsets.only(bottom:10),
              child:Row(children:[
                SizedBox(width:100,child:Text(e.key,style:GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w600,color:C.g700))),
                Expanded(child:Text(e.value,style:GoogleFonts.poppins(fontSize:13,color:C.primary))),
              ]))).toList())),
        ],
        const SizedBox(height:20),
        // Try On
        Container(padding:const EdgeInsets.all(16),
          decoration:BoxDecoration(gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF1A1A2E),Color(0xFF16213E)]),borderRadius:BorderRadius.circular(14)),
          child:Row(children:[
            const Icon(Icons.camera_alt_rounded,color:C.secondary,size:28),
            const SizedBox(width:12),
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text('Virtual Try-On',style:GoogleFonts.poppins(fontWeight:FontWeight.w700,color:C.white,fontSize:15)),
              Text('See how it looks on you',style:GoogleFonts.poppins(color:C.white.withOpacity(.7),fontSize:12)),
            ])),
            ElevatedButton(
              onPressed:()=>ctx.push('/try-on',extra:p),
              style:ElevatedButton.styleFrom(backgroundColor:C.secondary,padding:const EdgeInsets.symmetric(horizontal:16,vertical:10)),
              child:Text('Try It',style:GoogleFonts.poppins(fontWeight:FontWeight.w600,fontSize:12,color:C.white)),
            ),
          ]),
        ),
      ]))),
    ]),
    bottomNavigationBar:SafeArea(child:Padding(padding:const EdgeInsets.fromLTRB(16,8,16,12),child:Row(children:[
      Expanded(flex:1,child:OutBtn(text:'Wishlist',onPressed:(){ref.read(wishlistProvider.notifier).toggle(p);snack(context,inWish?'Removed from wishlist':'Added to wishlist!');})),
      const SizedBox(width:12),
      Expanded(flex:2,child:Btn(text:'Add to Cart',icon:Icons.shopping_bag_outlined,onPressed:(){
        if(_selSize==null){snack(context,'Please select a size',err:true);return;}
        ref.read(cartProvider.notifier).add(p,_selSize!,p.colors.first);
        snack(context,'${p.name} added to cart',action:'View Cart',onAction:()=>context.go('/cart'));
      })),
    ]))),
    );
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
  @override void dispose(){_promoCtrl.dispose();super.dispose();}

  @override Widget build(BuildContext ctx) {
    final items    = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final sub  = notifier.subtotal;
    final ship = notifier.shipping;
    final tot  = sub - _discount + ship;

    if(items.isEmpty) return Scaffold(backgroundColor:C.g100,appBar:AppBar(title:const Text('My Cart'),backgroundColor:C.white,automaticallyImplyLeading:false),
      body:EmptyView(icon:Icons.shopping_bag_outlined,title:'Your cart is empty',desc:"Looks like you haven't added anything yet.",btnLabel:'Start Shopping',onBtn:()=>ctx.go('/explore')));

    return Scaffold(backgroundColor:C.g100, appBar:AppBar(title:const Text('My Cart'),backgroundColor:C.white,automaticallyImplyLeading:false,
      actions:[TextButton(onPressed:(){ ref.read(cartProvider.notifier).clear(); setState(()=>_discount=0); },child:const Text('Clear',style:TextStyle(color:C.secondary)))]),
      body:Column(children:[
        Expanded(child:ListView.separated(padding:const EdgeInsets.all(16),itemCount:items.length,
          separatorBuilder:(_,__)=>const SizedBox(height:12),
          itemBuilder:(_,i){ final item=items[i]; return _CartTile(item,
            onRemove:()=>ref.read(cartProvider.notifier).remove(item.id),
            onQtyChange:(q)=>ref.read(cartProvider.notifier).updateQty(item.id,q));})),
        Container(padding:const EdgeInsets.fromLTRB(16,16,16,0),
          decoration:const BoxDecoration(color:C.white,borderRadius:BorderRadius.vertical(top:Radius.circular(24)),
            boxShadow:[BoxShadow(color:C.shadow,blurRadius:16,offset:Offset(0,-4))]),
          child:Column(children:[
            // promo
            Row(children:[
              Expanded(child:TextField(controller:_promoCtrl,style:GoogleFonts.poppins(fontSize:14),
                decoration:InputDecoration(hintText:'Promo code',hintStyle:GoogleFonts.poppins(color:C.g400,fontSize:14),
                  contentPadding:const EdgeInsets.symmetric(horizontal:14,vertical:12),
                  border:OutlineInputBorder(borderRadius:BorderRadius.circular(10),borderSide:const BorderSide(color:C.g200)),
                  enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(10),borderSide:const BorderSide(color:C.g200)),
                  focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(10),borderSide:const BorderSide(color:C.secondary))))),
              const SizedBox(width:10),
              ElevatedButton(onPressed:(){
                if(_promoCtrl.text=='STYLE20'){setState(()=>_discount=sub*.2);snack(ctx,'20% discount applied! 🎉');}
                else snack(ctx,'Invalid promo code',err:true);
              },child:const Text('Apply')),
            ]),
            const SizedBox(height:14),
            _Row('Subtotal','\$${sub.toStringAsFixed(2)}'),
            if(_discount>0) _Row('Discount (STYLE20)','-\$${_discount.toStringAsFixed(2)}',valueColor:C.success),
            _Row('Shipping',ship==0?'FREE':'\$${ship.toStringAsFixed(2)}',valueColor:ship==0?C.success:null),
            const Divider(height:20),
            _Row('Total','\$${tot.toStringAsFixed(2)}',bold:true),
            const SizedBox(height:16),
            SafeArea(child:Btn(text:'Proceed to Checkout',onPressed:()=>ctx.push('/checkout'))),
            const SizedBox(height:8),
          ]),
        ),
      ]),
    );
  }
}

Widget _Row(String label, String val,{Color? valueColor,bool bold=false}) => Padding(
  padding:const EdgeInsets.symmetric(vertical:5),
  child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
    Text(label,style:GoogleFonts.poppins(fontSize:14,color:C.g600,fontWeight:bold?FontWeight.w600:FontWeight.w400)),
    Text(val,style:GoogleFonts.poppins(fontSize:14,fontWeight:bold?FontWeight.w700:FontWeight.w500,color:valueColor??C.primary)),
  ]),
);

class _CartTile extends StatelessWidget {
  final CartItem item; final VoidCallback onRemove; final ValueChanged<int> onQtyChange;
  const _CartTile(this.item,{required this.onRemove,required this.onQtyChange});
  @override Widget build(BuildContext ctx) => Container(
    padding:const EdgeInsets.all(12),
    decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:C.shadow,blurRadius:6,offset:const Offset(0,2))]),
    child:Row(children:[
      ClipRRect(borderRadius:BorderRadius.circular(10),child:Img(item.product.images.first,w:80,h:90)),
      const SizedBox(width:12),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(item.product.name,style:GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w600,color:C.primary),maxLines:2,overflow:TextOverflow.ellipsis),
        const SizedBox(height:4),
        Text('${item.selectedSize} · ${item.selectedColor}',style:GoogleFonts.poppins(fontSize:11,color:C.g500)),
        const SizedBox(height:6),
        PriceRow(price:item.product.price,sz:15),
      ])),
      Column(children:[
        IconButton(icon:const Icon(Icons.delete_outline_rounded,color:C.g400,size:20),onPressed:onRemove,padding:EdgeInsets.zero,constraints:const BoxConstraints()),
        const SizedBox(height:8),
        Row(children:[
          _QBtn(Icons.remove,()=>onQtyChange(item.quantity-1)),
          SizedBox(width:32,child:Text('${item.quantity}',textAlign:TextAlign.center,style:GoogleFonts.poppins(fontWeight:FontWeight.w700,fontSize:14))),
          _QBtn(Icons.add,()=>onQtyChange(item.quantity+1)),
        ]),
      ]),
    ]),
  );
}

class _QBtn extends StatelessWidget {
  final IconData ic; final VoidCallback onTap;
  const _QBtn(this.ic,this.onTap);
  @override Widget build(BuildContext ctx) => GestureDetector(onTap:onTap,child:Container(width:28,height:28,
    decoration:BoxDecoration(color:C.g100,borderRadius:BorderRadius.circular(7)),
    child:Icon(ic,size:16,color:C.primary)));
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 17 · WISHLIST SCREEN                    ║
// ╚══════════════════════════════════════════════════════════╝

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});
  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final items = ref.watch(wishlistProvider);
    return Scaffold(backgroundColor:C.g100,
      appBar:AppBar(title:const Text('My Wishlist'),backgroundColor:C.white,automaticallyImplyLeading:false),
      body:items.isEmpty
        ? EmptyView(icon:Icons.favorite_border_rounded,title:'Your wishlist is empty',desc:'Save items you love here.',btnLabel:'Explore Now',onBtn:()=>ctx.go('/explore'))
        : GridView.builder(padding:const EdgeInsets.all(16),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:.72,crossAxisSpacing:12,mainAxisSpacing:12),
            itemCount:items.length,itemBuilder:(_,i)=>_ProdCard(items[i])),
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
  int _step=0, _payment=0;
  bool _placing=false;

  static const _payments=['Cash on Delivery','Card Payment'];

  @override Widget build(BuildContext ctx) {
    final user  = ref.watch(authProvider).valueOrNull;
    final items = ref.watch(cartProvider);
    final sub   = ref.read(cartProvider.notifier).subtotal;
    final ship  = ref.read(cartProvider.notifier).shipping;
    final tot   = sub+ship;
    final addr  = user?.defaultAddress;

    return Scaffold(backgroundColor:C.g100,
      appBar:AppBar(title:const Text('Checkout'),backgroundColor:C.white,leading:IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded,size:20),onPressed:()=>ctx.pop())),
      body:SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        // Stepper
        Row(children:['Address','Payment','Review'].asMap().entries.map((e)=>Expanded(child:Row(children:[
          Expanded(child:Column(children:[
            Container(width:28,height:28,decoration:BoxDecoration(color:_step>=e.key?C.secondary:C.g200,shape:BoxShape.circle),
              child:Center(child:_step>e.key?const Icon(Icons.check,color:C.white,size:16):Text('${e.key+1}',style:TextStyle(color:_step>=e.key?C.white:C.g500,fontSize:12,fontWeight:FontWeight.w700)))),
            const SizedBox(height:4),
            Text(e.value,style:GoogleFonts.poppins(fontSize:10,color:_step>=e.key?C.secondary:C.g400,fontWeight:FontWeight.w500)),
          ])),
          if(e.key<2) Expanded(child:Container(height:2,color:_step>e.key?C.secondary:C.g200)),
        ]))).toList()),
        const SizedBox(height:24),

        if(_step==0)...[
          Text('Delivery Address',style:Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height:12),
          if(addr!=null) Container(padding:const EdgeInsets.all(16),
            decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(14),border:Border.all(color:C.secondary,width:1.5),
              boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),
            child:Row(children:[
              Container(padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:C.secondary.withOpacity(.1),shape:BoxShape.circle),child:const Icon(Icons.location_on_outlined,color:C.secondary)),
              const SizedBox(width:12),
              Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text(addr.name,style:Theme.of(ctx).textTheme.titleMedium),
                Text(addr.full,style:Theme.of(ctx).textTheme.bodySmall?.copyWith(height:1.5)),
                Text(addr.phone,style:Theme.of(ctx).textTheme.bodySmall),
              ])),
              const Icon(Icons.check_circle_rounded,color:C.secondary),
            ])),
          const SizedBox(height:28),
          Btn(text:'Continue to Payment',onPressed:()=>setState(()=>_step=1)),
        ],

        if(_step==1)...[
          Text('Payment Method',style:Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height:12),
          ..._payments.asMap().entries.map((e)=>GestureDetector(
            onTap:()=>setState(()=>_payment=e.key),
            child:Container(margin:const EdgeInsets.only(bottom:12),padding:const EdgeInsets.all(16),
              decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(14),
                border:Border.all(color:_payment==e.key?C.secondary:C.g200,width:_payment==e.key?1.5:1),
                boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),
              child:Row(children:[
                Icon(_payment==e.key?Icons.radio_button_checked_rounded:Icons.radio_button_unchecked_rounded,color:_payment==e.key?C.secondary:C.g300),
                const SizedBox(width:12),
                Icon(e.key==0?Icons.local_shipping_outlined:Icons.credit_card_rounded,color:C.primary),
                const SizedBox(width:10),
                Text(e.value,style:Theme.of(ctx).textTheme.titleMedium),
              ])),
          )),
          if(_payment==1) Padding(padding:const EdgeInsets.only(bottom:16),child:Container(padding:const EdgeInsets.all(16),
            decoration:BoxDecoration(color:C.g100,borderRadius:BorderRadius.circular(12)),
            child:Column(children:[
              TextFormField(decoration:const InputDecoration(labelText:'Card Number')),
              const SizedBox(height:12),
              Row(children:[Expanded(child:TextFormField(decoration:const InputDecoration(labelText:'MM/YY'))),const SizedBox(width:12),Expanded(child:TextFormField(decoration:const InputDecoration(labelText:'CVV')))]),
            ]))),
          Row(children:[Expanded(child:OutBtn(text:'Back',onPressed:()=>setState(()=>_step=0))),const SizedBox(width:12),Expanded(flex:2,child:Btn(text:'Review Order',onPressed:()=>setState(()=>_step=2)))]),
        ],

        if(_step==2)...[
          Text('Order Summary',style:Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height:12),
          ...items.map((item)=>Padding(padding:const EdgeInsets.only(bottom:10),child:Container(padding:const EdgeInsets.all(12),
            decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(12),boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),
            child:Row(children:[
              ClipRRect(borderRadius:BorderRadius.circular(8),child:Img(item.product.images.first,w:56,h:64)),
              const SizedBox(width:10),
              Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Text(item.product.name,style:Theme.of(ctx).textTheme.titleSmall,maxLines:1,overflow:TextOverflow.ellipsis),
                Text('${item.selectedSize} × ${item.quantity}',style:Theme.of(ctx).textTheme.bodySmall),
              ])),
              Text('\$${item.total.toStringAsFixed(2)}',style:Theme.of(ctx).textTheme.titleSmall?.copyWith(color:C.primary)),
            ])))),
          const SizedBox(height:8),
          Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),child:Column(children:[
            _Row('Subtotal','\$${sub.toStringAsFixed(2)}'),
            _Row('Shipping',ship==0?'FREE':'\$${ship.toStringAsFixed(2)}',valueColor:ship==0?C.success:null),
            const Divider(height:16),
            _Row('Total','\$${tot.toStringAsFixed(2)}',bold:true),
          ])),
          const SizedBox(height:20),
          Row(children:[Expanded(child:OutBtn(text:'Back',onPressed:()=>setState(()=>_step=1))),const SizedBox(width:12),Expanded(flex:2,child:Btn(text:'Place Order',loading:_placing,onPressed:() async {
            setState(()=>_placing=true);
            if(addr==null){setState(()=>_placing=false);return;}
            final order = await ref.read(ordersProvider.notifier).place(items:items,address:addr,payment:_payments[_payment]);
            ref.read(cartProvider.notifier).clear();
            setState(()=>_placing=false);
            if(mounted) ctx.pushReplacement('/order-success',extra:order);
          }))]),
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
  @override Widget build(BuildContext ctx) => Scaffold(backgroundColor:C.white,body:SafeArea(child:Padding(padding:const EdgeInsets.all(32),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
    Container(width:100,height:100,decoration:const BoxDecoration(color:Color(0xFFE8F5E9),shape:BoxShape.circle),
      child:const Icon(Icons.check_circle_rounded,color:C.success,size:60)).animate().scale(delay:200.ms,duration:500.ms,curve:Curves.elasticOut),
    const SizedBox(height:24),
    Text('Order Placed!',style:Theme.of(ctx).textTheme.displaySmall).animate().fadeIn(delay:400.ms),
    const SizedBox(height:8),
    Text('Your order ${order.orderNumber} has been placed successfully.',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g600,height:1.5),textAlign:TextAlign.center).animate().fadeIn(delay:500.ms),
    const SizedBox(height:32),
    Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:C.g100,borderRadius:BorderRadius.circular(16)),child:Column(children:[
      _Row('Order No.',order.orderNumber),
      _Row('Payment',order.paymentMethod),
      _Row('Estimated Delivery','${order.estimatedDelivery?.day}/${order.estimatedDelivery?.month}/${order.estimatedDelivery?.year}'),
      const Divider(height:16),
      _Row('Total','\$${order.total.toStringAsFixed(2)}',bold:true),
    ])).animate().fadeIn(delay:600.ms),
    const SizedBox(height:32),
    Btn(text:'Track My Order',onPressed:()=>ctx.pushReplacement('/orders')).animate().fadeIn(delay:700.ms),
    const SizedBox(height:12),
    OutBtn(text:'Continue Shopping',onPressed:()=>ctx.go('/')).animate().fadeIn(delay:800.ms),
  ])));
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 20 · ORDERS SCREEN                      ║
// ╚══════════════════════════════════════════════════════════╝

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});
  @override Widget build(BuildContext ctx, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(backgroundColor:C.g100,
      appBar:AppBar(title:const Text('My Orders'),backgroundColor:C.white,leading:IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded,size:20),onPressed:()=>ctx.pop())),
      body:orders.isEmpty
        ? EmptyView(icon:Icons.receipt_long_outlined,title:'No orders yet',desc:'Your order history will appear here.')
        : ListView.separated(padding:const EdgeInsets.all(16),itemCount:orders.length,
            separatorBuilder:(_,__)=>const SizedBox(height:12),
            itemBuilder:(_,i)=>_OrderCard(orders[i])),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final AppOrder o;
  const _OrderCard(this.o);
  @override Widget build(BuildContext ctx) => Container(
    padding:const EdgeInsets.all(16),
    decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(16),boxShadow:[BoxShadow(color:C.shadow,blurRadius:8,offset:const Offset(0,3))]),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
        Text(o.orderNumber,style:GoogleFonts.poppins(fontWeight:FontWeight.w700,fontSize:14,color:C.primary)),
        Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:4),
          decoration:BoxDecoration(color:o.status.color.withOpacity(.1),borderRadius:BorderRadius.circular(20)),
          child:Text(o.status.label,style:GoogleFonts.poppins(fontSize:11,fontWeight:FontWeight.w600,color:o.status.color))),
      ]),
      const SizedBox(height:8),
      Text('${o.createdAt.day}/${o.createdAt.month}/${o.createdAt.year}',style:Theme.of(ctx).textTheme.bodySmall?.copyWith(color:C.g500)),
      const SizedBox(height:12),
      // Progress
      if(o.status!=OrderStatus.cancelled)...[
        Row(children:List.generate(4,(i){
          final active=o.status.step>=i;
          return Expanded(child:Row(children:[
            Container(width:20,height:20,decoration:BoxDecoration(color:active?C.secondary:C.g200,shape:BoxShape.circle),
              child:Center(child:Icon(Icons.check,size:12,color:active?C.white:C.g400))),
            if(i<3)Expanded(child:Container(height:2,color:active&&o.status.step>i?C.secondary:C.g200)),
          ]));
        })),
        const SizedBox(height:6),
        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:['Placed','Processing','Shipped','Delivered'].map((s)=>Text(s,style:GoogleFonts.poppins(fontSize:9,color:C.g400))).toList()),
        const SizedBox(height:12),
      ],
      const Divider(),
      const SizedBox(height:8),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
        Text('Total',style:Theme.of(ctx).textTheme.bodyMedium?.copyWith(color:C.g600)),
        Text('\$${o.total.toStringAsFixed(2)}',style:GoogleFonts.poppins(fontWeight:FontWeight.w700,fontSize:15,color:C.primary)),
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
    return Scaffold(backgroundColor:C.g100,
      appBar:AppBar(title:const Text('My Profile'),backgroundColor:C.white,automaticallyImplyLeading:false),
      body:SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(children:[
        // Avatar card
        Container(padding:const EdgeInsets.all(20),
          decoration:BoxDecoration(gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[C.primary,C.primaryLight]),borderRadius:BorderRadius.circular(20)),
          child:Row(children:[
            CircleAvatar(radius:34, backgroundColor:C.secondary,
              child:Text(user?.name.isNotEmpty==true?user!.name[0].toUpperCase():'?',style:GoogleFonts.poppins(fontSize:26,fontWeight:FontWeight.w700,color:C.white))),
            const SizedBox(width:16),
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text(user?.name??'Guest',style:GoogleFonts.poppins(fontWeight:FontWeight.w700,fontSize:17,color:C.white)),
              Text(user?.email??'',style:GoogleFonts.poppins(fontSize:13,color:C.white.withOpacity(.75))),
              const SizedBox(height:6),
              Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:3),decoration:BoxDecoration(color:C.secondary,borderRadius:BorderRadius.circular(20)),child:const Text('Premium Member',style:TextStyle(color:C.white,fontSize:11,fontWeight:FontWeight.w600))),
            ])),
          ])),
        const SizedBox(height:16),
        // Stats
        Row(children:[
          _StatCard('Orders',ref.watch(ordersProvider).length.toString(),Icons.receipt_long_outlined),
          const SizedBox(width:12),
          _StatCard('Wishlist',ref.watch(wishlistProvider).length.toString(),Icons.favorite_border_rounded),
          const SizedBox(width:12),
          _StatCard('Reviews','5',Icons.star_border_rounded),
        ]),
        const SizedBox(height:16),
        // Menu
        _MenuSection('Shopping',[
          _MenuItem(Icons.receipt_long_outlined,'My Orders',()=>ctx.push('/orders')),
          _MenuItem(Icons.favorite_border_rounded,'Wishlist',()=>ctx.go('/wishlist')),
          _MenuItem(Icons.location_on_outlined,'Addresses',(){}),
          _MenuItem(Icons.local_offer_outlined,'Promo Codes',(){}),
        ]),
        const SizedBox(height:12),
        _MenuSection('Features',[
          _MenuItem(Icons.camera_alt_outlined,'Virtual Try-On',()=>ctx.push('/try-on')),
          _MenuItem(Icons.qr_code_scanner_rounded,'QR Rack Scanner',()=>ctx.push('/qr-scanner')),
        ]),
        const SizedBox(height:12),
        _MenuSection('Account',[
          _MenuItem(Icons.notifications_none_rounded,'Notifications',(){}),
          _MenuItem(Icons.help_outline_rounded,'Help & Support',(){}),
          _MenuItem(Icons.privacy_tip_outlined,'Privacy Policy',(){}),
          _MenuItem(Icons.info_outline_rounded,'About StyleSphere',(){}),
        ]),
        const SizedBox(height:12),
        Container(decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),
          child:ListTile(leading:const Icon(Icons.logout_rounded,color:C.error),title:Text('Logout',style:GoogleFonts.poppins(color:C.error,fontWeight:FontWeight.w600)),
            onTap:()=>ref.read(authProvider.notifier).signOut())),
        const SizedBox(height:24),
      ])),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label,val; final IconData ic;
  const _StatCard(this.label,this.val,this.ic);
  @override Widget build(BuildContext ctx)=>Expanded(child:Container(padding:const EdgeInsets.all(14),
    decoration:BoxDecoration(color:C.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),
    child:Column(children:[Icon(ic,color:C.secondary,size:22),const SizedBox(height:6),Text(val,style:GoogleFonts.poppins(fontWeight:FontWeight.w700,fontSize:18,color:C.primary)),Text(label,style:GoogleFonts.poppins(fontSize:11,color:C.g500))])));
}

Widget _MenuSection(String title, List<Widget> items)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  Padding(padding:const EdgeInsets.only(left:4,bottom:8),child:Text(title,style:GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w600,color:C.g500,letterSpacing:.5))),
  Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(14),boxShadow:[BoxShadow(color:C.shadow,blurRadius:6)]),
    child:Column(children:items.asMap().entries.map((e)=>Column(children:[e.value,if(e.key<items.length-1)const Divider(height:1,indent:52)])).toList())),
]);

class _MenuItem extends StatelessWidget {
  final IconData ic; final String label; final VoidCallback onTap;
  const _MenuItem(this.ic,this.label,this.onTap);
  @override Widget build(BuildContext ctx)=>ListTile(leading:Icon(ic,color:C.primary,size:22),title:Text(label,style:GoogleFonts.poppins(fontSize:14,fontWeight:FontWeight.w500)),trailing:const Icon(Icons.chevron_right_rounded,color:C.g400),onTap:onTap);
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 22 · VIRTUAL TRY-ON SCREEN              ║
// ╚══════════════════════════════════════════════════════════╝

class TryOnScreen extends ConsumerStatefulWidget {
  final Product? product;
  const TryOnScreen({super.key, this.product});
  @override ConsumerState<TryOnScreen> createState() => _TOState();
}
class _TOState extends ConsumerState<TryOnScreen> with SingleTickerProviderStateMixin {
  bool _detecting=true, _bodyFound=false, _captured=false;
  double _scale=1.0, _ox=0, _oy=-40;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulse;

  @override void initState(){
    super.initState();
    _pulseCtrl=AnimationController(vsync:this,duration:const Duration(seconds:1))..repeat(reverse:true);
    _pulse=Tween<double>(begin:.95,end:1.05).animate(CurvedAnimation(parent:_pulseCtrl,curve:Curves.easeInOut));
    Future.delayed(const Duration(seconds:2),(){if(mounted)setState(()=>_bodyFound=true);});
    Future.delayed(const Duration(seconds:3),(){if(mounted)setState(()=>_detecting=false);});
  }
  @override void dispose(){_pulseCtrl.dispose();super.dispose();}

  @override Widget build(BuildContext ctx) {
    final p = widget.product;
    return Scaffold(backgroundColor:C.black,
      body:Stack(children:[
        // — Simulated camera feed —
        Positioned.fill(child:CustomPaint(painter:_CamPainter())),

        // — Clothing overlay on "body" —
        if(_bodyFound&&p!=null) Positioned.fill(child:GestureDetector(
          onScaleUpdate:(d){setState((){_scale=(_scale*d.scale).clamp(.5,2.5);_ox+=d.focalPointDelta.dx;_oy+=d.focalPointDelta.dy;});},
          child:Center(child:Transform.translate(offset:Offset(_ox,_oy),
            child:ScaleTransition(scale:_pulse,child:Transform.scale(scale:_scale,
              child:AnimatedOpacity(opacity:_bodyFound?1:0,duration:600.ms,child:Container(
                width:200,height:280,
                decoration:BoxDecoration(
                  gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,
                    colors:[C.secondary.withOpacity(.85), C.primary.withOpacity(.9)]),
                  borderRadius:BorderRadius.circular(12),
                  border:Border.all(color:C.white.withOpacity(.3),width:1),
                ),
                child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
                  const Icon(Icons.checkroom_rounded,color:C.white,size:48),
                  const SizedBox(height:8),
                  Text(p.name,style:GoogleFonts.poppins(color:C.white,fontSize:13,fontWeight:FontWeight.w600),textAlign:TextAlign.center,maxLines:2),
                  Text('AR Preview',style:GoogleFonts.poppins(color:C.white.withOpacity(.7),fontSize:10)),
                ]),
              )),
            )),
          )),
        )),

        // — Body detection indicator —
        if(_detecting) Positioned.fill(child:Container(color:Colors.black.withOpacity(.3),child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
          const CircularProgressIndicator(color:C.secondary,strokeWidth:3),
          const SizedBox(height:16),
          Text('Detecting body pose...',style:GoogleFonts.poppins(color:C.white,fontSize:15,fontWeight:FontWeight.w500)),
          const SizedBox(height:6),
          Text('Stand 2-3 feet from camera',style:GoogleFonts.poppins(color:C.white.withOpacity(.7),fontSize:12)),
        ])))),

        // — Top bar —
        Positioned(top:0,left:0,right:0,child:SafeArea(child:Padding(padding:const EdgeInsets.all(16),child:Row(children:[
          GestureDetector(onTap:()=>ctx.pop(),child:Container(padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:Colors.black.withOpacity(.5),shape:BoxShape.circle),child:const Icon(Icons.close,color:C.white,size:20))),
          const SizedBox(width:12),
          Expanded(child:Text('Virtual Try-On',style:GoogleFonts.poppins(color:C.white,fontWeight:FontWeight.w700,fontSize:16))),
          if(_bodyFound) Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:6),decoration:BoxDecoration(color:C.success,borderRadius:BorderRadius.circular(20)),child:Row(children:[const Icon(Icons.person,color:C.white,size:14),const SizedBox(width:4),Text('Body Detected',style:GoogleFonts.poppins(color:C.white,fontSize:11,fontWeight:FontWeight.w600))])),
        ])))),

        // — Instructions —
        if(!_detecting) Positioned(top:100,left:0,right:0,child:Center(child:Container(
          padding:const EdgeInsets.symmetric(horizontal:16,vertical:8),
          decoration:BoxDecoration(color:Colors.black.withOpacity(.5),borderRadius:BorderRadius.circular(20)),
          child:Text('Pinch to resize · Drag to reposition',style:GoogleFonts.poppins(color:C.white,fontSize:12)),
        ))),

        // — Capture overlay —
        if(_captured) Positioned.fill(child:AnimatedOpacity(opacity:_captured?1:0,duration:200.ms,child:Container(color:C.white))),

        // — Bottom controls —
        Positioned(bottom:0,left:0,right:0,child:SafeArea(child:Padding(padding:const EdgeInsets.fromLTRB(20,16,20,20),child:Column(mainAxisSize:MainAxisSize.min,children:[
          // Fit adjusters
          Row(mainAxisAlignment:MainAxisAlignment.center,children:[
            _TBtn(Icons.remove,(){if(_scale>.5)setState(()=>_scale-=.1);},'Smaller'),
            const SizedBox(width:20),
            _TBtn(Icons.refresh_rounded,(){setState((){_scale=1;_ox=0;_oy=-40;});},'Reset'),
            const SizedBox(width:20),
            _TBtn(Icons.add,(){if(_scale<2.5)setState(()=>_scale+=.1);},'Larger'),
          ]),
          const SizedBox(height:20),
          // Capture button
          Row(mainAxisAlignment:MainAxisAlignment.center,children:[
            GestureDetector(
              onTap:(){ setState(()=>_captured=true); Future.delayed(const Duration(milliseconds:200),(){if(mounted)setState(()=>_captured=false);}); snack(ctx,'Screenshot saved! 📸'); },
              child:Container(width:72,height:72,decoration:BoxDecoration(color:C.white,shape:BoxShape.circle,border:Border.all(color:C.g300,width:3)),
                child:const Center(child:Icon(Icons.camera_alt_rounded,color:C.primary,size:32))),
            ),
          ]),
        ])))),
      ]),
    );
  }
}

class _TBtn extends StatelessWidget {
  final IconData ic; final VoidCallback onTap; final String label;
  const _TBtn(this.ic,this.onTap,this.label);
  @override Widget build(BuildContext ctx)=>Column(mainAxisSize:MainAxisSize.min,children:[
    GestureDetector(onTap:onTap,child:Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:Colors.black.withOpacity(.5),shape:BoxShape.circle),child:Icon(ic,color:C.white,size:22))),
    const SizedBox(height:4),
    Text(label,style:GoogleFonts.poppins(color:C.white,fontSize:10)),
  ]);
}

class _CamPainter extends CustomPainter {
  final _rng = math.Random(42);
  @override void paint(Canvas canvas, Size size){
    // Gradient background simulating camera
    canvas.drawRect(Offset.zero&size, Paint()..shader=const LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,
      colors:[Color(0xFF1a1a2e),Color(0xFF16213e),Color(0xFF0f3460)]).createShader(Offset.zero&size));
    // Simulated body silhouette
    final cx=size.width/2, cy=size.height*.45;
    // Head
    canvas.drawCircle(Offset(cx,cy-160),36,Paint()..color=const Color(0xFF8B6F47).withOpacity(.7));
    // Body
    final bp=Paint()..color=const Color(0xFF6B5B45).withOpacity(.6);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center:Offset(cx,cy),width:130,height:200),const Radius.circular(20)),bp);
    // Pose dots
    final dp=Paint()..color=C.secondary.withOpacity(.9);
    for(final o in[Offset(cx,cy-180),Offset(cx-60,cy-120),Offset(cx+60,cy-120),Offset(cx-70,cy-60),Offset(cx+70,cy-60),Offset(cx,cy-60),Offset(cx-50,cy+60),Offset(cx+50,cy+60),Offset(cx-50,cy+160),Offset(cx+50,cy+160)])
      canvas.drawCircle(o,5,dp);
    // Skeleton lines
    final lp=Paint()..color=C.secondary.withOpacity(.5)..strokeWidth=2;
    void ln(Offset a,Offset b)=>canvas.drawLine(a,b,lp);
    ln(Offset(cx,cy-180),Offset(cx,cy-60));
    ln(Offset(cx,cy-120),Offset(cx-70,cy-60));
    ln(Offset(cx,cy-120),Offset(cx+70,cy-60));
    ln(Offset(cx,cy-60),Offset(cx-50,cy+60));
    ln(Offset(cx,cy-60),Offset(cx+50,cy+60));
    ln(Offset(cx-50,cy+60),Offset(cx-50,cy+160));
    ln(Offset(cx+50,cy+60),Offset(cx+50,cy+160));
    // Scan line
    final scanY=size.height*.3;
    canvas.drawLine(Offset(0,scanY),Offset(size.width,scanY),Paint()..color=C.secondary.withOpacity(.4)..strokeWidth=1.5);
    // Corner brackets
    final br=Paint()..color=C.secondary..strokeWidth=3..style=PaintingStyle.stroke;
    const m=40.0, bl=25.0;
    for(final c in[Offset(m,m),Offset(size.width-m,m),Offset(m,size.height-m),Offset(size.width-m,size.height-m)]){
      final dx=c.dx<size.width/2?1:-1, dy=c.dy<size.height/2?1:-1;
      canvas.drawPath(Path()..moveTo(c.dx,c.dy+dy*bl)..lineTo(c.dx,c.dy)..lineTo(c.dx+dx*bl,c.dy),br);
    }
  }
  @override bool shouldRepaint(_CamPainter o)=>false;
}

// ╔══════════════════════════════════════════════════════════╗
// ║                 23 · QR SCANNER SCREEN                  ║
// ╚══════════════════════════════════════════════════════════╝

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});
  @override ConsumerState<QrScannerScreen> createState() => _QRState();
}
class _QRState extends ConsumerState<QrScannerScreen> with SingleTickerProviderStateMixin {
  bool _scanning=true, _scanned=false;
  String? _scannedRack;
  late AnimationController _scanCtrl;
  late Animation<double> _scanAnim;

  @override void initState(){
    super.initState();
    _scanCtrl=AnimationController(vsync:this,duration:const Duration(seconds:2))..repeat();
    _scanAnim=Tween<double>(begin:0,end:1).animate(_scanCtrl);
  }
  @override void dispose(){_scanCtrl.dispose();super.dispose();}

  void _simulateScan(String rackId){
    if(_scanned)return;
    setState((){_scanned=true;_scanning=false;_scannedRack=rackId;});
    HapticFeedback.heavyImpact();
  }

  @override Widget build(BuildContext ctx)=>Scaffold(backgroundColor:C.black,
    body:Stack(children:[
      // Camera bg
      Positioned.fill(child:Container(decoration:const BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Color(0xFF0a0a1a),Color(0xFF1a1a2e)])))),

      // QR frame
      Positioned.fill(child:CustomPaint(painter:_QRFramePainter(_scanAnim))),

      // Top bar
      Positioned(top:0,left:0,right:0,child:SafeArea(child:Padding(padding:const EdgeInsets.all(16),child:Row(children:[
        GestureDetector(onTap:()=>ctx.pop(),child:Container(padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:Colors.black54,shape:BoxShape.circle),child:const Icon(Icons.close,color:C.white,size:20))),
        const SizedBox(width:12),
        Text('Rack Scanner',style:GoogleFonts.poppins(color:C.white,fontWeight:FontWeight.w700,fontSize:16)),
      ])))),

      // Instructions
      Positioned(top:130,left:40,right:40,child:Text('Point camera at the QR code on any clothing rack',style:GoogleFonts.poppins(color:C.white.withOpacity(.8),fontSize:14),textAlign:TextAlign.center)),

      // Mock rack buttons
      if(_scanning) Positioned(bottom:160,left:20,right:20,child:Column(children:[
        Text('Demo: Tap a rack to simulate scan',style:GoogleFonts.poppins(color:C.white.withOpacity(.6),fontSize:12),textAlign:TextAlign.center),
        const SizedBox(height:12),
        Wrap(spacing:10,runSpacing:10,alignment:WrapAlignment.center,children:kRackNames.entries.map((e)=>GestureDetector(
          onTap:()=>_simulateScan(e.key),
          child:Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:8),
            decoration:BoxDecoration(color:C.secondary.withOpacity(.15),borderRadius:BorderRadius.circular(20),border:Border.all(color:C.secondary.withOpacity(.5))),
            child:Text(e.value,style:GoogleFonts.poppins(color:C.white,fontSize:11,fontWeight:FontWeight.w500))),
        )).toList()),
      ])),

      // Success state
      if(_scanned&&_scannedRack!=null) Positioned.fill(child:Container(color:Colors.black.withOpacity(.6),child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
        const Icon(Icons.check_circle_rounded,color:C.secondary,size:72).animate().scale(duration:500.ms,curve:Curves.elasticOut),
        const SizedBox(height:16),
        Text('Rack Found!',style:GoogleFonts.poppins(color:C.white,fontWeight:FontWeight.w700,fontSize:22)).animate().fadeIn(delay:200.ms),
        const SizedBox(height:8),
        Text(kRackNames[_scannedRack]??'',style:GoogleFonts.poppins(color:C.secondary,fontSize:16,fontWeight:FontWeight.w600)).animate().fadeIn(delay:300.ms),
        const SizedBox(height:28),
        ElevatedButton.icon(
          onPressed:()=>ctx.pushReplacement('/rack/$_scannedRack',extra:kRackNames[_scannedRack]),
          icon:const Icon(Icons.grid_view_rounded),label:const Text('View Rack Items'),
          style:ElevatedButton.styleFrom(backgroundColor:C.secondary,padding:const EdgeInsets.symmetric(horizontal:24,vertical:14),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))),
        ).animate().fadeIn(delay:400.ms),
        const SizedBox(height:12),
        TextButton(onPressed:(){setState((){_scanned=false;_scanning=true;_scannedRack=null;});},child:const Text('Scan Again',style:TextStyle(color:C.white))),
      ])))),

      // Bottom tip
      if(!_scanned) Positioned(bottom:0,left:0,right:0,child:SafeArea(child:Padding(padding:const EdgeInsets.all(20),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[
        const Icon(Icons.lightbulb_outline_rounded,color:Colors.amber,size:16),
        const SizedBox(width:6),
        Text('Each rack has a unique QR code',style:GoogleFonts.poppins(color:C.white.withOpacity(.7),fontSize:12)),
      ])))),
    ]),
  );
}

class _QRFramePainter extends CustomPainter {
  final Animation<double> anim;
  _QRFramePainter(this.anim):super(repaint:anim);
  @override void paint(Canvas canvas, Size sz){
    final cx=sz.width/2,cy=sz.height/2,s=220.0,r=16.0;
    final outer=Paint()..color=Colors.black.withOpacity(.7);
    canvas.drawPath(Path.combine(PathOperation.difference,
      Path()..addRect(Offset.zero&sz),
      Path()..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center:Offset(cx,cy),width:s,height:s),Radius.circular(r)))),outer);
    // Corner brackets
    final p=Paint()..color=C.secondary..strokeWidth=4..style=PaintingStyle.stroke;
    final l=s/2,tl=s/2-20,bl=28.0;
    for(final c in[Offset(cx-l+r,cy-l+r),Offset(cx+l-r,cy-l+r),Offset(cx-l+r,cy+l-r),Offset(cx+l-r,cy+l-r)]){
      final dx=c.dx<cx?-1:1,dy=c.dy<cy?-1:1;
      canvas.drawPath(Path()..moveTo(c.dx+dx*bl,c.dy)..lineTo(c.dx,c.dy)..lineTo(c.dx,c.dy+dy*bl),p);
    }
    // Scan line
    final scanY=cy-l+r+(s-2*r)*anim.value;
    canvas.drawLine(Offset(cx-l+r+4,scanY),Offset(cx+l-r-4,scanY),Paint()..color=C.secondary..strokeWidth=2.5);
  }
  @override bool shouldRepaint(_QRFramePainter o)=>true;
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
    final ids = kRackMap[rackId] ?? [];
    final products = kProducts.where((p)=>ids.contains(p.id)).toList();

    return Scaffold(backgroundColor:C.g100,
      appBar:AppBar(
        title:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const Text('Rack Items',style:TextStyle(fontSize:16)),
          Text(rackName,style:GoogleFonts.poppins(fontSize:11,color:C.secondary,fontWeight:FontWeight.w500)),
        ]),
        backgroundColor:C.white,
        leading:IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded,size:20),onPressed:()=>ctx.pop()),
        actions:[IconButton(icon:const Icon(Icons.qr_code_scanner_rounded,color:C.secondary),onPressed:()=>ctx.pushReplacement('/qr-scanner'))],
      ),
      body:products.isEmpty
        ? const EmptyView(icon:Icons.checkroom_outlined,title:'No items on this rack',desc:'This rack appears to be empty.')
        : GridView.builder(padding:const EdgeInsets.all(16),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:.72,crossAxisSpacing:12,mainAxisSpacing:12),
            itemCount:products.length, itemBuilder:(_,i)=>_ProdCard(products[i])),
    );
  }
}