import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditTask extends StatefulWidget {
  EditTask({this.title, this.dueDate, this.note, this.index});
  final String title;
  final DateTime dueDate;
  final String note;
  final index;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController controllerTitle;
  TextEditingController controllerNote;

  String user = FirebaseAuth.instance.currentUser.uid;
  DateTime _dueDate;
  String _dateText = "";

  void _editTask() {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      transaction.update(snapshot.reference,
          {"title": newTask, "note": note, "dueDate": _dueDate});
    });
    Navigator.pop(context);
  }

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dueDate = widget.dueDate;
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    newTask = widget.title;
    note = widget.note;

    controllerNote = TextEditingController(text: widget.note);
    controllerTitle = TextEditingController(text: widget.title);
  }

  String newTask;
  String note;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/45206/roofing-tile-red-wall-45206.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
                  fit: BoxFit.cover,
                ),
                color: Colors.orange,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 8.0,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MyTask",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "EDIT TASK",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 30.0,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: TextFormField(
              controller: controllerTitle,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                ),
                hintText: 'New Task',
                prefixIcon: Icon(
                  Icons.dashboard,
                  color: Colors.grey,
                ),
              ),
              // validator: (val) =>
              //     val.isEmpty ? "Enter a valid email address" : null,
              onChanged: (val) {
                setState(() {
                  newTask = val;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.date_range),
                ),
                Expanded(
                  child: Text(
                    "Due Date",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ),
                FlatButton(
                  onPressed: () => _selectDueDate(context),
                  child: Text(
                    _dateText,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: TextFormField(
              controller: controllerNote,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                ),
                hintText: 'Note',
                prefixIcon: Icon(
                  Icons.note,
                  color: Colors.grey,
                ),
              ),
              // validator: (val) =>
              //     val.isEmpty ? "Enter a valid email address" : null,
              onChanged: (val) {
                setState(() {
                  note = val;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 40,
                    ),
                    onPressed: () {
                      if (newTask.isEmpty || note.isEmpty) {
                        toast("Kolom tidak boleh kosong");
                      } else {
                        _editTask();
                      }
                    }),
                IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ],
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
