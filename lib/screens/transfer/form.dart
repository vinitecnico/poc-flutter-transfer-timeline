import 'package:flutter/material.dart';
import 'package:pocbytebank/components/editor.dart';
import 'package:pocbytebank/models/transfer.dart';

// ignore: use_key_in_widget_constructors
class FormTransfer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormTransferState();
  }
}

class FormTransferState extends State<FormTransfer> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();

  void _createTransfer(context) {
    final int? accountNumber = int.tryParse(_controladorCampoNumeroConta.text);
    final double? amount = double.tryParse(_controllerAmount.text);
    if (accountNumber != null && amount != null) {
      final Transfer? transferCreated = Transfer(
          amount, 'transferência via lista de contatos', accountNumber);
      debugPrint("$transferCreated");
      Navigator.pop(context, transferCreated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('create transfer')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _controladorCampoNumeroConta,
              title: 'Account number',
              description: '0000',
            ),
            Editor(
              controller: _controllerAmount,
              title: 'amount',
              description: '0.00',
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
                onPressed: () => _createTransfer(context),
                child: const Text('confirmation'))
          ],
        ),
      ),
    );
  }
}
