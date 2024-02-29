import 'package:expense_tracker/data/database.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expences_list/expences_list.dart';
import 'package:expense_tracker/models/expence.dart';
import 'package:expense_tracker/widgets/new_expence.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';

// to place specific widgits different for ios and ios devices
//we can use cupertiono widgits which are same as normal widgits but with
//ios as base
//to check for the device the app is running on
//we can use if(Platform.isIOS) or .isAndroid and return specific widgets

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  // final List<Expence> _registeredExpences = [];

  final _myBox = Hive.box("myBox");
  Database data = Database();

  void openAddExpenceOverlay({required final width}) {
    setState(() {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: (width < 600) ? false : true,
        context: context,
        builder: (ctx) => NewExpence(
          onAddExpence: addExpence,
        ),
      );
    });
  }

  void addExpence(Expence expence) {
    setState(() {
      @override
      void initState() {
        data.loadData();
        super.initState();
      }

      data.registeredExpences.add(expence);
      data.updateData();
    });
  }

  void _removeExpence(Expence expence, int expenceIndex) {
    setState(() {
      @override
      void initState() {
        data.loadData();
        super.initState();
      }

      data.registeredExpences.remove(expence);
      data.updateData();
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expence Deleted"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              data.registeredExpences.insert(expenceIndex, expence);
              @override
              void initState() {
                data.loadData();
                super.initState();
              }

              data.updateData();
            });
          },
        ),
      ),
    );
  }

  // Widget _landscapeOrPotrait() {
  //   Widget check = Row();
  //   @override
  //   void initState() {
  //     super.initState();

  //     if (width < 600) {
  //       check = Column(
  //         children: [
  //           Chart(expenses: _registeredExpences),
  //           Expanded(
  //             child: mainContent,
  //           ),
  //         ],
  //       );
  //     } else {
  //       check = Column(
  //         children: [
  //           Chart(expenses: _registeredExpences),
  //           Expanded(
  //             child: mainContent,
  //           ),
  //         ],
  //       );
  //     }
  //   }

  //   return check;
  // }

  @override
  Widget build(BuildContext context) {
    // if device is rotated, the build method is executed again

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "----No Expences Found----",
            style: GoogleFonts.aBeeZee(
                fontSize: 24,
                color: const Color.fromARGB(255, 165, 126, 6),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Try adding some expenses :)",
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: (width < 600) ? 450 : 10,
          ),
        ],
      ),
    );

    if (data.registeredExpences.isNotEmpty) {
      mainContent = ExpencesList(
        expences: data.registeredExpences,
        onDismissed: _removeExpence,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              openAddExpenceOverlay(width: width);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: (width < 600)
          ? Column(
              children: [
                Chart(expenses: data.registeredExpences),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: data.registeredExpences),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
