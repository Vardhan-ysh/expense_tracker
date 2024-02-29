import 'package:expense_tracker/models/expence.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewExpence extends StatefulWidget {
  const NewExpence({super.key, required this.onAddExpence});

  final void Function(Expence expence) onAddExpence;

  @override
  State<NewExpence> createState() => _NewExpenceState();
}

class _NewExpenceState extends State<NewExpence> {
  // var enteredTitle = "";
  // void _saveTitleInput(String inputValue) {
  //   enteredTitle = inputValue;
  // }

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  int save = 0;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Widget selectedDateShower() {
    if (_selectedDate == null) {
      return const Text("Select Date");
    } else {
      String formattedDate =
          DateFormat('dd/MM/yyyy').format(_selectedDate as DateTime);
      return Text(formattedDate);
    }
  }

  void _submitExpenceData() {
    if (_titleController.text.trim().isEmpty ||
        double.tryParse(_amountController.text.trim()) == null ||
        double.tryParse(_amountController.text.trim())! < 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              "Invalid Input".toUpperCase(),
              style: GoogleFonts.robotoCondensed(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            "Some of the inputs are empty or have wrong format. Please ensure that a proper amount, date, and title is entered"
                .toUpperCase(),
            style: GoogleFonts.robotoCondensed(
              // fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
          alignment: Alignment.bottomCenter,
        ),
      );
    } else {
      save = 1;
      Expence newExpence = Expence(
          title: _titleController.text.trim(),
          amount: double.parse(_amountController.text.trim()),
          date: _selectedDate!,
          category: _selectedCategory);

      widget.onAddExpence(newExpence);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // print("Gello");
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraint) {
      final width = constraint.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 20),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 50,
                          // onChanged: _saveTitleInput,
                          controller: _titleController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          maxLength: 6,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "₹ ",
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    maxLength: 50,
                    // onChanged: _saveTitleInput,
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (selectedValue) {
                          setState(() {
                            if (selectedValue != null) {
                              _selectedCategory = selectedValue;
                            } else {
                              _selectedCategory = Category.leisure;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            selectedDateShower(),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 6,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "₹ ",
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            selectedDateShower(),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submitExpenceData,
                        child: const Text("Save Expense"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      // const SizedBox(
                      //   height: 20,
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (selectedValue) {
                          setState(() {
                            if (selectedValue != null) {
                              _selectedCategory = selectedValue;
                            } else {
                              _selectedCategory = Category.leisure;
                            }
                          });
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submitExpenceData,
                        child: const Text("Save Expense"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
