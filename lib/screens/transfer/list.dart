import 'package:flutter/material.dart';
import 'package:pocbytebank/components/transfer_item.dart';
import 'package:pocbytebank/models/transfer.dart';
import 'package:pocbytebank/screens/transfer/form.dart';

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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormTransfer();
            })).then((transferReceived) {
              if (transferReceived != null) {
                _updateTransfer(Transfer(
                    transferReceived.amount,
                    transferReceived.description,
                    transferReceived.accountNumber));
              }
            });
          },
        ));
  }

  void _updateTransfer(Transfer transferReceived) {
    setState(() {
      widget._transferList.add(transferReceived);
    });
  }
}
