import 'package:beresto/screen/select_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String language;

class ReservationPage extends StatefulWidget {
  final data;

  ReservationPage({@required this.data});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime _dueDate = DateTime.now();
  String _dateText = "";

  /// Convert DateTime to custom form example: DD/MM/YYYY
  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Online Reservation',
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'RESERVATION',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RESERVATION TIME',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      FlatButton(
                        onPressed: () => _selectDueDate(context),
                        color: Colors.grey[200],
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Scheduled at ' + _dateText,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Divider(
                          color: Colors.grey,
                          height: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'TABLE LIST',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropDownWidget()),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                child: RaisedButton(
                  color: Colors.orangeAccent,
                  onPressed: () {
                    if (_dateText.isNotEmpty && language != null) {
                      Route route = MaterialPageRoute(
                        builder: (context) => SelectMenuPage(
                          data: widget.data,
                          dateTime: 'Scheduled at $_dateText',
                          seatNumber: language,
                        ),
                      );
                      Navigator.push(context, route);
                    } else {
                      _toast('Date Time and Seat number must not empty!');
                    }
                  },
                  child: Text(
                    'ORDER',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem(
          child: Text('Table 1, Max 6 people'),
          value: 'Table 1',
        ),
        DropdownMenuItem(
          child: Text('Table 2, Max 8 people'),
          value: 'Table 2',
        ),
        DropdownMenuItem(
          child: Text('Table 3, Max 6 people'),
          value: 'Table 3',
        ),
        DropdownMenuItem(
          child: Text('Table 4, Max 4 people'),
          value: 'Table 4',
        ),
        DropdownMenuItem(
          child: Text('Table 5, Max 4 people'),
          value: 'Table 5',
        ),
        DropdownMenuItem(
          child: Text('Table 6, Max 6 people'),
          value: 'Table 6',
        ),
      ],
      value: language,
      hint: Text('Take a Seat Number'),
      onChanged: (String value) {
        setState(() {
          language = value;
        });
      },
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
