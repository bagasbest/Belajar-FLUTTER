import 'package:flutter/material.dart';
import 'package:fundametal/model/note.dart';
import 'package:fundametal/provider/db_provider.dart';
import 'package:provider/provider.dart';

class NoteAddUpdatePage extends StatefulWidget {
  final Note note;

  NoteAddUpdatePage({this.note});

  @override
  _NoteAddUpdatePageState createState() => _NoteAddUpdatePageState();
}

class _NoteAddUpdatePageState extends State<NoteAddUpdatePage> {
  var _controllerTitle = TextEditingController();
  var _controllerDescription = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _controllerTitle.text = widget.note.title;
      _controllerDescription.text = widget.note.description;
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _controllerTitle,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _controllerDescription,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Simpan'),
                onPressed: () async {
                  // TODO : Tambahkan kode untuk menyimpan atau mengedit note
                  if(!_isUpdate) {
                    final note = Note (
                      title: _controllerTitle.text,
                      description: _controllerDescription.text,
                    );

                    Provider.of<DbProvider> (context, listen: false)
                    .addNote(note);
                  } else {
                    final note = Note(
                      id: widget.note.id,
                      title: _controllerTitle.text,
                      description: _controllerDescription.text,
                    );
                    Provider.of<DbProvider> (context, listen: false)
                        .updateNote(note);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
