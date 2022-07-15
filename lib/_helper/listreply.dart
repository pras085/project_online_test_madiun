import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ListReply extends StatelessWidget {
  const ListReply(
      this.replies, this.name, this.reply, this.foto, this.created_at,
      {Key? key})
      : super(key: key);
  final List replies;
  final String name;
  final String reply;
  final String foto;
  final String created_at;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
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
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(foto.toString()),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    right: 5,
                                    left: 5,
                                  ),
                                  child: Text(
                                    name.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                    right: 5,
                                    left: 5,
                                  ),
                                  child: Text(
                                    created_at.toString() + " lalu",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.replay),
                            ),
                          ),
                        ],
                      ),
                      Html(
                        data: reply.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (replies.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // <-- this will disable scroll
                    shrinkWrap: true,
                    itemCount: replies.length,
                    itemBuilder: (_, index) {
                      if (replies.isNotEmpty) {
                        return CardReplies(
                          replies[index]['username'].toString(),
                          replies[index]['reply'].toString(),
                          replies[index]['userfoto'].toString(),
                          replies[index]['created_at'].toString(),
                        );
                      } else {
                        return Text('');
                      }
                    }),
              ),
            ),
          )
        ],
      ],
    );
  }
}

class CardReplies extends StatelessWidget {
  CardReplies(this.name, this.reply, this.foto, this.created_at, {Key? key})
      : super(key: key);
  final String name;
  final String reply;
  final String foto;
  final String created_at;
  @override
  Widget build(BuildContext context) {
    return Card(
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
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(foto.toString()),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                                right: 5,
                                left: 5,
                              ),
                              child: Text(
                                name.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 5,
                                right: 5,
                                left: 5,
                              ),
                              child: Text(
                                created_at.toString() + " lalu",
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Html(
                    data: reply.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
