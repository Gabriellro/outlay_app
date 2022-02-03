import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:outlay/models/_exports.dart';
import 'package:outlay/themes/app_text_styles.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction>? transactions;
  final Function(String) onRemove;

  const TransactionList({Key? key, this.transactions, required this.onRemove})
      : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions!.isEmpty
        ? const Center(
            child: Text(
              "Nenhuma despesa cadastrada! :(",
              style: TextStyle(fontSize: 34),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.transactions!.length,
            reverse: true,
            itemBuilder: (ctx, index) {
              final tr = widget.transactions![index];
              return Dismissible(
                key: Key(tr.id),
                onDismissed: (direction) {
                  setState(() {
                    widget.onRemove(tr.id);
                  });
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    tr.title,
                    style: TextStyles.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                    style: TextStyles.subtitle2,
                  ),
                  trailing: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: TextStyles.subtitle1
                        .copyWith(color: Theme.of(context).errorColor),
                  ),
                ),
              );
            },
          );
  }
}
