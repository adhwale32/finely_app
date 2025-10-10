import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources//category_api.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApi api = CategoryApi();

  @override
  Future<List<Category>> getCategories() async {
    final jsonList = await api.fetchCategoriesJson();
    return jsonList.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
