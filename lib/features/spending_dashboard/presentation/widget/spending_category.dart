import 'package:finely_app/features/spending_dashboard/presentation/bloc/category_bloc.dart';
import 'package:finely_app/features/spending_dashboard/presentation/widget/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utility/curve_container.dart';

Widget spendingByCategory() {
  return CurvedWhiteContainer(
    child: Expanded(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Spending by category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoaded) {
                  return categoryGrid(state.categories);
                } else if (state is CategoryError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    ),
  );
}
