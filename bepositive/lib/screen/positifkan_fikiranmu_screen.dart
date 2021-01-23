import 'package:bepositive/data/positifkan_fikiranmu_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PositifkanFikiranmu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positifkan Fikiranmu'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://blog.hif.com.au/theme/hif/assets/public/Image/Blog/Dr_Happy/postive_to_negative.png',
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Kamu Pasti Bisa Mencapai Tujuanmu!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Yang perlu kamu lakukan adalah sebagai berikut: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 400,
                    child: ListView(
                      children: positifkanFikiranmuList.map((event) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                event.title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(event.description),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
