import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          margin: EdgeInsets.all(10),
          // child: ListView(
          //   children: [
          //     buildCard(Icons.account_box, 'Account Box'),
          //     buildCard(Icons.adb, 'Serangga Android'),
          //   ],
          // ),

          child: Center(
            child: SizedBox(
              width: 300,
              height: 550,
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //     image: DecorationImage(
                      //         image: AssetImage('lib/assets/sunset.webp'),
                      //         fit: BoxFit.fill)),

                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        child: Image(
                          width: 300,
                          height: 400,
                          image: NetworkImage(
                              'https://static.republika.co.id/uploads/images/inpicture_slide/langit-malam-ilustrasi-_130115174120-385.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'To: Seo Dal-Mi.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Milonga"),
                              ),
                            ),
                            Text(
                              'Selamat Malam, Semoga Mimpi Indah.',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Milonga"),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card buildCard(IconData iconData, String text) {
    return Card(
      elevation: 5,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(5),
              child: Icon(
                iconData,
                color: Colors.green,
              )),
          Text(text),
        ],
      ),
    );
  }
}
