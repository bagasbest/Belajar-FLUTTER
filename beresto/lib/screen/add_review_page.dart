import 'package:beresto/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:beresto/model/review.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReviewPage extends StatefulWidget {
  final String restaurantId;

  AddReviewPage({@required this.restaurantId});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  String name = '';
  String comment = '';

  final _formKey = GlobalKey<FormState>();

  CustomerRevieww _review;

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
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'nama kamuhh (3',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'nama tidak boleh kosong beb';
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'tambahin komentar',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'komentar tidak boleh kosong';
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  comment = val;
                },
              ),
            ),
            Container(
              width: 250,
              height: 45,
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
                  if (_formKey.currentState.validate()) {
                    final CustomerRevieww review = await ApiService()
                        .review(widget.restaurantId, name, comment);
                    setState(() {
                      _review = review;
                      _formKey.currentState.reset();
                    });

                    _toast(
                        'Berhasil Menambahkan komentar, silahkan kembali ke halaman utama dan masuk lagi ke halaman komentar untuk melihat hasilnya');
                  }
                },
              ),
            )
          ],
        ),
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
