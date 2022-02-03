import 'package:flutter/material.dart';

import 'dart:math';
import 'components/_exports.dart';
import 'models/_exports.dart';
import 'themes/theme.dart';

void main() => runApp(const OutlayApp());

class OutlayApp extends StatelessWidget {
  const OutlayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions => _transactions
      .where((tr) =>
          tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  _addTransaction(String title, double value, DateTime date) {
    final newTransactions = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransactions);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FractionallySizedBox(
          heightFactor: 0.55,
          child: TransactionForm(onSubmit: _addTransaction),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        "Outlay",
        style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).primaryColor,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    final availableheight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appbar.preferredSize.height;

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: availableheight * 0.25,
              child: Chart(recentTransaction: _recentTransactions),
            ),
            SizedBox(
              height: availableheight * 0.05,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Transações',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: availableheight * 0.70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionModal(context),
        child: Icon(
          Icons.edit_rounded,
          color: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
