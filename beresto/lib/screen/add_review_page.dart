import 'package:beresto/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReviewPage extends StatefulWidget {
  final String restaurantId;

  AddReviewPage({@required this.restaurantId});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  var _controllerName = TextEditingController();
  var _controllerComment = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berikan komentarmu donk beb :)'),
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            nameAndCommentFormField('Masukin nama kamu beb',
                'Ahh, harus diisi beb', _controllerName),
            nameAndCommentFormField('Masukin komentar kamu beb',
                'Ahh, harus diisi beb', _controllerComment),
            Container(
              width: 250,
              height: 45,
              /// Penggunaan RaisedButton tidak bisa diganti oleh ElevatedButton, karena memuat properti color
              child: RaisedButton(
                color: Colors.orange,
                child: Text(
                  'Tambahkan komentar ahh',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () async {
                  print('${_controllerName.text} ${_controllerComment.text} ');
                  if (_formKey.currentState.validate() &&
                      _controllerName.text.isNotEmpty &&
                      _controllerComment.text.isNotEmpty) {
                    await ApiService().review(widget.restaurantId,
                        _controllerName.text, _controllerComment.text);
                    setState(() {
                      _formKey.currentState.reset();
                    });

                    _toast(
                        'Berhasil Menambahkan komentar, silahkan kembali ke halaman utama dan masuk lagi ke halaman komentar untuk melihat hasilnya');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container nameAndCommentFormField(
      String hint, String validator, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return validator;
          } else {
            return null;
          }
        },
      ),
    );
  }
}

_toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
