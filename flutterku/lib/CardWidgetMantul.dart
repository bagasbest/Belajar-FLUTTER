import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Custom Card Example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF8C062F),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFFE5788), Color(0xFFF56D5D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: IconShadowWidget(
                      Icon(
                        Icons.keyboard_arrow_left,
                        size: 50,
                        color: Colors.grey,
                      ),
                      shadowColor: Colors.red.shade100,
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  //80 persen dari lebar layar dan 70 persen dari tinggi layar
                  width: MediaQuery.of(context).size.width * 0.72,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Card(
                    elevation: 10,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: AssetImage('lib/assets/memphis.webp'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            image: DecorationImage(
                                image: AssetImage('lib/assets/sunset.webp'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              20,
                              50 + MediaQuery.of(context).size.height * 0.35,
                              20,
                              20),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Lagi Belajar Flutter, Jangan Ganggu!!!',
                                  style: TextStyle(
                                    color: Color(0xFFF56D5D),
                                    fontSize: 25,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Posted on  ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      Text(
                                        'November 22, 2020',
                                        style: TextStyle(
                                            color: Color(0xFFF56D5D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Spacer(
                                      flex: 10,
                                    ),

                                    //icon
                                    Icon(
                                      Icons.thumb_up,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),

                                    //text
                                    Text(
                                      '99',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(
                                      flex: 5,
                                    ),

                                    //icon
                                    Icon(
                                      Icons.comment,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    //text
                                    Text(
                                      '23',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(
                                      flex: 10,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 50,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
