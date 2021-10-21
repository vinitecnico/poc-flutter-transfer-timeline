import 'package:flutter/material.dart';
// import 'package:money2/money2.dart';

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
        body: TransferList(),
      ),
    );
  }
}

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

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? description;
  final IconData? icon;

  Editor({
    this.controller,
    this.title,
    this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: title,
          hintText: description,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> _transferList = [];

  TransferList({Key? key}) : super(key: key);

  @override
  TransferListState createState() => TransferListState();
}

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('transferências')),
        body: ListView.builder(
          itemCount: widget._transferList.length,
          itemBuilder: (context, index) {
            final Transfer transfer = widget._transferList[index];
            return TransferItem(Transfer(
                transfer.amount, transfer.description, transfer.accountNumber));
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final Future<Transfer?> future =
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormTransfer();
            }));
            future.then((transferReceived) {
              Future.delayed(const Duration(seconds: 1), () {
                if (transferReceived != null) {
                  setState(() {
                    widget._transferList.add(Transfer(
                        transferReceived.amount,
                        transferReceived.description,
                        transferReceived.accountNumber));
                  });
                }
              });

              debugPrint('length >> ${widget._transferList.length}');
            });
          },
        ));
  }
}

class TransferItem extends StatelessWidget {
  // final usd = Currency.create('pt_BR', 2);
  final Transfer _transfer;

  TransferItem(this._transfer, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text('${_transfer.amount}'),
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
