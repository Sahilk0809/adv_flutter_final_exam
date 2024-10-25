import 'package:adv_flutter_final_exam/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseServices {
  ExpenseServices._();

  static ExpenseServices expenseServices = ExpenseServices._();
  final _firestore = FirebaseFirestore.instance;

  Future<void> addDataInStore({
    required int id,
    required String title,
    required String date,
    required double amount,
    required String category,
  }) async {
    await _firestore
        .collection("users")
        .doc(AuthServices.userServices.getCurrentUser()!.email)
        .collection("expense")
        .doc(id.toString())
        .set({
      'id': id,
      'title': title,
      'category': category,
      'amount': amount,
      'date': date,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFromStore() {
    return _firestore
        .collection("users")
        .doc(AuthServices.userServices.getCurrentUser()!.email)
        .collection("expense")
        .snapshots();
  }
}
