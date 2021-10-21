import 'package:flutter/material.dart';
import 'package:pocbytebank/models/transfer.dart';

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
