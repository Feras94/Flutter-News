import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import '../models/newsItem.dart';

class AppApi {
  // singlton implementation
  static final instance = new AppApi._internal();
  AppApi._internal();

  final Map<String, String> _requestHeaders = {
    HttpHeaders.authorizationHeader: 'Bearer 2e1914b1e3c2401f996ac4d66f4eda93',
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
  };

  Future<List<NewsItem>> fetchNews() async {
    final response = await http.get('https://newsapi.org/v2/top-headlines?language=en', headers: _requestHeaders);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      final List<dynamic> jsonNewsItems = decodedBody['articles'];
      final List<NewsItem> newsItems = jsonNewsItems.map((jsonItem) {
        return NewsItem.fromJson(jsonItem);
      }).toList();

      return newsItems;
    } else {
      throw Exception('Loading News Failed!');
    }
  }
}
