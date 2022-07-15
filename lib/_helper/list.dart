// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ListDocument extends StatelessWidget {
  ListDocument(this.mapel, this.pengajar, this.hari, this.waktu, this.id,
      {Key? key})
      : super(key: key);
  final String mapel;
  final String pengajar;
  final String hari;
  final String waktu;
  final int id;
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
                      mapel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          hari.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.brown[700],
                          ),
                        ),
                        Text(
                          ' - ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.brown[700],
                          ),
                        ),
                        Text(
                          waktu,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.brown[700],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      pengajar,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
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
      onTap: () => {},
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => DetilDocument(id)))
    );
  }
}
