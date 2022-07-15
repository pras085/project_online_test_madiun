// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../pages/readme.dart';
import '../pages/detilmateritext.dart';

class ListNilai extends StatelessWidget {
  ListNilai(this.mapel, this.pengajar, this.nilaiid, this.nilai, this.tglujian,
      {Key? key})
      : super(key: key);
  final String mapel;
  final String tglujian;
  final String pengajar;
  final String nilaiid;
  final String nilai;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        // shadowColor: Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mapel.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700],
                      ),
                    ),
                    Text(
                      "Pengajar : " + pengajar.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown[700],
                      ),
                    ),
                    Text(
                      "Nilai : " + nilai.toString() + " menit",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown[700],
                      ),
                    ),
                    Text(
                      "Tgl.Ujian : " + tglujian.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => DetilDocument(id)))
    );
  }
}
