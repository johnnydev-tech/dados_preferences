import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _dado = TextEditingController();
  String _textoSalvo = "Nada Salvo!";

  //Salvar dados em Cache
  _salvar() async {
    String valorDigitado = _dado.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("dados", valorDigitado);
    print("Salvo: " + valorDigitado);
  }

  //Exbir dados em Cache
  _exibir() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("dados") ?? "Sem Valor";
    });
    print("Exibir: " + _textoSalvo);
  }

  //Remover dados em Cache
  _remover() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("dados");
    print("Removido");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: [
              Text(_textoSalvo),
              TextField(
                decoration: InputDecoration(labelText: "Digite algo"),
                controller: _dado,
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text("Salvar"),
                        onPressed: () {
                          _salvar();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text("Exibir"),
                        onPressed: () {
                          _exibir();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text("Remover"),
                        onPressed: () {
                          _remover();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
