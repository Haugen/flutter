import 'package:flutter/material.dart';

import './dummy-data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(routeArgs['id']);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(routeArgs['title']),
        ),
        body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return Text(categoryMeals[index].title);
          },
        ));
  }
}
