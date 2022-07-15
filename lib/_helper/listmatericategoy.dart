import 'package:flutter/material.dart';
import '../pages/listofmateri.dart';
import '../_helper/listofmaterivideo.dart';

class ListMateriCategory extends StatelessWidget {
  ListMateriCategory(
      this.nama, this.kelasid, this.matericategoryid, this.materi,
      {Key? key})
      : super(key: key);
  String nama, materi;
  int kelasid;
  int matericategoryid;

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
                      nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
          builder: (context) => materi == 'video'
              ? ListMateriVideo(matericategoryid)
              : ListOfMateri(materi, nama, matericategoryid.toString()),
        ),
      ),
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => DetilDocument(id)))
    );
  }
}
