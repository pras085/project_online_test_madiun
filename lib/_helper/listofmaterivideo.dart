// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import, unused_field, unused_local_variable, duplicate_ignore

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;

class ListMateriVideo extends StatefulWidget {
  ListMateriVideo(this.matericategoryid, {Key? key}) : super(key: key);
  int matericategoryid;
  @override
  State<ListMateriVideo> createState() => _ListMateriVideoState();
}

class _ListMateriVideoState extends State<ListMateriVideo> {
  YoutubePlayerController? _ytbPlayerController;
  List? videosList = [];
  int _kelas_id = 0;
  void listMateriVideoMapelx(String kelasid) async {
    try {
      const j = "materivideo";
      var urls = Uri.parse(apiUrl + j);
      final response = await http.post(urls, body: {
        "kelas_id": kelasid,
        "matericategoryid": widget.matericategoryid.toString()
      });
      final data = json.decode(response.body);
      print(data[0]);
      setState(() {
        videosList = data;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            _ytbPlayerController = YoutubePlayerController(
              initialVideoId: videosList![0],
              params: YoutubePlayerParams(
                startAt: const Duration(minutes: 1, seconds: 36),
                showControls: true,
                showFullscreenButton: true,
                desktopMode: false,
                privacyEnhanced: true,
                useHybridComposition: true,
              ),
            );
            _ytbPlayerController!.onEnterFullscreen = () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
              log('Entered Fullscreen');
            };
            _ytbPlayerController!.onExitFullscreen = () {
              log('Exited Fullscreen');
            };
          });
        });
      });
    } catch (err) {
      print(err);
    }
  }

  getKelas() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _kelas_id = prefValue.getInt('kelasid') ?? 0;
      listMateriVideoMapelx(_kelas_id.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getKelas();
  }

  @override
  Widget build(BuildContext context) {
    print(videosList);
    Size size = MediaQuery.of(context).size;
    const player = YoutubePlayerIFrame();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            // ignore: prefer_const_constructors
            gradient: LinearGradient(
              colors: const [
                Color(0xFFffd000),
                Color(0xFFff9500),
              ],
            ),
            borderRadius: BorderRadius.only(
              // ignore: prefer_const_constructors
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        title: Text(
          'Materi Video',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: _ytbPlayerController != null
                  ? YoutubePlayerIFrame(controller: _ytbPlayerController)
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: const [
                  Color(0xFFff9500),
                  Color(0xFFffd000),
                  Colors.white,
                ],
              )),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Materi Video .... Lainnya',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[900],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videosList!.length,
              // physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final _newCode = videosList![index].toString();
                    _ytbPlayerController!.load(_newCode);
                    _ytbPlayerController!.stop();
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      YoutubePlayerController.getThumbnail(
                        videoId: videosList![index].toString(),
                        quality: ThumbnailQuality.medium,
                      ),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
