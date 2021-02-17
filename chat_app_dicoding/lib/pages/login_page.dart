import 'package:chat_app_dicoding/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool _obsecureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            Hero(
              tag: 'Dicoding Chatting',
              child: Text(
                'Dicoding Chatting',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(height: 24,),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _passwordController,
              obscureText: _obsecureText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obsecureText ? Icons.visibility : Icons.visibility_off
                  ),
                  onPressed: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                ),
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20,),
            MaterialButton(
              child: Text('Login'),
              color: Theme.of(context).primaryColor,
              textTheme: ButtonTextTheme.primary,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });

                _userLogin();

              },
            ),
            FlatButton(
              child: Text('Does not have an account yet? Register here'),
              onPressed: () => Navigator.pushNamed(context, RegisterPage.id),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _userLogin() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        Navigator.pushReplacementNamed(context, ChatPage.id);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

}
