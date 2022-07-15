import 'package:intl/intl.dart';

const String apiUrl = 'http://bimbelneutronmadiun.my.id/api/';
const String baseUrl = 'http://bimbelneutronmadiun.my.id/';

const String baseFolderFile = baseUrl + 'backend/upload/dataset/';
const String openWebViewDetil = baseUrl + 'lihat-detail?detail=';
const String openWebViewCsv = baseUrl + 'data-json?detail=';
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String toDay = formatter.format(now);
