import 'package:alcool_gasolina/widgets/submit-form.dart';
import 'package:alcool_gasolina/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:alcool_gasolina/widgets/logo.widget.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasolineCtrl = new MoneyMaskedTextController();
  var _alcoholCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = 'Compensa utilizar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(milliseconds: 1200),
          color: _color,
          child: ListView(
            children: [
              Logo(),
              _completed
                  ? Success(result: _resultText, reset: reset)
                  : SubmitForm(
                      gasolineCtrl: _gasolineCtrl,
                      alcoholCtrl: _alcoholCtrl,
                      busy: _busy,
                      submitFunc: calculate),
            ],
          ),
        ));
  }

  Future calculate() {
    double alc =
        double.parse(_alcoholCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;
    double gas =
        double.parse(_gasolineCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;
    double res = alc / gas;

    setState(() {
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          _resultText = 'Compensa utilizar Gasolina';
        } else {
          _resultText = 'Compensa utilizar Álcool';
        }

        _color = Colors.deepPurple;
        _busy = false;
        _completed = true;
      });
    });
  }

  reset() {
    setState(() {
      _gasolineCtrl = new MoneyMaskedTextController();
      _alcoholCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
    });
  }
}
