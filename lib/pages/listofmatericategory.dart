// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, avoid_print, prefer_const_constructors, duplicate_ignore, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;
import '../_helper/listmatericategoy.dart' as h;

class ListOfMateriCategory extends StatefulWidget {
  ListOfMateriCategory(this.materi, this.mapel, {Key? key}) : super(key: key);
  String materi;
  int mapel;
  @override
  State<ListOfMateriCategory> createState() => _ListOfMateriCategoryState();
}

class _ListOfMateriCategoryState extends State<ListOfMateriCategory> {
  late List jsonString = [];
  int _kelas_id = 0;

  void listMateriMapelx(String kelasid) async {
    try {
      const j = "matericategory";
      widget.materi.toString() == 'text' ? 'materitext' : 'materivideo';
      var urls = Uri.parse(apiUrl + j);
      final response = await http.post(urls, body: {
        "kelas_id": kelasid.toString(),
        "mapel_id": widget.mapel.toString(),
        "materi": widget.materi.toString()
      });
      final data = json.decode(response.body);
      setState(() {
        jsonString = data;
      });
    } catch (err) {
      print(err);
    }
  }

  getKelas() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _kelas_id = prefValue.getInt('kelasid') ?? 0;
      listMateriMapelx(_kelas_id.toString());
    });
  }

  @override
  void initState() {
    getKelas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: Colors.orange,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                colors: const [
                  Color(0xFFffd000),
                  Color(0xFFff9500),
                ],
              ),
              borderRadius: BorderRadius.only(
                // ignore: prefer_const_constructors
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          title: Text(
            'Materi Kategori ',
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: jsonString.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange[600],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: jsonString.length,
                        itemBuilder: (BuildContext context, index) =>
                            jsonString.isNotEmpty
                                ? h.ListMateriCategory(
                                    jsonString[index]['nama'].toString(),
                                    jsonString[index]['kelasid'],
                                    jsonString[index]['id'],
                                    widget.materi.toString(),
                                  )
                                : const Center(
                                    child: Text('Data Kososng'),
                                  ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      onRefresh: () async {
        Completer<void> completer = Completer<void>();
        await Future.delayed(const Duration(seconds: 3)).then((onvalue) {
          completer.complete();
          setState(() {
            getKelas();
          });
        });
        return completer.future;
      },
    );
  }
}
