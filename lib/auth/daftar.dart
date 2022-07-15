// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './login.dart';
import '../_config/env.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({Key? key}) : super(key: key);

  @override
  _DaftarScreenState createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController nis = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpas = TextEditingController();
  TextEditingController name = TextEditingController();

  register() async {
    if (pass.text != confirmpas.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password tidak cocok',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } else if ((pass.text).isNotEmpty &&
        (name.text).isNotEmpty &&
        (nis.text).isNotEmpty) {
      var urls = Uri.parse(apiUrl + 'signup');
      final response = await http.post(urls,
          body: {"password": pass.text, "nis": nis.text, "nama": name.text});
      final data = jsonDecode(response.body);
      if (data.first['value'].toInt() == 1) {
        showAlertDialog(data.first['phonebimbel'].toString(), context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'NIS sudah digunakan',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.white,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Semua Form Wajib Diisi',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  final snackBar = SnackBar(content: Text('Gagal Memanggil...!!'));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFffd000),
                Color(0xFFff9500),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.09),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "DAFTAR",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 36),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontFamily: "Baloo",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: nis,
                      decoration: InputDecoration(
                        labelText: "NIS",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      style: TextStyle(
                        fontFamily: "Baloo",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      obscureText: true,
                      controller: pass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        fontFamily: "Baloo",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmpas,
                      decoration: InputDecoration(
                        labelText: "Confirmasi Password",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        fontFamily: "Baloo",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                        ),
                      ),
                      onPressed: () => register(),
                      child: Text(
                        " DAFTAR ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                      },
                      child: Text(
                        "Sudah punya akun? Login Disini",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return;
  }

  showAlertDialog(String numberphone, BuildContext context) {
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: const Text("Nanti"),
      onPressed: () async {
        setState(() {
          _key.currentState!.reset();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
    Widget call = FlatButton(
      child: const Text("Call"),
      onPressed: () async {
        setState(() {
          dialNumber(phoneNumber: numberphone, context: context);
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Berhasil"),
      content: Text(
          "Anda berhasil mendaftar, silahkan datang atau hubungi kami ( " +
              numberphone.toString() +
              ") dan lakukan daftar ulang untuk bergabunag bersama bimbel neutron."),
      actions: [
        call,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
