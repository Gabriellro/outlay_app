import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outlay/themes/app_text_styles.dart';
import 'package:outlay/themes/theme.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  DateTime? _selectDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime.now(),
      helpText: 'Select a date',
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -20,
          right: 36,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextButton.icon(
                icon: const Icon(Icons.save_rounded, color: Colors.white),
                label: const Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _submitForm,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) => _submitForm(),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "Titulo da despesa:",
                  hintStyle: TextStyles.subtitle2.copyWith(
                    color: Theme.of(context).highlightColor.withOpacity(0.9),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  hintText: "Valor: (R\$)",
                  hintStyle: TextStyles.subtitle2.copyWith(
                    color: Theme.of(context).highlightColor.withOpacity(0.9),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectDate == null
                          ? 'Nenhuma data selecionada:'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectDate!)}',
                      style: TextStyles.subtitle1,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.date_range_rounded),
                    label: Text(
                      "Selecionar data ",
                      style: TextStyles.button,
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
