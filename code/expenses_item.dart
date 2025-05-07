import 'package:flutter/material.dart';
import 'package:expense_tracker/expense.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(
    this.expense, {
    super.key,
  });
  final Expense expense;
  Widget build(BuildContext context) {
    //->it gives simply a card look
    return Card(
      elevation: 2.2,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      // color: const Color.fromRGBO(33, 150, 243, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 4,
          ),
          Row(children: [
            Text('\$ ${expense.amount.toStringAsFixed(2)}'),
            Spacer(),
            Row(
              children: [
                Icon(
                  CategoryIcons[expense.category],
                ),
                SizedBox(
                  width: 8,
                ),
                Text(expense.formattDate),
              ],
            )
          ])
        ]),
      ),
    );
  }
}
