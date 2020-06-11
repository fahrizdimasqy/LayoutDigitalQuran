import 'package:flutter/material.dart';
//IMPORT PACKAGE UNTUK HTTP REQUEST DAN ASYNCHRONOUS
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(FlutterQuran());
}

class FlutterQuran extends StatefulWidget {
  @override
  _FlutterQuranState createState() => _FlutterQuranState();
}

class _FlutterQuranState extends State<FlutterQuran> {
  final String url = 'https://api.banghasan.com/quran/format/json/surat';
  List data;

  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['hasil'];
    });
    return 'success!';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Quran',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Digital Quran'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          data[index]['nomor'],
                          style: TextStyle(fontSize: 30.0),
                        ),
                        title: Text(
                          data[index]['nama'],
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        trailing: Image.asset(
                          data[index]['type'] == 'mekah'
                              ? 'mekah.jpg'
                              : 'madinah.png',
                          width: 32.0,
                          height: 32.0,
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Arti : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data[index]['arti'],
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Jumlah Ayat : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data[index]['ayat'],
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Diturunkan : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data[index]['type'],
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            ButtonTheme.bar(
                              child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: null,
                                      child: Text('Lihat Detail')),
                                  FlatButton(
                                      onPressed: null, child: Text('Dengarkan'))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}
