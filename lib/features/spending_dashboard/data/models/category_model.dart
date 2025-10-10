import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.finleyCategory,
    required super.displayName,
    required super.categorySpend,
    required super.spendRemaining,
    required super.spendPercentage,
    required super.spendStatus,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> j) {
    SpendStatus status = SpendStatus.values.firstWhere(
      (s) => s.name == (j['spendStatus'] ?? 'UNDER_SPENT'),
      orElse: () => SpendStatus.UNDER_SPENT,
    );

    return CategoryModel(
      finleyCategory: j['finleyCategory'] ?? '',
      displayName: j['finleyCategoryName'] ?? '',
      categorySpend: (j['categorySpend'] ?? 0).toDouble(),
      spendRemaining: (j['spendRemaining'] ?? 0).toDouble(),
      spendPercentage: (j['spendPercentage'] ?? 0).toDouble(),
      spendStatus: status,
    );
  }
}
