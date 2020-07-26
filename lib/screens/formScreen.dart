import 'package:flutter/material.dart';
import 'package:trainee_doarti/repository/databaseService.dart';
import 'package:trainee_doarti/models/produto.dart';

// ignore: must_be_immutable
class FormScreen extends StatefulWidget {
  String _nomeProduto = '';
  String _codigoProduto = '';
  String _precoProduto = '';
  String _quantidadeProduto = '';
  DatabaseService repository;
  FormScreen(this.repository);
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar produto'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome do produto',
                ),
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
                    setState(() => widget._nomeProduto = value),
              ),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Código do produto',
                ),
                validator: (value) {
                  String patttern = r'(^[0-9]*$)';
                  RegExp regExp = new RegExp(patttern);

                  if (value.isEmpty) return ' o campo é obrigatório';

                  if (!regExp.hasMatch(value))
                    return "O código só deve conter dígitos";
                  return null;
                },
                onChanged: (value) =>
                    setState(() => widget._codigoProduto = value),
              ),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Preço do produto',
                ),
                validator: (value) {
                  String patttern =
                      r'^\$?([0-9]{1,3},([0-9]{3},)*[0-9]{3}|[0-9]+)(.[0-9][0-9])?$';
                  RegExp regExp = new RegExp(patttern);

                  if (value.isEmpty) return ' o campo é obrigatório';

                  if (!regExp.hasMatch(value))
                    return "O preço só deve conter dígitos";

                  return null;
                },
                onChanged: (value) =>
                    setState(() => widget._precoProduto = value),
              ),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Quantidade em estoque',
                ),
                validator: (value) {
                  String patttern = r'(^[0-9]*$)';
                  RegExp regExp = new RegExp(patttern);

                  if (value.isEmpty) return ' o campo é obrigatório';

                  if (!regExp.hasMatch(value))
                    return "A quantidade só deve conter dígitos";
                  return null;
                },
                onChanged: (value) =>
                    setState(() => widget._quantidadeProduto = value),
              ),
              RaisedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Produto produto = new Produto(
                      nome: widget._nomeProduto,
                      codigo: widget._codigoProduto,
                      preco: widget._precoProduto,
                      quantidade: widget._quantidadeProduto,
                    );
                    widget.repository.addProduto(produto);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          )),
    );
  }
}
