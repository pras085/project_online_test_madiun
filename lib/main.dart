// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, duplicate_ignore, avoid_print, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_import, unnecessary_new, duplicate_import

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './splashscreen.dart';
import 'auth/login.dart';
import './pages/akun.dart';
import './pages/home.dart';
import './pages/jadwal.dart';
import './pages/materi.dart';
import 'package:intl/intl.dart';
import './pages/jadwal.dart';
import 'package:change_app_package_name/change_app_package_name.dart';
// void main() {
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        highlightColor: Color(0xFFffd900),
        primaryColor: const Color(0xFFff9500),
        fontFamily: 'Baloo',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>
            MainPage(title: 'SIPP | PUSDATIN - KEMHAN'),
      },
      // home: MainPage(title: 'SIPP | PUSDATIN - KEMHAN'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 1;
  int activePage = 1;
  // ignore: prefer_const_constructors
  List<Widget> listWidgets = [
    // Organisasi(),
    Jadwal(),
    Home(),
    new ListMateri(),
    // Peraturan()
  ];
  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  logouts() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      _closeDrawer();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => logouts(),
    );

    Widget cancelButton = FlatButton(
      child: Text("Batal"),
      onPressed: () => Navigator.of(context).pop(),
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Keluar"),
      content: Text("Yakin Ingin keluar dari aplikasi?"),
      actions: [okButton, cancelButton],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFff9500),
                  const Color(0xFFffd000),
                ],
              ),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(20),
              //   bottomRight: Radius.circular(20),
              // ),
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () => showAlertDialog(context),
              );
            },
          ),
          title: Center(
            child: Text('BIMBELKU'),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Akun())),
                child: Icon(
                  Icons.account_circle_outlined,
                ),
              ),
            ),
          ],
        ),
        body: listWidgets[selectedIndex],
        bottomNavigationBar: ConvexAppBar.badge(
          {},
          items: [
            // TabItem(icon: Icons.device_hub, title: 'Organisasi'),
            TabItem(icon: Icons.calendar_today_outlined, title: 'Jadwal'),
            TabItem(icon: Icons.home_rounded, title: 'Frontpage'),
            TabItem(icon: Icons.list_alt, title: 'Materi'),
            // TabItem(icon: Icons.rule_outlined, title: 'Peraturan'),
          ],
          onTap: onItemTapped,
          activeColor: Colors.brown[50],
          backgroundColor: Color(0xFFff9500),
          initialActiveIndex: activePage,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
