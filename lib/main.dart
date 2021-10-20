import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: FormTransfer(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class FormTransfer extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('create transfer')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controladorCampoNumeroConta,
                style: const TextStyle(fontSize: 24.0),
                decoration: const InputDecoration(
                    labelText: 'Número da conta', hintText: '0000'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controllerAmount,
                style: const TextStyle(fontSize: 24.0),
                decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText: 'Valor',
                    hintText: '0.00'),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  debugPrint('here >>>');
                  debugPrint(_controladorCampoNumeroConta.text);
                  debugPrint(_controllerAmount.text);
                  final int? accountNumber =
                      int.tryParse(_controladorCampoNumeroConta.text);
                  final double? amount =
                      double.tryParse(_controllerAmount.text);
                  if (accountNumber != null && amount != null) {
                    final transferCreated = Transfer(amount,
                        'transferência via lista de contatos', accountNumber);
                    debugPrint('$transferCreated');
                  }
                },
                child: const Text('confirmation'))
          ],
        ));
  }
}

class TransferList extends StatelessWidget {
  const TransferList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('transferências')),
      body: Column(
        children: [
          TransferItem(Transfer(100.0, 'transferência via QR-code', null)),
          TransferItem(
              Transfer(20.0, 'transferência via lista de contatos', null)),
          TransferItem(
              Transfer(15.0, 'transferência via lista de contatos', null))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  // final usd = Currency.create('pt_BR', 2);
  final Transfer _transfer;

  const TransferItem(this._transfer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text('$_transfer.amount'),
      // Text(Money.fromInt(_transfer.amount, usd).toString()),
      subtitle: Text(_transfer.description),
    ));
  }
}

class Transfer {
  final double amount;
  final String description;
  final int? accountNumber;

  Transfer(this.amount, this.description, this.accountNumber);

  @override
  String toString() {
    return 'Transferencia{amount: $amount, description: $description, accountNumber: $accountNumber}';
  }
}
