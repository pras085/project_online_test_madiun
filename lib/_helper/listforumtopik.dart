// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../pages/topicdetil.dart';

class ListForumTopik extends StatelessWidget {
  ListForumTopik(this.title, this.desc, this.respon, this.topicid, this.status,
      this.created_at, this.pengajar, this.pengajarfoto,
      {Key? key})
      : super(key: key);
  final String title, status;
  final String respon;
  final String topicid;
  final String desc;
  final String created_at;
  final String pengajar;
  final String pengajarfoto;
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
                      title.toString(),
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
                      "Respon : " + respon.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown[700],
                      ),
                    ),
                    Text(
                      "Status : " + status.toString(),
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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Topicdetil(
              topicid, title, desc, pengajar, pengajarfoto, created_at),
        ),
      ),
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => DetilDocument(id)))
    );
  }
}
