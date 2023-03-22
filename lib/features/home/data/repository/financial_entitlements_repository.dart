import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/financial_entitlements.dart';

const String kFinancialEntitlements = 'FinancialEntitlements';

class FinancialEntitlementsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, void>> addFinancialEntitlements(Employee employee, double amount) async {
    try {
      double net = double.parse(
          ((await _firestore.collection("net").doc('appNet').get()).data()?['appNet'] ?? 0)
              .toString());
      amount = amount - (amount * net / 100);

      var fromFire =
          (await _firestore.collection(kFinancialEntitlements).doc(employee.employeeID).get())
              .data();

      FinancialEntitlements financialEntitlements;

      if (fromFire == null) {
        financialEntitlements = FinancialEntitlements(
            amount: amount,
            beneficiaryEmail: employee.email,
            beneficiaryId: employee.employeeID,
            beneficiaryNumber: employee.phonNumber);
      } else {
        financialEntitlements = FinancialEntitlements.fromMap(fromFire);
        financialEntitlements =
            financialEntitlements.copyWith(amount: financialEntitlements.amount + amount);
      }

      _firestore
          .collection(kFinancialEntitlements)
          .doc(financialEntitlements.beneficiaryId)
          .set(financialEntitlements.toMap());

      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
