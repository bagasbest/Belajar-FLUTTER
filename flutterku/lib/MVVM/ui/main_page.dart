import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterku/MVVM/bloc/user_bloc.dart';
import 'package:flutterku/MVVM/model/user.dart';
import 'package:flutterku/MVVM/ui/user_card.dart';

class MainPage extends StatelessWidget {
  final Random rand = Random();
  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Demo MVVM"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            color: Colors.blueGrey,
            onPressed: () {
              bloc.dispatch(rand.nextInt(10) + 1);
            },
            child: Text("Pick Random User"),
          ),
          BlocBuilder<UserBloc, User>(
              builder: (context, user) =>
                  (user is UninitializedUser) ? Container() : UserCard(user)),
        ],
      ),
    );
  }
}
