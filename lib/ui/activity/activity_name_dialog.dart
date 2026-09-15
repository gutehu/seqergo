import 'package:flutter/material.dart';

Future<String?> promptActivityName(
  BuildContext context, {
  String title = "Nom de l'activité",
  String confirmLabel = 'Valider',
  String cancelLabel = 'Annuler',
  String? initial,
  String label = "Nom de l'activité",
  String hint = 'Ex. saisir une pièce',
  int maxLines = 1,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _ActivityNameDialog(
      title: title,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      initial: initial,
      label: label,
      hint: hint,
      maxLines: maxLines,
    ),
  );
}

class _ActivityNameDialog extends StatefulWidget {
  const _ActivityNameDialog({
    required this.title,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.initial,
    required this.label,
    required this.hint,
    required this.maxLines,
  });

  final String title;
  final String confirmLabel;
  final String cancelLabel;
  final String? initial;
  final String label;
  final String hint;
  final int maxLines;

  @override
  State<_ActivityNameDialog> createState() => _ActivityNameDialogState();
}

class _ActivityNameDialogState extends State<_ActivityNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final text = widget.initial ?? '';
    _controller = TextEditingController(text: text);
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: text.length,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: widget.maxLines,
        textInputAction: widget.maxLines > 1
            ? TextInputAction.newline
            : TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          filled: true,
          fillColor: Colors.white,
        ),
        onSubmitted: widget.maxLines > 1 ? null : (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.cancelLabel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}
