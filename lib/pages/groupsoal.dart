// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, avoid_print, prefer_const_constructors, duplicate_ignore, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;
import '../_helper/listgroupsoal.dart';

class GroupSoal extends StatefulWidget {
  GroupSoal({Key? key}) : super(key: key);
  @override
  State<GroupSoal> createState() => _GroupSoalState();
}

class _GroupSoalState extends State<GroupSoal> {
  late List jsonString = [];
  int _kelas_id = 0;
  int _siswa_id = 0;

  void listGroupSoal(String kelasid, siswaid) async {
    try {
      final j = 'groupsoal';
      var urls = Uri.parse(apiUrl + j.toString());
      final response = await http.post(urls, body: {
        "kelas_id": kelasid.toString(),
        "siswa_id": siswaid.toString(),
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
      _siswa_id = prefValue.getInt('id') ?? 0;
      listGroupSoal(_kelas_id.toString(), _siswa_id.toString());
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
            'Ujian',
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
                        itemBuilder: (BuildContext context, index) => jsonString
                                .isNotEmpty
                            ? ListGroupSoal(
                                jsonString[index]['mapelname'].toString(),
                                jsonString[index]['pengajarname'].toString(),
                                jsonString[index]['id'].toString(),
                                jsonString[index]['waktu'].toString(),
                                jsonString[index]['expireddate'].toString())
                            : const Center(
                                child: Text('Belum ada data ujian diupload!'),
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
