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
