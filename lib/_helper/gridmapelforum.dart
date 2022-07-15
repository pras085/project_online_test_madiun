// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/topikforum.dart';

class GridMapelForum extends StatefulWidget {
  GridMapelForum(this._postsx, this.kelas, {Key? key}) : super(key: key);
  late List _postsx = [];
  String kelas;
  @override
  _GridMapelForumState createState() => _GridMapelForumState();
}

class _GridMapelForumState extends State<GridMapelForum> {
  String? hari = DateFormat("EEEE", "id_ID").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    print(widget.kelas);
    return SingleChildScrollView(
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 0.9,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget._postsx.length,
          itemBuilder: (BuildContext context, index) => cardSaya(
            widget._postsx[index]['mapel'],
            hari!,
            widget.kelas,
            widget._postsx[index]['mapelid'],
            widget._postsx[index]['topikcount'],
          ),
        ),
      ),
    );
  }
}

class cardSaya extends StatelessWidget {
  cardSaya(this.title, this.hari, this.kelas, this.mapelid, this.topic,
      {Key? key})
      : super(key: key);
  String title;
  String hari;
  String kelas;
  int mapelid;
  int topic;

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
              Icon(
                Icons.forum_outlined,
                size: 50,
                color: Colors.grey.shade500,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  topic.toString() + ' Topik Aktif',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade700,
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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TopikForum(mapelid.toString()),
        ),
      ),
    );
  }
}
