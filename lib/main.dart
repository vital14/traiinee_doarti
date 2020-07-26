import 'package:flutter/material.dart';
import 'screens/cadastro_produtos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: CadastroProdutos(),
    );
  }
}
