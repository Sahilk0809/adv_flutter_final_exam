class ExpenseModal {
  late int id;
  late String title, category, date, amount;

  ExpenseModal({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });

  factory ExpenseModal.fromMap(Map m1) {
    return ExpenseModal(
      id: m1['id'],
      title: m1['title'],
      category: m1['category'],
      date: m1['date'],
      amount: m1['amount'],
    );
  }
}

Map toMap(ExpenseModal notes) {
  return {
    'id': notes.id,
    'title': notes.title,
    'category': notes.category,
    'amount': notes.amount,
    'date': notes.date,
  };
}
