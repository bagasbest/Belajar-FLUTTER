import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this gonna give us total height or width in our device
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                image: AssetImage('asset/image/undraw_pilates_gpdb.png'),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.settings),
                  ),
                ),
                SizedBox(
                  height: size.height * .25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          'asset/image/bagas.jpg',
                          height: 120.0,
                          width: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Bagas Pangestu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Text('Mobile Application Developer'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              openMedsos('https://www.youtube.com/channel/UCca9AHBP2bWJY6huzGEUt_g', 'YouTube');
                            },
                            child: Image.asset(
                              'asset/icon/youtube.png',
                              height: 40,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                              onTap: () {
                                openMedsos('https://www.instagram.com/bagas_best/', 'Instagram');
                              },
                              child: Image.asset(
                                'asset/icon/instagram.png',
                                height: 40,
                              )),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: Colors.orangeAccent,
                          onPressed: () {
                            toast('Kamu berhasil kepoin aku :)');
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text('Kepoin Aku Donk :)', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void toast (String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void openMedsos(String link, String medsos) async{
  if(await canLaunch(link)){
    await launch(
      link,
      universalLinksOnly: true,
    );
  } else {
    toast('Upps ada kendala saat mau buka $medsos');
    throw 'There was a problem to open the url: $link';
  }
}