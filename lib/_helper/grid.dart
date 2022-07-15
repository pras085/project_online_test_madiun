// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import '../pages/materi_mapel.dart';

class GridKategori extends StatefulWidget {
  GridKategori(this._postsx, {Key? key}) : super(key: key);
  late final List _postsx;
  @override
  _GridKategoriState createState() => _GridKategoriState();
}

class _GridKategoriState extends State<GridKategori> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget._postsx.length,
          itemBuilder: (_, index) => cardSaya(
            widget._postsx[index]['name'],
            widget._postsx[index]['jenis'],
          ),
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
              jenis == 'video'
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
          builder: (context) => MateriMapel(jenis),
        ),
      ),
    );
  }
}
