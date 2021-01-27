import 'package:flutter/material.dart';
import 'package:fundametal/view/strings.dart';

class Slivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  bool isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://github.com/dicodingacademy/a195-flutter-fundamental-labs/blob/google-pixel/google_pixel/assets/pixel_google.jpg?raw=true',
                  fit: BoxFit.fitWidth,
                ),
                title: Text('Google Pixel 2'),
                titlePadding: EdgeInsets.only(bottom: 16, left: 16),
              ),
            )
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r'$735',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Container(
                        color: Colors.black26,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.collections,
                              color: Colors.white,
                            ),
                            Text(
                              '6 photos',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Stok tersisa 5 buah',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(content_text),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Spesifikasi',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Table(
                    columnWidths: {1: FractionColumnWidth(0.7)},
                    children: [
                      TableRow(
                        children: [
                          Text('Display'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(content_specs_display),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Size'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(content_specs_size),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Battery'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(content_specs_battery),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Text(
                    'Dijual oleh',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('https://github.com/dicodingacademy/a195-flutter-fundamental-labs/blob/google-pixel/google_pixel/assets/photo_2.jpg?raw=true',),
                          radius: 24,
                        ),
                      ),
                      Text('Narenda Wicaksono'),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Beli ahhh'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
