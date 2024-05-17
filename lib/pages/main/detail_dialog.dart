import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DetailDialog extends StatefulWidget {
  const DetailDialog({super.key});

  @override
  State<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: FormBuilder(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Label"
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: FormBuilderTextField(
                    name: "",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}