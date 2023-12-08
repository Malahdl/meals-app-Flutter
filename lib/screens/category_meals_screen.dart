import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeals;

  CategoryMeals(this.availableMeals);

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return MealItem(
              id: displayedMeals![index].id,
              title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability,
              duration: displayedMeals![index].duration,
              removeMeal: _removeMeal,
            );
          }),
          itemCount: displayedMeals!.length,
        ));
  }
}
