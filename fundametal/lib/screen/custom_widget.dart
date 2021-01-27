import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  String number = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  number,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          GridView.count(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              CalculatorButton(
                bgColor: Colors.grey,
                fgColor: Theme.of(context).primaryColorLight,
                text: 'C',
                press: () {

                },
              ),
              CalculatorButton(
                bgColor: Colors.grey,
                fgColor: Theme.of(context).primaryColorLight,
                text: '+/-',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Colors.grey,
                fgColor: Theme.of(context).primaryColorLight,
                text: '%',
                press: () {},
              ),
              CalculatorButton.Icon(
                bgColor: Theme.of(context).primaryColorDark,
                fgColor: Theme.of(context).primaryColorLight,
                text: 'C',
                icon: Icons.backspace,
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '7',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '8',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '9',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorDark,
                fgColor: Theme.of(context).primaryColorLight,
                text: '/',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '4',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '5',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '6',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorDark,
                fgColor: Theme.of(context).primaryColorLight,
                text: 'X',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '1',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '2',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '3',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorDark,
                fgColor: Theme.of(context).primaryColorLight,
                text: '-',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '0',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorLight,
                fgColor: Theme.of(context).primaryColorDark,
                text: '.',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Colors.grey,
                fgColor: Theme.of(context).primaryColorLight,
                text: '=',
                press: () {},
              ),
              CalculatorButton(
                bgColor: Theme.of(context).primaryColorDark,
                fgColor: Theme.of(context).primaryColorLight,
                text: '+',
                press: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final Color bgColor;
  final Color fgColor;
  final String text;
  IconData icon;
  final Function press;

  CalculatorButton({this.bgColor, this.fgColor, this.text, this.press});

  CalculatorButton.Icon(
      {this.bgColor, this.fgColor, this.text, this.icon, this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        color: bgColor,
        child: (icon == null)
            ? Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: fgColor),
                ),
              )
            : Icon(
                icon,
                color: fgColor,
              ),
      ),
    );
  }
}
