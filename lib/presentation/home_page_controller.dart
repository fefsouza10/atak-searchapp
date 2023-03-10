import 'package:atak_searchapp/application/search_result_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/search_result_model.dart';

enum LastSearchEngineUsed { puppeteer, cheerio }

class HomePageController extends GetxController with StateMixin {
  final SearchResultService searchResultService = SearchResultService();
  String token = '';

  String query = '';
  int page = 0;
  String pageNumber = '1';
  late LastSearchEngineUsed lastSearchEngineUsed;
  bool isLoading = false;
  List<SearchResultModel> searchResultList = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    token = await loginAndGetJWTBearerToken();
    change(null, status: RxStatus.success());
  }

  Future<String> loginAndGetJWTBearerToken() async {
    return await searchResultService.loginAndGetJWTBearerToken();
  }

  Future<List<SearchResultModel>> fetchSearchResultModelWithPuppeteer({
    required String token,
    required String query,
    required int page,
  }) async {
    if (query.isNotEmpty) {
      enableLoading();
      lastSearchEngineUsed = LastSearchEngineUsed.puppeteer;
      searchResultList =
          await searchResultService.fetchSearchResultModelWithPuppeteer(
              token: token, query: query, page: page);
      disableLoading();
      update();
    } else {
      showNoQueryParameterSnackbar();
    }
    return searchResultList;
  }

  Future<List<SearchResultModel>> fetchSearchResultModelWithCheerio({
    required String token,
    required String query,
    required int page,
  }) async {
    if (query.isNotEmpty) {
      enableLoading();
      lastSearchEngineUsed = LastSearchEngineUsed.cheerio;
      searchResultList =
          await searchResultService.fetchSearchResultModelWithCheerio(
              token: token, query: query, page: page);
      disableLoading();
      update();
    } else {
      showNoQueryParameterSnackbar();
    }
    return searchResultList;
  }

  Future<void> previousPage() async {
    if (int.parse(pageNumber) != 1) {
      enableLoading();
      page = page - 10;
      subPageNumber();
      lastSearchEngineUsed == LastSearchEngineUsed.puppeteer
          ? await fetchSearchResultModelWithPuppeteer(
              token: token, query: query, page: page)
          : await fetchSearchResultModelWithCheerio(
              token: token, query: query, page: page);
    } else {
      Get.snackbar(
          'P??gina anterior inexistente!', 'Voc?? j?? est?? na primeira p??gina.',
          colorText: const Color.fromRGBO(255, 255, 255, 100),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromRGBO(70, 70, 70, 1));
    }
  }

  Future<void> nextPage() async {
    enableLoading();
    page = page + 10;
    addPageNumber();
    if (lastSearchEngineUsed == LastSearchEngineUsed.puppeteer) {
      await fetchSearchResultModelWithPuppeteer(
          token: token, query: query, page: page);
    } else {
      await fetchSearchResultModelWithCheerio(
          token: token, query: query, page: page);
    }
  }

  void enableLoading() {
    isLoading = true;
    update();
  }

  void disableLoading() {
    isLoading = false;
    update();
  }

  void addPageNumber() {
    pageNumber = (int.parse(pageNumber) + 1).toString();
    update();
  }

  void subPageNumber() {
    pageNumber = (int.parse(pageNumber) - 1).toString();
    update();
  }

  void resetPage() {
    page = 0;
    pageNumber = '1';
    update();
  }

  void showNoQueryParameterSnackbar() {
    Get.snackbar('Nada para pesquisar!',
        'Digite um termo para que a busca possa ser realizada.',
        colorText: const Color.fromRGBO(255, 255, 255, 100),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromRGBO(70, 70, 70, 1));
  }
}
