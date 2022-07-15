// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_field, unused_import, non_constant_identifier_names, unused_local_variable, avoid_print

// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_field, unused_import, non_constant_identifier_names, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../_config/env.dart';
import '../auth/login.dart';

class Akun extends StatefulWidget {
  const Akun({Key? key}) : super(key: key);

  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  var _key_controller = GlobalKey<FormState>();

  final _cnama = TextEditingController();
  final _calamat = TextEditingController();
  final _cgender = TextEditingController();
  final _cfoto = TextEditingController();
  final _capprove = TextEditingController();
  final _cemail = TextEditingController();
  final _cpassword = TextEditingController();
  final List<String> _locations = ['-', 'Laki-Laki', 'Perempuan'];
  String? _selectedLocation;
  String? _maritalStatus = '';
  String _nama = '';
  String _alamat = '';
  String _gender = '';
  String _foto = '';
  String _approve = '';
  String _email = '';
  String _password = '';
  int _id = 0;

  getUser() async {
    SharedPreferences prefValue = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefValue.getString('nama') ?? "";
      _alamat = prefValue.getString('alamat') ?? "";
      _gender = prefValue.getString('gender') ?? "";
      _foto = prefValue.getString('foto') ?? "";
      _approve = prefValue.getString('approve') ?? "";
      _email = prefValue.getString('email') ?? "";
      _password = prefValue.getString('password') ?? "";
      _id = prefValue.getInt('id') ?? 0;
      _maritalStatus = _gender.toString();

      _cnama.text = _nama.toString();
      _calamat.text = _alamat;
      _cemail.text = _email;
      _cfoto.text = _foto;
      _cgender.text = _maritalStatus.toString();
      _cpassword.text = '';
    });
  }

  void showError(e, s) {
    FlutterError.reportError(FlutterErrorDetails(
      exception: e,
      stack: s,
      library: 'widgets',
      context: ErrorDescription('while applying input formatters'),
    ));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getUser();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
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
        title: Text(
          'Akun',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key_controller,
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.09),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _cnama,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    fillColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.brown),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 2.0,
                      ),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Baloo",
                    color: Colors.brown,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _cemail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.brown),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 2.0,
                      ),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontFamily: "Baloo",
                    color: Colors.brown,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _calamat,
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  onEditingComplete: () {
                    setState(() {
                      _calamat.text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    fillColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.brown),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 2.0,
                      ),
                    ),

                    //fillColor: Colors.green
                  ),
                  style: TextStyle(
                    fontFamily: "Baloo",
                    color: Colors.brown,
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.02),
              // DropdownButton(
              //   value: _selectedLocation,
              //   onChanged: (newValue) {
              //     setState(() {
              //       _selectedLocation = newValue.toString();
              //     });
              //   },
              //   hint: Text('Pilih Gender'),
              //   items: _locations.map((location) {
              //     return DropdownMenuItem(
              //       child: Text(location),
              //       value: location,
              //     );
              //   }).toList(),
              // ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      activeColor: Colors.brown,
                      title: const Text(
                        'Laki-Laki',
                        style: TextStyle(color: Colors.brown),
                      ),
                      value: 'Laki-Laki',
                      groupValue: _maritalStatus,
                      onChanged: (value) {
                        setState(() {
                          _maritalStatus = value;
                          _cgender.text = _maritalStatus.toString();
                        });
                      },
                    ),
                    RadioListTile<String>(
                      activeColor: Colors.brown,
                      title: const Text(
                        'Perempuan',
                        style: TextStyle(color: Colors.brown),
                      ),
                      value: 'Perempuan',
                      groupValue: _maritalStatus,
                      onChanged: (value) {
                        setState(() {
                          _maritalStatus = value;
                          _cgender.text = _maritalStatus.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  obscureText: true,
                  controller: _cpassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.brown),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 2.0,
                      ),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    fontFamily: "Baloo",
                    color: Colors.brown,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Biarka kosong jika tidak ingin mengganti password.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red.shade600),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                    ),
                  ),
                  onPressed: () => {
                    updateData(
                      _cemail.text.toString(),
                      _cnama.text.toString(),
                      _calamat.text.toString(),
                      _id.toInt(),
                      _cpassword.text.toString(),
                      _cgender.text.toString(),
                    )
                  },
                  child: Text(
                    " PERBARUI ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateData(String email, String nama, String alamat, int id, String password,
      String gender) async {
    try {
      var urls = Uri.parse(apiUrl + 'akun/update/' + id.toString());
      final response = await http.put(urls, headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        // "Accept": "application/json",
        'Content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      }, body: {
        "email": email,
        "nama": nama,
        "alamat": alamat,
        "password": password,
        "gender": gender
      });
      final data = jsonDecode(response.body);
      print(data);
      if (_email.toString() != email.toString()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
      } else {
        if (data.first['value'].toInt() == 1) {
          setState(() {
            updatePref(
              data.first['email'].toString(),
              data.first['nama'].toString(),
              data.first['alamat'].toString(),
              data.first['gender'].toString(),
            );
          });
          // Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gagal Meng-update Data',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
            ),
          );
        }
      }
    } catch (e, s) {
      return showError(e, s);
    }
  }

  updatePref(String email, String nama, String alamat, String gender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("nama");
    preferences.remove("email");
    preferences.remove("alamat");
    preferences.remove("gender");
    // ignore: duplicate_ignore
    setState(() {
      preferences.setString("nama", nama);
      preferences.setString("email", email);
      preferences.setString("alamat", alamat);
      preferences.setString("gender", gender);
      // ignore: deprecated_member_use
      preferences.commit();
      getUser();
    });
  }
}
