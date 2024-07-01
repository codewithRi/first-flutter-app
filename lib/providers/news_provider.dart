import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=fc6009130c7a42c18b5c82e188ccb6d4'));

    try{
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['articles'];
        _articles = data.map((article) => Article.fromJson(article)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load articles');
      }
    }catch(e){
      print(e.toString());
    }

  }
}
