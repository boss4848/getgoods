import 'dart:developer';

import '../constants/constants.dart';
import '../models/transaction_model.dart';
import '../services/api_service.dart';

enum TransactionState {
  loading,
  success,
  error,
}

class TransactionViewModel {
  List<Transaction> transactions = [];
  List<Transaction> unpaidTransactions = [];
  List<Transaction> paidTransactions = [];
  List<Transaction> toReceiveTransactions = [];
  List<Transaction> completedTransactions = [];

  final String getTransactionsUrl = '${ApiConstants.baseUrl}/transactions';

  Future<void> getAllTransactions() async {
    final res = await ApiService.request(
      'GET',
      getTransactionsUrl,
      requiresAuth: true,
    );
    final Map<String, dynamic> data = res;
    final List<dynamic> transactionsData = data['transactions'];
    transactions = transactionsData
        .map(
          (e) => Transaction.fromJson(e),
        )
        .toList();

    unpaidTransactions = transactions
        .where(
          (element) => element.status == 'unpaid',
        )
        .toList();

    paidTransactions = transactions
        .where(
          (element) => element.status == 'paid',
        )
        .toList();

    toReceiveTransactions = transactions
        .where(
          (element) => element.status == 'shipped',
        )
        .toList();

    completedTransactions = transactions
        .where(
          (element) => element.status == 'completed',
        )
        .toList();
  }
}
