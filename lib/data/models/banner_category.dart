
class BannerData {
  final String id, imageUrl, title, subtitle, actionLabel, route, tag;
  const BannerData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.route,
    this.tag = '',
  });
}

class CategoryData {
  final String id, name, emoji, imageUrl;
  const CategoryData({
    required this.id,
    required this.name,
    required this.emoji,
    required this.imageUrl,
  });
}
