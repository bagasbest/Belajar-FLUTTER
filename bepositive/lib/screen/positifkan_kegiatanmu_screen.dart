import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PositifkanKegiatanmu extends StatefulWidget {
  @override
  _PositifkanKegiatanmuState createState() => _PositifkanKegiatanmuState();
}

class _PositifkanKegiatanmuState extends State<PositifkanKegiatanmu> {


  String title = "";
  String description = "";
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text('Buat Rencana Kegiatan'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                controller: _controller1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.blueGrey[200], width: 2.0),
                  ),
                  hintText: 'Nama Kegiatan',
                  prefixIcon: Icon(
                    Icons.self_improvement,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    title = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 200,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _controller2,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.blueGrey[200], width: 2.0),
                  ),
                  hintText: 'Deskripsi kegiatan',
                  prefixIcon: Icon(
                    Icons.text_format,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: RaisedButton(
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    if (title.isNotEmpty && description.isNotEmpty) {
                      setState(() {
                        _controller1.clear();
                        _controller2.clear();
                      });
                      toast("Kegiatan anda berhasil disimpan");
                    } else {
                      toast("Kolom tidak boleh kosong");
                    }
                  },
                  child: Text(
                    "Kirim",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}

void toast(String pesan) {
  Fluttertoast.showToast(
      msg: pesan,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}

