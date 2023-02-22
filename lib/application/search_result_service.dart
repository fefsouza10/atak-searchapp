import 'dart:convert';
import 'dart:core';

import 'package:atak_searchapp/config/http_config.dart';
import 'package:http/http.dart' as http;

import '../domain/search_result_model.dart';

class SearchResultService extends HttpConfig {
  Future<String> loginAndGetJWTBearerToken() async {
    final response = await http.post(Uri.parse(
        '$localhost/auth/login?username=${userAPI['username']}&password=${userAPI['password']}'));

    if (response.statusCode == 201) {
      final token = response.body;
      return token;
    }
    throw Exception('Failed to retrieve Access Token');
  }

  Future<List<SearchResultModel>> fetchSearchResultModelWithPuppeteer(
      {required String token, required String query, required int page}) async {
    final response = await http.get(
      Uri.parse('$localhost/puppeteer/?query=$query&page=$page'),
      headers: {'Authorization': 'Bearer $token '},
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
      {required String token, required String query, required int page}) async {
    final response = await http.get(
      Uri.parse('http://192.168.15.125:3000/cheerio/?query=$query&page=$page'),
      headers: {'Authorization': 'Bearer $token '},
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
