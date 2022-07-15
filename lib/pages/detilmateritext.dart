import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;

class DetilMateriText extends StatefulWidget {
  DetilMateriText(this.id, this.nourut, this.panjang, {Key? key})
      : super(key: key);
  int id;
  String nourut;
  int panjang;
  @override
  State<DetilMateriText> createState() => _DetilMateriTextState();
}

class _DetilMateriTextState extends State<DetilMateriText> {
  late Future<List> dt;
  Future<List> fetchList() async {
    var url = Uri.parse(apiUrl + 'detil/materitext/' + widget.id.toString());
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    dt = fetchList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.orange,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color(0xFFffd000),
                  Color(0xFFff9500),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          title: Text('Detil'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SingleChildScrollView(
            child: FutureBuilder<List>(
              future: dt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var d = snapshot.data ?? [];
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.first['nama_materitext'].toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Divider(),
                        Html(
                          data: d.first['text'].toString(),
                          style: {
                            // tables will have the below background color
                            "table": Style(
                              backgroundColor:
                                  Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                            ),
                            "tr": Style(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                            "th": Style(
                              padding: EdgeInsets.all(6),
                              backgroundColor: Colors.grey,
                            ),
                            "td": Style(
                              padding: EdgeInsets.all(6),
                              alignment: Alignment.topLeft,
                            ),
                            // kalau mau tambahin style text supaya rata kiri kanan tambahkan saja css nya disini
                            "p": Style(
                              textAlign: TextAlign.justify,
                            ),
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF863300),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
      onRefresh: () async {
        Completer<void> completer = Completer<void>();
        await Future.delayed(const Duration(seconds: 3)).then((onvalue) {
          completer.complete();
          setState(() {});
        });
        return completer.future;
      },
    );
  }
}
