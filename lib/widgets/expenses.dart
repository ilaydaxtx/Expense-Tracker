import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';


class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'elma',
        amount: 99 ,
        date: DateTime.now(),
        category: Category.work,
    ),
    Expense(
      title: 'sinema',
      amount: 122 ,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (ctx) {
      return NewExpense(onAddExpense: addExpense);
    });
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                });
              },
            ),
            content: Text("expense deleted")),);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(child: Text("no expenses found. Start adding some"),);

    if (_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
          expenses: _registeredExpenses,
          onRemoveExpense: removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: openAddExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [

          const Text('the chart'),
          Expanded(
              child: mainContent ),

        ],
      ),

    );
  }
}
