// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/listofmatericategory.dart' as pg;

class GridMapel extends StatefulWidget {
  GridMapel(this._postsx, this.kelas, this.materi, {Key? key})
      : super(key: key);
  late List _postsx = [];
  String kelas;
  String materi;
  @override
  _GridMapelState createState() => _GridMapelState();
}

class _GridMapelState extends State<GridMapel> {
  String? hari = DateFormat("EEEE", "id_ID").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    print(widget.kelas);
    return SingleChildScrollView(
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 1.2,
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
            widget.materi,
            widget._postsx[index]['mapelid'],
          ),
        ),
      ),
    );
  }
}

class cardSaya extends StatelessWidget {
  cardSaya(this.title, this.hari, this.kelas, this.materi, this.mapelid,
      {Key? key})
      : super(key: key);
  String title;
  String hari;
  String kelas;
  String materi;
  int mapelid;

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
              materi == 'video'
                  ? Icon(
                      Icons.play_arrow_outlined,
                      size: 50,
                      color: Colors.grey.shade500,
                    )
                  : Icon(
                      Icons.book_outlined,
                      size: 50,
                      color: Colors.grey.shade500,
                    ),
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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => pg.ListOfMateriCategory(materi, mapelid),
        ),
      ),
    );
  }
}
