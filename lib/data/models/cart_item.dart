import 'package:aura_app/data/models/product.dart';

class CartItem {
  final String id, selectedSize, selectedColor;
  final Product product;
  final int quantity;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
  });

  double get total => product.price * quantity;

  CartItem copyWith({int? quantity}) => CartItem(
        id: id,
        product: product,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
        quantity: quantity ?? this.quantity,
      );
}
