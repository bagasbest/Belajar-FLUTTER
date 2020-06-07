import 'package:flutter/material.dart';

class AddNewItem extends StatefulWidget {
  final Function addNew; //KITA MENDEFINISIKAN SEBUAH FUNGSI DENGAN SEBUAH NAMA addNew
  AddNewItem(this.addNew); //DIMANA FUNGSI INI DI-PASSING DARI main.dart, SEHINGGA KITA MEMBUAT CONSTRUCTOR UNTUK MEMINTA FUNGSINYA

  @override
  _AddNewItemState createState() => _AddNewItemState();
}



class _AddNewItemState extends State<AddNewItem> {
  //BUAT CONTROLLER UNTUK MENG-HANDLE TEXTFIELD INPUT
  final titleController = TextEditingController();
  final hargaController = TextEditingController();
  final qtyController  = TextEditingController();

  //METHOD INI AKAN BERJALAN KETIKA TOMBOL DARI WIDGET FLATBUTTON DITEKAN
  void saveNewItem() {
    //MENGAMBIL CALUE DARI MASING MASING CONTROLLER INPUTAN DAN MENYIMPANNYA KE DALAM VARIABLE BARU
    final title = titleController.text;
    final harga = hargaController.text;
    final qty = int.parse(qtyController.text);

    if(title.isEmpty || harga.isEmpty || qty <= 0) {
      return;
    }

    widget.addNew(title, double.parse(harga), qty);
    //KARENA NANTINYA AKAN MENGGUNAKAN MODAL, MAKA GUNAKAN NAVIGATOR POP UNTUK MENUTUP MODAL
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Nama barang"),
              controller: titleController,  //CONTROLLER INI SERUPA DENGAN NAME PADA INPUTAN HTML
            ),

            TextField(
              decoration: InputDecoration(labelText: "Harga Barang"),
              controller: hargaController,
              keyboardType: TextInputType.number,
            ),

            TextField(
              decoration: InputDecoration(labelText: "Qty"),
              controller: qtyController,
              keyboardType: TextInputType.number,
            ),

            FlatButton(
              child: Text("Tambah"),
              onPressed: saveNewItem, //KETIKA DITEMAN JALANKAN METHOD
              textColor: Colors.pink,
            )
          ],
        ),
      ),
    );
  }
}
