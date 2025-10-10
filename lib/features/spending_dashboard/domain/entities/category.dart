enum SpendStatus { UNDER_SPENT, OVER_THRESHOLD_SPENT, OVER_SPENT }

class Category {
  final String finleyCategory;
  final String displayName;
  final double categorySpend;
  final double spendRemaining;
  final double spendPercentage;
  final SpendStatus spendStatus;

  Category({
    required this.finleyCategory,
    required this.displayName,
    required this.categorySpend,
    required this.spendRemaining,
    required this.spendPercentage,
    required this.spendStatus,
  });
}
