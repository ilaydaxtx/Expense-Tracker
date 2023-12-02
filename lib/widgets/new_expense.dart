import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void presentDatePicker () async {
    final now = DateTime.now();
    final firstDate = DateTime(
        now.year - 1, //initial date açılınca seçili gelen
        now.month, //first date
        now.day); // last date niyeyse max bugünü seçiyosun :d?
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now ,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(amountController.text); //tryparse works on numbers. if we tryparse a sttring it will return null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    // enteredamount is null or its smaller than zero => amountIsValid is set to true
    // logic OR
    if(titleController.text.trim().isEmpty || amountIsInvalid || selectedDate == null){
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("invalid input"),
            content: Text("please make sure a valid input is entered :p"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(ctx);
                  },
                  child: Text("okay"),)
            ],
          ),);
      return;
    }
    widget.onAddExpense(Expense(
        title: titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '₺' ,
                    label: Text("Expense Amount"),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'No date selected'
                        : formatter.format(selectedDate!),),
                    IconButton(
                        onPressed: presentDatePicker,
                        icon: Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                  items: Category.values.map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),),),
                        ).toList(),
                  onChanged: (value){
                    if(value==null){
                      return;
                    }
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel")),
              ElevatedButton(
                  onPressed: (){
                    submitExpenseData();
                  },
                  child: Text('Save Expense'),)
            ],
          ),
        ],
      ),

    );
  }
}

