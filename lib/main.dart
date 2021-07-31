import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // variável que irá verificar se o form está apto ou não pra ser enviado

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>(); //reseta o erro também, caso esteja
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(
          weightController.text); //converse pra double, número flutuante
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      print(imc);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40.0) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Calculadora de IMC"),
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
            ]),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            //Serve pra poder rolar a página, pra que o teclado não fique sobre o conteúdo da página
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.person_outline,
                          size: 120.0, color: Colors.green),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Peso (kg)",
                              labelStyle: TextStyle(color: Colors.green)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 25.0),
                          controller: weightController,
                          //bind de variável
                          validator: (value) {
                            if (value!.isEmpty) {
                              //valida se o campo está vazio
                              return "Insira seu peso";
                            }
                          }),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Altura (cm)",
                              labelStyle: TextStyle(color: Colors.green)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 25.0),
                          controller: heightController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              //valida se o campo está vazio
                              return "Insira sua altura";
                            }
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                            height: 50.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _calculate();
                                  }
                                },
                                child: Text("Calcular",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25.0)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ))),
                      ),
                      Text("$_infoText",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 25.0))
                    ]))));
  }
}
