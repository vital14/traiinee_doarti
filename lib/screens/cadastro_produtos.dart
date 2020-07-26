import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trainee_doarti/models/produto.dart';
import 'package:trainee_doarti/repository/databaseService.dart';
import 'formScreen.dart';

class CadastroProdutos extends StatefulWidget {
  final DatabaseService repository = new DatabaseService();
  @override
  _CadastroProdutosState createState() => _CadastroProdutosState();
}

class _CadastroProdutosState extends State<CadastroProdutos> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void showEditPanel(DocumentSnapshot document, Produto produto) {
      String _nomeProduto = document['nome'];
      String _codigoProduto = document['codigo'];
      String _precoProduto = document['preco'];
      String _quantidadeProduto = document['quantidade'];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text("Editar Produto"),
              content: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nome'),
                        initialValue: '$_nomeProduto',
                        validator: (value) {
                          String patttern = r'(^[a-zA-Z ]*$)';
                          RegExp regExp = new RegExp(patttern);
                          if (value.length == 0) {
                            return "Informe o nome";
                          } else if (!regExp.hasMatch(value)) {
                            return "O nome deve conter caracteres de a-z ou A-Z";
                          }

                          return null;
                        },
                        onChanged: (value) =>
                            setState(() => _nomeProduto = value),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Código'),
                        initialValue: '$_codigoProduto',
                        validator: (value) {
                          String patttern = r'(^[0-9]*$)';
                          RegExp regExp = new RegExp(patttern);

                          if (value.isEmpty) return ' o campo é obrigatório';

                          if (!regExp.hasMatch(value))
                            return "O código só deve conter dígitos";
                          return null;
                        },
                        onChanged: (value) =>
                            setState(() => _codigoProduto = value),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Quantidade'),
                        initialValue: '$_quantidadeProduto',
                        validator: (value) {
                          String patttern = r'(^[0-9]*$)';
                          RegExp regExp = new RegExp(patttern);

                          if (value.isEmpty) return ' o campo é obrigatório';

                          if (!regExp.hasMatch(value))
                            return "A quantidade só deve conter dígitos";

                          return null;
                        },
                        onChanged: (value) =>
                            setState(() => _precoProduto = value),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Preço'),
                          initialValue: '$_precoProduto',
                          validator: (value) {
                            String patttern = r'(^[0-9]*$)';
                            RegExp regExp = new RegExp(patttern);

                            if (value.isEmpty) return ' o campo é obrigatório';

                            if (!regExp.hasMatch(value))
                              return "o Preço só deve conter dígitos";
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => _quantidadeProduto = value)),
                      RaisedButton(
                        child: Text('Editar'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            produto.nome = _nomeProduto;
                            produto.codigo = _codigoProduto;
                            produto.quantidade = _quantidadeProduto;
                            produto.preco = _precoProduto;
                            widget.repository.updateItem(produto);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  )),
            );
          });
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text('Cadastro de produtos'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormScreen(widget.repository)));
                }),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
        body: StreamBuilder(
            stream: widget.repository.getStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final itemDatabase = snapshot.data.documents[index];

                    return Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, top: 10.0, right: 16.0, bottom: 0.0),
                      child: Card(
                        color: Colors.blue,
                        child: ListTile(
                            leading: Text(
                              ' ${itemDatabase['codigo']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              ' ${itemDatabase['nome']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Quantidade no estoque: ${itemDatabase['quantidade']}\nPreço do Produto: ${itemDatabase['preco']} R\$',
                              style: TextStyle(color: Colors.white),
                            ),
                            isThreeLine: true,
                            trailing: Container(
                                width: 100,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.orange,
                                        onPressed: () {
                                          Produto produto =
                                              new Produto.fromSnapshot(
                                                  itemDatabase);

                                          showEditPanel(itemDatabase, produto);
                                        }),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        widget.repository.deleteItem(
                                            Produto.fromSnapshot(itemDatabase));
                                      },
                                    ),
                                  ],
                                ))),
                      ),
                    );
                  });
            }));
  }
}
