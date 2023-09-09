import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> isDuplicateUniqueName(String uniqueName) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection('users')
      .where('name', isEqualTo: uniqueName)
      .get();
  return query.docs.isNotEmpty;
}

Future<bool> isIdExist(int id) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection('matches')
      .where('id', isEqualTo: id)
      .get();
  return query.docs.isNotEmpty;
}

Future<bool> isMatchExist({required int id, required String name}) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection('matches')
      .where('id', isEqualTo: id)
      .where('player2', isEqualTo: name)
      .get();
  return query.docs.isNotEmpty;
}
