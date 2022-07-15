// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, unnecessary_new, unused_import, unused_element, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:ujian_online_smot/pages/gridintohome.dart';
import './../_helper/list.dart';
import './../_config/env.dart';
import 'groupsoal.dart';
import '../pages/forum_mapel.dart';
import '../pages/about.dart';
import '../pages/nilai.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _siswaname = '';
  List jsonStringx = [
    {'name': 'Ujian', 'jenis': 'soal'},
    {'name': 'Nilai', 'jenis': 'nilai'},
    {'name': 'Diskusi', 'jenis': 'forum'},
    {'name': 'Tentang Kami', 'jenis': 'about'}
  ];

  getNamaSiswa() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _siswaname = prefValue.getString('nama') ?? '';
    });
  }

  @override
  void initState() {
    getNamaSiswa();
    super.initState();
    // _firstLoad(_controllersearch.text);
    // _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.brown,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: const [
                      Color(0xFFffd000),
                      Color(0xFFff9500),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Stack(
                    // alignment: AlignmentDirectional.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hallo!. " + _siswaname.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            DateFormat("EEEE, d MMMM yyyy", "id_ID").format(
                              DateTime.now(),
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: -0,
                        right: -0,
                        child: Image.asset(
                          'assets/images/bg.png',
                          width: 240,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: jsonStringx.length,
                itemBuilder: (_, index) => cardSaya(
                  jsonStringx[index]['name'].toString(),
                  jsonStringx[index]['jenis'].toString(),
                ),
              ),
            ],
          ),
        ),
      ),
      onRefresh: () async {
        Completer<void> completer = Completer<void>();
        await Future.delayed(Duration(seconds: 3)).then((onvalue) {
          completer.complete();
          setState(() {
            // _page = 1;
            // _hasNextPage = true;
            // _isFirstLoadRunning = false;
            // _isLoadMoreRunning = false;
            // _firstLoad(_controllersearch.text);
            // _controller = new ScrollController()..addListener(_loadMore);
          });
        });
        return completer.future;
      },
    );
  }

  Widget box() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class cardSaya extends StatelessWidget {
  cardSaya(this.title, this.jenis, {Key? key}) : super(key: key);
  String title;
  String jenis;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (jenis == 'soal') ...[
                Icon(
                  Icons.list_alt_outlined,
                  size: 50,
                  color: Colors.grey.shade500,
                )
              ] else if (jenis == 'nilai') ...[
                Icon(
                  Icons.published_with_changes_outlined,
                  size: 50,
                  color: Colors.grey.shade500,
                )
              ] else if (jenis == 'forum') ...[
                Icon(
                  Icons.forum_outlined,
                  size: 50,
                  color: Colors.grey.shade500,
                )
              ] else if (jenis == 'about') ...[
                Icon(
                  Icons.info_outline,
                  size: 50,
                  color: Colors.grey.shade500,
                )
              ],
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2,
        shadowColor: Colors.grey,
        margin: EdgeInsets.all(20),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onTap: () {
        if (jenis == 'soal') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GroupSoal()),
          );
        } else if (jenis == 'nilai') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Nilai()),
          );
        } else if (jenis == 'forum') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ForumMapel()),
          );
        } else if (jenis == 'about') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TentangKami()),
          );
        }
      },
    );
  }
}
