import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String nome;
  String codigo;
  String quantidade;
  String preco;
  DocumentReference reference;
  Produto(
      {this.nome, this.codigo, this.quantidade, this.preco, this.reference});
  factory Produto.fromSnapshot(DocumentSnapshot snapshot) {
    Produto produto = Produto.fromJson(snapshot.data);
    produto.reference = snapshot.reference;
    return produto;
  }
  Produto.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    codigo = json['codigo'];
    quantidade = json['quantidade'];
    preco = json['preco'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    data['quantidade'] = this.quantidade;
    data['preco'] = this.preco;
    return data;
  }
}
