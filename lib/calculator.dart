import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  int _count = 0;
  int _counter = 0;
  int _increment = 2;

  void _incrementCounter() {
    setState(() {
      _count++;
      _counter += _increment;
    });
  }

  void _changeIncrementation(value) {
    setState(() {
      _increment = int.parse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: '$_increment',
                    onChanged: (value) {
                      try {
                        if (int.tryParse(value)! < 1) {
                          throw Exception();
                        }
                        _changeIncrementation(value);
                      } catch (error) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Erreur'),
                                content: const Text(
                                    'Veuillez entrer un nombre au dessus de 1'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  ),
                  Text(_count > 0 ? 'Vous avez cliqué $_count fois' : ''),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_counter + $_increment =',
                ),
                Text(
                  '${_counter + _increment}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Text('+$_increment')),
    );
  }
}
