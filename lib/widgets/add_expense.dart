import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

enum Category { food, travel, work, entertainment, other }

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var errorMsg = '';
  DateTime? _selectedDate;

  Category _selectedCategory = Category.other;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  bool _validateData() {
    final amount = double.tryParse(_amountController.text);
    final amountIsInvalid = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');

    return Form(
        key: _formKey,
        child: Container(
          padding:
              const EdgeInsetsDirectional.only(top: 50, start: 25, end: 25),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text("Expense Titel"),
                ),
                validator: (value) => _titleController.text.isEmpty
                    ? "Enter expense title"
                    : null,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: '\u{20B9} ',
                  label: Text("Amount"),
                ),
                controller: _amountController,
                validator: (value) => _amountController.text.isEmpty
                    ? "Enter expense amount"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Category "),
                  const SizedBox(
                    width: 20,
                  ),
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _datePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    _selectedDate == null
                        ? "No date selected"
                        : formatter.format(_selectedDate!),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 75, 125, 251),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _validateData()) {
                    // String date = formatter.format(now);
                    final String uid = _auth.getCurrentUid();
                    final Database dataBase = Database(uid: uid);
                    try {
                      final double amount =
                          double.parse(_amountController.text);

                      await dataBase.addExpense(
                        title: _titleController.text,
                        amount: amount,
                        date: formatter.format(_selectedDate!),
                        category: _selectedCategory.name,
                      );

                      setState(() {
                        _titleController.clear();
                        _amountController.clear();
                        _selectedDate = null;
                        _selectedCategory = Category.other;
                      });
                    } catch (e) {
                      print(e.toString());
                    }

                    Navigator.pop(context);
                  } else {
                    setState(() {
                      errorMsg = "Enter valid data";
                    });
                    print("Enter valid data");
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              errorMsg != ''
                  ? Text(
                      errorMsg,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const Text(''),
            ],
          ),
        ));
  }
}
