// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_config/env.dart';
import 'package:http/http.dart' as http;

class ListUjian extends StatefulWidget {
  const ListUjian(this.id, {Key? key}) : super(key: key);
  final String? id;
  @override
  State<ListUjian> createState() => _ListUjianState();
}

class _ListUjianState extends State<ListUjian> {
  late Future<List> dt;
  List<String> jwb_user = [];
  int _siswaid = 0;
  int hal = 0;
  int key_now = 0;
  int back_click = 0;
  String _value = '';
  int jml = 0;
  bool is_back = false;
  bool is_start = true;
  bool checknilai = false;
  int nilai = 0;
  String text1 = 'Jawaban mu berhasil disimpan!';
  String text2 =
      'Silahkan Silahkan klik tombol tampilkan nilai untuk menampilkan nilai dari ujian mu.';
  String btnAction = 'Tampilkan Nilai';
  Future<List> fetchList(String sts) async {
    if (sts == 'next') {
      hal += 1;
    } else {
      hal -= 1;
    }
    var url = Uri.parse(
        apiUrl + 'soal/' + widget.id.toString() + '?page=' + hal.toString());
    final response = await http.get(url);
    setState(() {
      jml = json.decode(response.body)['length'];
      if (is_start) {
        for (var i = 1; i <= jml; i++) {
          jwb_user.add('f');
        }
        is_start = false;
      }
    });
    return json.decode(response.body)['data'];
  }

  getSiswaId() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _siswaid = prefValue.getInt('id') ?? 0;
    });
  }

  @override
  void initState() {
    dt = fetchList('next');
    getSiswaId();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: SingleChildScrollView(
            child: FutureBuilder<List>(
              future: dt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var d = snapshot.data ?? [];
                  if (d.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                            data: d.first['uraian'].toString(),
                            style: {
                              "body": Style(
                                fontSize: FontSize(18.0),
                              ),
                            },
                          ),
                          Html(
                            data: d.first['gambar'].toString(),
                            style: {
                              "body": Style(
                                fontSize: FontSize(18.0),
                              ),
                            },
                          ),
                          Divider(),
                          RadioButtonTile<String>(
                            value: 'a',
                            groupValue: _value,
                            leading: 'A',
                            title: Text(
                              d.first['opsia'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _value = value!),
                          ),
                          RadioButtonTile<String>(
                            value: 'b',
                            groupValue: _value,
                            leading: 'B',
                            title: Text(
                              d.first['opsib'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _value = value!),
                          ),
                          RadioButtonTile<String>(
                            value: 'c',
                            groupValue: _value,
                            leading: 'C',
                            title: Text(
                              d.first['opsic'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _value = value!),
                          ),
                          RadioButtonTile<String>(
                            value: 'd',
                            groupValue: _value,
                            leading: 'D',
                            title: Text(
                              d.first['opsid'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _value = value!),
                          ),
                          RadioButtonTile<String>(
                            value: 'e',
                            groupValue: _value,
                            leading: 'E',
                            title: Text(
                              d.first['opsie'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) =>
                                setState(() => _value = value!),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (key_now > 0) ...[
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () => setState(() {
                                    is_back = true;
                                    dt = fetchList('back');
                                    key_now -= 1;
                                    _value = jwb_user[key_now.toInt()];

                                    back_click += 1;
                                    is_back = false;
                                  }),
                                  child: Center(
                                    child: Text(
                                      'Kembali',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                onPressed: () => setState(() {
                                  dt = fetchList('next');
                                  if (is_back == false) {
                                    jwb_user[key_now] = _value;
                                    key_now += 1;
                                    // jwb_user.add('"' + _value + '"');

                                    is_back = false;
                                    _value = "";
                                  } else {
                                    key_now += 1;
                                    back_click -= 1;
                                    if (back_click > 0) {
                                      _value = jwb_user[key_now.toInt()];
                                    } else {
                                      _value = "";
                                    }
                                  }
                                }),
                                child: Center(
                                  child: Text(
                                    key_now == (jml - 1)
                                        ? 'Akhiri ?'
                                        : 'Berikutnya',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: key_now == (jml - 1)
                                          ? Colors.red
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Text('Jawaba : ' + jwb_user.toString()),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/finish.png',
                          width: 200,
                        ),
                        Text(
                          'Nilai',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        if (nilai <= 65) ...[
                          Text(
                            nilai.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          )
                        ] else if (nilai == 75) ...[
                          Text(
                            nilai.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          )
                        ] else if (nilai > 75) ...[
                          Text(
                            nilai.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          )
                        ] else ...[
                          Text(
                            nilai.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          )
                        ],
                        Center(
                          child: Text(
                            text1.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            text2.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            if (checknilai == false) {
                              setState(() {
                                postJawaban(
                                  widget.id.toString(),
                                  _siswaid.toString(),
                                );
                                btnAction = 'Kembali ke Beranda!';
                                checknilai = true;
                              });
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            }
                          },
                          child: Center(
                            child: Text(
                              btnAction,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF863300),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  postJawaban(String gsoalid, String siswaid) async {
    try {
      // print(json.encode(jwb_user));
      Map<String, String> headers = {
        'Content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      };
      var urls = Uri.parse(apiUrl + 'postjawaban');
      final response = await http.post(
        urls,
        headers: headers,
        body: {
          "jawaban": jsonEncode(jwb_user),
          "gsoalid": gsoalid.toString(),
          "siswaid": siswaid.toString()
        },
      );
      final data = json.decode(response.body);
      setState(() {
        nilai = data;
        print(nilai);
        if (nilai > 75) {
          text1 = 'Kamu Luar Biasa';
          text2 = 'Tetap Konsiten Yaa Belajarnya.';
        } else if (nilai == 75) {
          text1 = 'Kamu Hebat';
          text2 = 'Yuk Tingkatkan Lagi Belajarnya. Kamu Pasti Bisa!!';
        } else {
          text1 = 'Semangat!!';
          text2 = 'Kamu Harus Lebih Semangat Lagi Belajarnya.';
        }
      });
    } catch (err) {
      print(err);
    }
  }
}

class RadioButtonTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const RadioButtonTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            const SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
