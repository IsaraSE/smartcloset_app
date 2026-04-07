
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
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.price,
    this.originalPrice,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.rating,
    required this.reviewCount,
    this.soldCount = 0,
    this.isNew = false,
    this.isFeatured = false,
    this.isInStock = true,
    this.rackId,
    this.rackName,
    this.details = const {},
  });

  double get discount => (originalPrice != null && originalPrice! > price)
      ? ((originalPrice! - price) / originalPrice! * 100).roundToDouble()
      : 0;
  bool get hasDiscount => discount > 0;
}
