import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Import packkage untuk HTTP REQUEST dan ASYNCRONUS
import 'dart:async';
import 'dart:convert';
import 'package:sky_engine/_http/' as http;

void main() {
  runApp(DigitalQuran());
}

class DigitalQuran extends StatefulWidget {
  @override
  _DigitalQuranState createState() => _DigitalQuranState();
}

class _DigitalQuranState extends State<DigitalQuran> {


  //Define variabel url untuk menampung end point
  final String url = 'https://api.banghasan.com/quran/format/json/surat';
  List data; //Define variabel data dengan tipe List agar dapat menampung collection / array

  Future<String> getData() async {
    //Meminta data ke server dengan ketentuan di accept adalah JSON
    var res = await http.get(Uri.encodeFull(url), headers: { 'accept' : 'application/json'});

    setState(() {
      //RESPONSE YANG DIDAPATKAN DARI API TERSEBUT di DECODE
      var content = json.decode(res.body);
      //KEMUDIAN DATANYA DISMPAN DALAM VARIABEL data,
      //DIMANA SECARA SPESIFIK YANG INGIN KITA AMBIL ADALAH ISI DARI KEY hasil
      data = content['hasil'];
    });

    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    this.getData(); //panggil fungsi yang telah di buat sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.book),
          title: Text("Digital Quran"),
        ),

        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView.builder(  //MEMBUAT LISTVIEW
            itemCount: data == null ? 0:data.length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
            itemBuilder: (BuildContext context, int index) {
              return Container (
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, children: <Widget>[
                      //ListTile Mengelompokkan widget menjadi beberapa bagian
                      ListTile(
                        //leading TAMPIL PADA SEBELAH KIRI
                        //dimana value dari leading adalah widget taxt
                        //yang berisi nomor surah
                        leading: Text(data[index]['nomor'], style: TextStyle(fontSize: 30.0),),
                        //title tampil di tengah setelah leading
                        //valuenya adalah widget text
                        //yang berisi nama surah
                        title: Text(data[index]['nama'], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                        //trailing tampil pada sebelah kanan setelah title
                        //valuenya adalah image, ketika valuenya dari type adalah
                        //Mekah maka akan menampilkan mekah.jpg
                        //selain dari itu menampilkan madinah.jpg
                        trailing: Image.asset(data[index]['type'] == 'mekah' ? 'mekah.jpg' : 'madinah.png', width: 32.0,),
                        //subtitle tampil tepat dibawah title
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                //menampiklan teks arti
                                Text('Arti : ', style: TextStyle(fontWeight: FontWeight.bold), ),
                                //menampilkan teks dari value arti
                                Text(data[index]['arti'], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                              ],
                            ),

                            //Row selanjutnya menampilkan jumlah ayat
                            Row(
                              children: <Widget>[
                                Text('Diturunkan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                //dengan index type
                                Text(data[index]['type'])
                              ],
                            )
                          ],
                        ),

                      )
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}


