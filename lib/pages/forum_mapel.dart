// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;
import '../_helper/gridmapelforum.dart';

class ForumMapel extends StatefulWidget {
  ForumMapel({Key? key}) : super(key: key);
  @override
  State<ForumMapel> createState() => _ForumMapelState();
}

class _ForumMapelState extends State<ForumMapel> {
  late List jsonString = [];
  int _kelas_id = 0;

  void listForumMapelx(String kelasid) async {
    try {
      var urls = Uri.parse(apiUrl + 'jadwalforum');
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
      listForumMapelx(_kelas_id.toString());
    });
  }

  @override
  void initState() {
    getKelas();
    super.initState();
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
          title: Text(
            'Forum Diskusi',
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
              : jsonString.isNotEmpty
                  ? GridMapelForum(jsonString, _kelas_id.toString())
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange[600],
                      ),
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
