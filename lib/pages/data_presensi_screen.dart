import 'package:flutter/material.dart';
import '/pages/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/datetime.dart';

class DataPresensiScreen extends StatefulWidget {
  static String id = 'Data_Presensi_Screen';
  @override
  _DataPresensiScreenState createState() => _DataPresensiScreenState();
}

class _DataPresensiScreenState extends State<DataPresensiScreen> {
  CollectionReference _presensi =
      FirebaseFirestore.instance.collection('presensi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Presensi'),
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
                  Navigator.pushNamed(context, UserScreen.id);
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
                          // children: [Text(documentSnapshot['keterangan'])],
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
    );
  }
}
