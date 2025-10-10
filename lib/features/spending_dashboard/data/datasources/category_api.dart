import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class CategoryApi {
  Future<List<dynamic>> fetchCategoriesJson() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final jsonString = await rootBundle.loadString(
      'assets/mock/categories.json',
    );
    // throw("Error while fetching");
    return json.decode(jsonString);
  }
}
