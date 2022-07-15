// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;
import '../_helper/list.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({Key? key}) : super(key: key);

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  late List jsonString = [];
  int _kelas_id = 0;

  listJadwalx(String kelasid) async {
    try {
      var urls = Uri.parse(apiUrl + 'jadwal');
      final response = await http.post(urls, body: {"kelas_id": kelasid});
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
      listJadwalx(_kelas_id.toString());
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
                    SizedBox(height: size.height * 0.01),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: const [
                              Color(0xFFff9500),
                              Color(0xFFffd000),
                              Colors.white,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Jadwal Bimbel Tatap Muka Anda',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: jsonString.length,
                        itemBuilder: (BuildContext context, index) =>
                            jsonString.isNotEmpty
                                ? ListDocument(
                                    jsonString[index]['mapel'].toString(),
                                    jsonString[index]['pengajar'].toString(),
                                    jsonString[index]['hari'].toString(),
                                    jsonString[index]['dari'].toString() +
                                        ' s/d ' +
                                        jsonString[index]['sampai'].toString(),
                                    jsonString[index]['id'],
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
    // return Container(
    //   child: Text(
    //     DateFormat("EEEE", "id_ID").format(DateTime.now()),
    //   ),
    // );
  }
}
