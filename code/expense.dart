import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final foramtter = DateFormat.yMd();
final uuid = Uuid(); //->to generate unique id

//->to allow only specific vlaues
//used to create a data type which take only data that present in it
enum Category { food, travel, leisure, work }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //v4->to generate a string
  //->initializer list in last of string
  //                ->ingherant the property of the class with the construxtor function belong
  //
  final String title;
  final double amount;
  final DateTime date;
  final String id;
  final Category category; //data type is ^ Category

  String get formattDate {
    return foramtter.format(date);
  }
}

//
// ->to add chart
class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });
// ->alternative name constructor function
// filter the constructor function that are belong only to this category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : /*initializer list*/ expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
//
// iteratng all the value in list expenses and stored every time in this variable
    for (final expense in expenses) {
      sum += expense.amount;
    }
//
    return sum;
  }
}
