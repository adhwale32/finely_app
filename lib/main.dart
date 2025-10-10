import 'package:finely_app/features/spending_dashboard/data/datasources/category_api.dart';
import 'package:finely_app/features/spending_dashboard/data/repositories/category_repository_impl.dart';
import 'package:finely_app/features/spending_dashboard/domain/usecases/get_categories.dart';
import 'package:finely_app/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/spending_dashboard/presentation/bloc/category_bloc.dart';

void main() {
  runApp(const FinleyApp());
}

class FinleyApp extends StatelessWidget {
  const FinleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finley Dashboard',
      theme: ThemeData(
        primaryColor: Colors.green[700],
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: BlocProvider(
        create: (_) =>
            CategoryBloc(GetCategories(CategoryRepositoryImpl()))
              ..add(LoadCategoriesEvent()),
        child: DashboardPage(),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}
