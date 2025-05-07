import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  //
  //
  // ->to store the value that give in future
  //    -->use async(to give inf. to flutter that value will store in future) && await(to what for value)
  //
  //
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstdate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //
  void _submitExpenseData() {
    //tryParse convert the string with number into number
    // tryParse('hello')=>null ---but---tryPase('1.12')=>1.12
    final enterdAmount = double.tryParse(_amountController.text);
    final amountIsInvalid =
        (enterdAmount == null || enterdAmount < 0) ? false : true;
    // trim   ->remove all white spaces
    // isEmpty->check the variable is empty or not
    if (_titleController.text.trim().isEmpty ||
        !amountIsInvalid ||
        _selectedDate == null) {
      // ->to show some pop on the screen OR dialog box on the screen
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("invalid input"),
                content: Text("please enter the valid date"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok"),
                  ),
                ],
              ));
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enterdAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  //
  @override
  void dispose() {
    super.dispose();
    // ->dispose the value when not in use
    _titleController.dispose();
    _amountController.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: '\$',
                      suffixIcon: Icon(Icons.money_off),
                      labelText: 'amount',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(
                              // ignore: unnecessary_null_comparison
                              color: _amountController == null
                                  ? Colors.red
                                  : Colors.blue))),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'no selected date'
                          : foramtter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData, child: Text('save expense')),
            ],
          )
        ],
      ),
    );
  }
}
