import 'dart:convert';
import 'dart:core';

import 'package:atak_searchapp/config/http_config.dart';
import 'package:http/http.dart' as http;

import '../domain/search_result_model.dart';

class SearchResultService extends HttpConfig {
  Future<List<SearchResultModel>> fetchSearchResultModelWithPuppeteer(
      {required String query, required int page}) async {
    final response = await http.get(
      Uri.parse('$localhost/puppeteer/?query=$query&page=$page'),
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => SearchResultModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load search results.');
    }
  }

  Future<List<SearchResultModel>> fetchSearchResultModelWithCheerio(
      {required String query, required int page}) async {
    final response = await http.get(
      Uri.parse('http://192.168.15.125:3000/cheerio/?query=$query&page=$page'),
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => SearchResultModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load search results.');
    }
  }
}
