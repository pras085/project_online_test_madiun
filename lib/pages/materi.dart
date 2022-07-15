// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import './../_helper/grid.dart';

class ListMateri extends StatelessWidget {
  List jsonString = [
    {'name': 'Materi Text', 'jenis': 'text'},
    {'name': 'Materi Video', 'jenis': 'video'}
  ];
  ListMateri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridKategori(jsonString),
      ),
    );
  }
}
