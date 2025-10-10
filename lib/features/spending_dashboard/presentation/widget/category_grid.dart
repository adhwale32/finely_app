import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/category.dart';
Color _statusColor(SpendStatus s) {
  switch (s) {
    case SpendStatus.UNDER_SPENT:
      return Color(0xFF00C853);
    case SpendStatus.OVER_THRESHOLD_SPENT:
      return Color(0xFFFFB300);
    case SpendStatus.OVER_SPENT:
      return Color(0xFFE53935);
  }
}


Widget _iconForCategory(String key) {
  IconData icon = Icons.settings;
  switch (key) {
    case 'HOUSING_AND_UTILITIES':
      icon = Icons.home;
      break;
    case 'EDUCATION_AND_CHILDCARE':
      icon = Icons.school;
      break;
    case 'TRANSPORTATION':
      icon = Icons.directions_car;
      break;
    case 'HEALTHCARE_AND_MEDICAL':
      icon = Icons.local_hospital;
      break;
    case 'INSURANCE':
      icon = Icons.shield;
      break;
    case 'LOANS_AND_CREDIT_CARDS':
      icon = Icons.credit_card;
      break;
    case 'GROCERIES':
      icon = Icons.shopping_cart;
      break;
    case 'ENTERTAINMENT':
      icon = Icons.celebration;
      break;
    case 'DINING_OUT':
      icon = Icons.restaurant;
      break;
    case 'SHOPPING':
      icon = Icons.shopping_bag;
      break;
    case 'MISCELLANEOUS':
      icon = Icons.settings;
      break;
    case 'TRAVEL':
      icon = Icons.airplanemode_active;
      break;
    default:
      icon = Icons.category;
  }
  return Icon(icon, size: 26, color: Colors.grey[800]);
}

void _showCategoryDetail(Category c, BuildContext context) {
  final currency = NumberFormat.simpleCurrency();
  final limit = c.categorySpend + c.spendRemaining;
  final pct = '${c.spendPercentage.toStringAsFixed(1)}%';

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 40, height: 4, color: Colors.grey[300]),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _iconForCategory(c.finleyCategory),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  c.displayName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(pct, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          Text('Amount spent: ${currency.format(c.categorySpend)}'),
          SizedBox(height: 8),
          Text('Budget limit: ${currency.format(limit)}'),
          SizedBox(height: 8),
          Text('Percent: ${currency.format(c.spendPercentage)}'),
          SizedBox(height: 8),
          Text('Status: ${c.spendStatus.toString().split('.').last}'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Center(child: Text('Close')),
          ),
          SizedBox(height: 12),
        ],
      ),
    ),
  );
}

Widget categoryGrid(List<Category> categories) {
  final currency = NumberFormat.simpleCurrency();
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.58,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, idx) {
        final c = categories[idx];
        final color = _statusColor(c.spendStatus);
        final pct = (c.spendPercentage / 100).clamp(0.0, 1.0);
        String statusText;
        if (c.spendRemaining < 0) {
          statusText = 'over limit';
        } else {
          statusText = 'left';
        }
        return GestureDetector(
          onTap: () => _showCategoryDetail(c,context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom: 4.0),
            child: ListView(
              children: [
                // Category Name
                SizedBox(
                  height: 15,
                  child: Text(
                    c.displayName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1, // optional, prevents overflow
                    overflow: TextOverflow.ellipsis, // optional, shows '...' if text is long
                  ),
                ),

                const SizedBox(height: 4),
                // Circular progress with icon
                SizedBox(
                  height: 52,
                  width: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: pct,
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        backgroundColor: Colors.grey[200],
                      ),
                      _iconForCategory(c.finleyCategory),
                    ],
                  ),
                ),
                // Amount spent
                Text(
                  currency.format(c.spendRemaining),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1, // optional, prevents overflow
                  overflow: TextOverflow.ellipsis, // optional, shows '...' if text is long
                ),
                // Status text
                Text(
                  statusText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

