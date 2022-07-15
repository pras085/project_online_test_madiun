// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, avoid_print, prefer_const_constructors, duplicate_ignore, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;
import '../_helper/listnilai.dart';

class Nilai extends StatefulWidget {
  Nilai({Key? key}) : super(key: key);
  @override
  State<Nilai> createState() => _NilaiState();
}

class _NilaiState extends State<Nilai> {
  late List jsonString = [];
  int _siswa_id = 0;

  void listNilai(String siswaid) async {
    try {
      final j = 'nilai/' + siswaid.toString();
      var urls = Uri.parse(apiUrl + j.toString());
      final response = await http.get(urls);
      final data = json.decode(response.body);
      setState(() {
        jsonString = data;
      });
    } catch (err) {
      print(err);
    }
  }

  getSiswa() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _siswa_id = prefValue.getInt('id') ?? 0;
      listNilai(_siswa_id.toString());
    });
  }

  @override
  void initState() {
    getSiswa();
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
            'Nilai',
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
                                ? ListNilai(
                                    jsonString[index]['mapelname'].toString(),
                                    jsonString[index]['pengajar'].toString(),
                                    jsonString[index]['id'].toString(),
                                    jsonString[index]['nilai'].toString(),
                                    jsonString[index]['tglujian'].toString())
                                : const Center(
                                    child: Text('Belum ada nilai!'),
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
            getSiswa();
          });
        });
        return completer.future;
      },
    );
  }
}
