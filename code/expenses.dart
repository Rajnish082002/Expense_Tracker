import 'dart:async';

import 'package:expense_tracker/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/new_expenses.dart';

class Expenses extends StatefulWidget {
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //-->list
  final List<Expense> _regesteredExpenses = [
    Expense(
      title: "flutter course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "ciname",
      amount: 11.23,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  //
  void _openAddExpenseOverlay() {
    //it will deploy a new model element such as a model overlay
    //context property->property provided by class
    //                ->can be used as parameter for the class in context paremeter
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  //
  void _addExpense(Expense expense) {
    setState(() {
      _regesteredExpenses.add(expense);
    });
  }

  //
  void _removeExpense(Expense expense) {
    final expenseIndex = _regesteredExpenses.indexOf(expense);
    setState(() {
      _regesteredExpenses.remove(expense);
    });
    // -->clear the snack bar immediately after if more item are try to remove
    ScaffoldMessenger.of(context).clearSnackBars();
    // ->to show a slite bar at the bottom of the screen to do some action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expenses deleted"),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _regesteredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    Widget mainContant = Center(
      child: Text("no expense found please add some"),
    );
    if (_regesteredExpenses.isNotEmpty) {
      mainContant = ExpensesList(
        expenses: _regesteredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 28, 10, 149),
        actions: [
          IconButton(
            // color: Colors.white,
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
        title: Text(
          'expense tracker',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Chart(expenses: _regesteredExpenses),
          Expanded(
            child: mainContant,
          ),
        ],
      ),
    );
  }
}
