// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;

class Topicdetil extends StatefulWidget {
  Topicdetil(
      this.id, this.title, this.desc, this.pengajar, this.foto, this.created_at,
      {Key? key})
      : super(key: key);
  final String id;
  final String title;
  final String desc;
  final String pengajar;
  final String foto;
  final String created_at;
  @override
  State<Topicdetil> createState() => _TopicdetilState();
}

class _TopicdetilState extends State<Topicdetil> {
  TextEditingController _msg = TextEditingController();
  final snackBar = SnackBar(
    content: Text('Anda belum mengetik pesan apapun',
        style: TextStyle(fontFamily: 'Baloo', color: Colors.white)),
    backgroundColor: Colors.red.shade700,
  );
  // Controller untuk listView
  late ScrollController _controller;
  // alamat url API
  final _baseUrl = apiUrl;
  // Ambil 10 post dari key yang di bawa
  int _page = 1;
  // late String _ncategory = widget.ncategory;
  // page berigkutnya true atau false
  bool _hasNextPage = true;

  // masukan indicator loading
  bool _isFirstLoadRunning = false;

  // indikator keluar ketika load more
  bool _isLoadMoreRunning = false;

  // tampung data dalam bentuk list
  List _posts = [];
  bool _repliesdata = false;
  int _postid = 0;
  int _siswa_id = 0;
  double _height = 90.0;
  String namereply = '';
  String textreply = '';

  // menampilkan data pertama
  void _firstLoad() async {
    print(_page);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      var url = Uri.parse(_baseUrl +
          'topic/detil/' +
          widget.id.toString() +
          '?page=' +
          _page.toString());
      final res = await http.get(url);
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      print(err);
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // menampilkan data berikutnya (loadmore)
  void _loadMore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 200) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        var url = Uri.parse(_baseUrl +
            'topic/detil/' +
            widget.id.toString() +
            '?page=' +
            _page.toString());
        final res = await http.get(url);
        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // setSate
          print(_posts);
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  getSiswa() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _siswa_id = prefValue.getInt('id') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getSiswa();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: false,
        flexibleSpace: Container(
          // ignore: prefer_const_constructors
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
        title: Text('Forum'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      // shadowColor: Colors.blue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, bottom: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage: NetworkImage(
                                              widget.foto.toString()),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 5,
                                                right: 5,
                                                left: 5,
                                              ),
                                              child: Text(
                                                widget.pengajar.toString(),
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
                                                widget.created_at.toString() +
                                                    " lalu",
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.title.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Html(
                                    data: widget.desc.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Balasan Forum",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height + 100,
                      child: _posts != null
                          ? _isFirstLoadRunning
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.brown[600],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: ListView.builder(
                                        controller: _controller,
                                        itemCount: _posts.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (_, index) =>
                                            _posts.isNotEmpty
                                                ? ListReply(
                                                    _posts[index]['replies']
                                                        .toList(),
                                                    _posts[index]['username']
                                                        .toString(),
                                                    _posts[index]['post']
                                                        .toString(),
                                                    _posts[index]['userfoto']
                                                        .toString(),
                                                    _posts[index]['created_at']
                                                        .toString(),
                                                    _posts[index]['id'],
                                                  )
                                                : Center(
                                                    child: Text('Data Kososng'),
                                                  ),
                                      ),
                                    ),

                                    //when the _loadMore function is running
                                    if (_isLoadMoreRunning == true)
                                      Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.orange[600],
                                        ),
                                      ),

                                    // When nothing else to load
                                    if (_hasNextPage == false) Container(),
                                  ],
                                )
                          : Center(
                              child: Text('Belum Ada data yang di publish'),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Container(
              height: _height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Color(0xFFffd000),
                    Color(0xFFff9500),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  // top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_repliesdata) ...[
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 0,
                          color: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0.0,
                                  bottom: 0.0,
                                  child: IconButton(
                                    color: Colors.grey.shade800,
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        _repliesdata = false;
                                        _postid = 0;
                                        _height = 90.0;
                                        namereply = '';
                                        textreply = '';
                                      });
                                    },
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      namereply.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      textreply.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _msg,
                            minLines: 1,
                            maxLines: 2,
                            // controller: textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'ketikan balasan...',
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                // color: Color(0xffAEA4A3),
                              ),
                            ),
                            textInputAction: TextInputAction.send,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.orange.shade900,
                          onPressed: () {
                            postkeforum(
                              _msg.text.toString(),
                              _siswa_id.toString(),
                              widget.id.toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  postkeforum(String msg, String siswaid, String topicid) async {
    if ((msg.toString()).isNotEmpty) {
      if (_repliesdata == false) {
        try {
          Map<String, String> headers = {
            'Content-type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          };
          var urls = Uri.parse(apiUrl + 'forum/posttopic');
          final response = await http.post(
            urls,
            headers: headers,
            body: {
              "post": msg.toString(),
              "siswa_id": siswaid.toString(),
              "topic_id": topicid.toString(),
            },
          );
          final data = json.decode(response.body);
          if (data == 1) {
            setState(() {
              setState(() {
                getSiswa();
                _firstLoad();
                _controller = new ScrollController()..addListener(_loadMore);
                _repliesdata = false;
                _postid = 0;
                _height = 90.0;
                namereply = '';
                textreply = '';
                _msg.clear();
              });
            });
          } else {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Terjadi kesalahan saat menyimpan data, silahkan cek koneksi internet anda',
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Colors.white,
                ),
              );
            });
          }
        } catch (err) {
          print(err);
        }
      } else {
        try {
          Map<String, String> headers = {
            'Content-type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          };
          var urls = Uri.parse(apiUrl + 'forum/repliestopic');
          final response = await http.post(
            urls,
            headers: headers,
            body: {
              "post_id": _postid.toString(),
              "siswa_id": siswaid.toString(),
              "reply": msg.toString(),
            },
          );
          final data = json.decode(response.body);
          if (data == 1) {
            setState(() {
              getSiswa();
              _firstLoad();
              _controller = new ScrollController()..addListener(_loadMore);
              _repliesdata = false;
              _postid = 0;
              _height = 90.0;
              namereply = '';
              textreply = '';
              _msg.clear();
            });
          } else {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Terjadi kesalahan saat menyimpan data, silahkan cek koneksi internet anda',
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Colors.white,
                ),
              );
            });
          }

          print(data);
        } catch (err) {
          print(err);
        }
      }
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Anda belum menulis pesan apapun',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.white,
          ),
        );
      });
    }
  }

  Widget ListReply(List replies, String name, String reply, String foto,
      String created_at, int idpost) {
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
                              onBackgroundImageError: (exception, context) {
                                print('${foto.toString()} Cannot be loaded');
                              },
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
                              onPressed: () {
                                setState(() {
                                  _repliesdata = true;
                                  _postid = idpost;
                                  _height = 200;
                                  namereply = name.toString();
                                  textreply = reply.toString();
                                });
                              },
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

  Widget CardReplies(
      String name, String reply, String foto, String created_at) {
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
                          onBackgroundImageError: (exception, context) {
                            print('${foto.toString()} Cannot be loaded');
                          },
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
