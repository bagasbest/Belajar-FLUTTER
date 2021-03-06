import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jadwal_matkul/EditTask.dart';

class TaskList extends StatelessWidget {
  TaskList({this.document});
  final List<DocumentSnapshot> document;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String title = document[i].data()['title'].toString();
        String note = document[i].data()['note'].toString();
        DateTime _date = document[i].data()['dueDate'].toDate();
        String dueDate = "${_date.day}/${_date.month}/${_date.year}";

        return Dismissible(
          key: Key(document[i].id),
          onDismissed: (direction) {
            FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
                  await transaction.get(document[i].reference);
              transaction.delete(snapshot.reference);
            });

            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Jadwal berhasil dihapus")),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "Deadline: " +
                                  //     timeago
                                  //         .format(DateTime.tryParse(
                                  //             dueDate.toDate().toString()))
                                  //         .toString(),
                                  // style: TextStyle(fontSize: 15),
                                  dueDate,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.note,
                                color: Colors.orange,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Pesan: " + note,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ])),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => EditTask(
                                title: title,
                                dueDate: _date,
                                note: note,
                                index: document[i].reference,
                              )));
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
