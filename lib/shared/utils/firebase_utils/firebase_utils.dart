import 'package:cloud_firestore/cloud_firestore.dart';

import '../DateUtil/dateutil.dart';

class FirebaseUtil {
  Stream<QuerySnapshot<Map<String, dynamic>>> queryOrdersFirebase(
      String companyID) {
    DateTime dateTimeOrder = DateUtil.getDateyyyyMMddWithMilisecond();

    return FirebaseFirestore.instance
        .collection("orders")
        .where('companyID', isEqualTo: companyID)
        .where('dateTimeOrder', isGreaterThanOrEqualTo: dateTimeOrder)
        .snapshots();
  }
}
