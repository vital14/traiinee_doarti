import 'package:trainee_doarti/models/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference collection =
      Firestore.instance.collection('produtos');

  Future<DocumentReference> addProduto(Produto produto) {
    return collection.add(produto.toJson());
  }

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  updateItem(Produto produto) async {
    await collection
        .document(produto.reference.documentID)
        .updateData(produto.toJson());
  }

  Future deleteItem(Produto produto) {
    return collection.document(produto.reference.documentID).delete();
  }
}
