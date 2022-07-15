// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import './../_helper/gridgroupsoal.dart';
import './../_helper/grid.dart';

class ListSoalAndNilai extends StatelessWidget {
  List jsonString = [
    {'name': 'Soal', 'jenis': 'soal'},
    {'name': 'Nilai', 'jenis': 'nilai'}
  ];
  ListSoalAndNilai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridGroupSoal(jsonString),
      ),
    );
  }
}
