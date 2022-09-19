// import 'dart:html';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void _resetCampos() {
    pesoController = TextEditingController();
    alturaController = TextEditingController();
    _formKey.currentState!.reset();
  }

  void _calcular() {
    String _texto = "";
    String _imagem = "";

    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);

    if (imc < 18.6) {
      _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 40) {
      _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira seu peso!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira sua altura!";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) _calcular();
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  _textInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          )),
    );
  }
}