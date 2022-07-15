// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, avoid_print

import 'package:flutter/material.dart';
import './../_config/env.dart';
import './../main.dart';
import './daftar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoading = false;
  bool _passwordVisible = true;
  final snackBar = SnackBar(
    content: Text(
        'Anda belum terdaftar sebagai siswa Bimbel Neutron Silahkan registrasi terlebih dahulu.',
        style: TextStyle(fontFamily: 'Baloo', color: Colors.white)),
    backgroundColor: Colors.red.shade700,
  );

  login() async {
    if ((user.text).isNotEmpty && (pass.text).isNotEmpty) {
      var urls = Uri.parse(apiUrl + 'signin');
      final response = await http
          .post(urls, body: {"nis": user.text, "password": pass.text});
      final data = jsonDecode(response.body);
      print(data);
      int value = data.first['value'];

      if (value.toInt() == 1) {
        String nama = data.first['nama'].toString();
        String alamat = data.first['alamat'].toString();
        String email = data.first['email'].toString();
        String gender = data.first['gender'].toString();
        String nis = data.first['nis'].toString();
        String foto = data.first['foto'].toString();
        int entitasId = data.first['entitasid'];
        String kelas = data.first['kelas'].toString();
        int kelasid = data.first['kelasid'];
        String jenjang = data.first['jenjang'].toString();
        int jenjangid = data.first['jenjangid'];
        String passwords = pass.text.toString();
        int id = data.first['id'];
        setState(() {
          savePref(value, nama, alamat, email, gender, nis, id, passwords, foto,
              entitasId, kelas, kelasid, jenjang, jenjangid);
          isLoading = false;
        });
        print('sukses');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(title: 'Neutron BIMBEL'),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else if ((user.text).isEmpty) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'NIS Wajib Diisi',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } else if ((pass.text).isEmpty) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password Wajib Diisi',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  // tampung secara local
  savePref(
      int value,
      String nama,
      String alamat,
      String email,
      String gender,
      String nis,
      int id,
      String passwords,
      String foto,
      int entitasId,
      String kelas,
      int kelasid,
      String jenjang,
      int jenjangid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("alamat", alamat);
      preferences.setString("email", email);
      preferences.setString("gender", gender);
      preferences.setString("nis", nis);
      preferences.setString("foto", foto);
      preferences.setInt("entitasId", entitasId);
      preferences.setString("kelas", kelas);
      preferences.setInt("kelasid", kelasid);
      preferences.setString("jenjang", jenjang);
      preferences.setInt("jenjangid", jenjangid);
      preferences.setString("password", passwords);
      preferences.setInt("id", id);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading == false
            ? Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "LOGIN",
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
                        controller: user,
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "NIS Wajib Diisi";
                          }
                        },
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
                        showCursor: true,
                        controller: pass,
                        obscureText: !_passwordVisible,
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Password Wajib Diisi";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                          fontFamily: "Baloo",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    //   child: Text(
                    //     "Lupa password anda?",
                    //     style: TextStyle(fontSize: 12, color: Colors.white),
                    //   ),
                    // ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          login();
                        },
                        child: Text(
                          " MASUK ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaftarScreen(),
                            ),
                          ),
                        },
                        child: Text(
                          "Belum punya akun? Daftar Disini.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
