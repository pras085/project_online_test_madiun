import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/flutter_html.dart';
import '../pages/detilujian.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;

class TentangKami extends StatefulWidget {
  TentangKami({Key? key}) : super(key: key);
  @override
  State<TentangKami> createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {
  late Future<List> dt;
  Future<List> fetchList() async {
    var url = Uri.parse(apiUrl + 'about');
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
          title: Text('Tentang Kami'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SingleChildScrollView(
            child: FutureBuilder<List>(
              future: dt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var d = snapshot.data ?? [];
                  if (d.length == 0) {
                    return Container(
                      child: Center(
                        child: Column(
                          children: [Text("No Data Found")],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Html(
                        data: d.first['about'],
                        style: {'html': Style(textAlign: TextAlign.center)},
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF863300),
                    ),
                  );
                  // return Text('');
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
