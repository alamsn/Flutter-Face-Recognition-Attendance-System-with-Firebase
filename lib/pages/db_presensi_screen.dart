import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/pages/admin_screen.dart';
import 'widgets/datetime.dart';
import 'widgets/datetime_picker_widget.dart';
import 'package:intl/intl.dart';

class DBScreen extends StatefulWidget {
  static String id = 'DB_Screen';
  final Timestamp timeStamp;
  DBScreen({this.timeStamp});
  @override
  _DBScreenState createState() => _DBScreenState();
}

class _DBScreenState extends State<DBScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();

  CollectionReference _presensi =
      FirebaseFirestore.instance.collection('presensi');

  String getText() {
    if (widget.timeStamp != null) {
      return DateFormat('dd-MM-yyyy hh:mm').format(widget.timeStamp.toDate());
    } else {
      return '';
    }
  }

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _namaController.text = documentSnapshot['nama'];
      _waktuController.text = documentSnapshot['waktu'].toDate().toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(labelText: 'nama'),
                ),
                DatetimePickerWidget(),
                SizedBox(height: 10),
                Text(
                  getText(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 200),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String nama = _namaController.text;
                    final Timestamp waktu = widget.timeStamp;
                    print(widget.timeStamp);
                    print(waktu);
                    if (nama != null && waktu != null) {
                      if (action == 'create') {
                        // create data
                        await _presensi.add({"nama": nama, "waktu": waktu});
                      }
                      if (action == 'update') {
                        // Update data
                        await _presensi
                            .doc(documentSnapshot.id)
                            .update({"nama": nama, "waktu": waktu});
                      }
                      // Clear the text fields
                      _namaController.text = '';
                      _waktuController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteData(String nama) async {
    await _presensi.doc(nama).delete();
    // Show a snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sukses menghapus data')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DB Presensi'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: MaterialButton(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, AdminScreen.id);
                });
              },
            ),
          ),
        ],
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _presensi.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['nama']),
                    subtitle: Text(formattedDate(documentSnapshot['waktu'])),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Text(documentSnapshot['keterangan']),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteData(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),
    );
  }
}
