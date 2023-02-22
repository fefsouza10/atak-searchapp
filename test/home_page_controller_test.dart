import 'package:atak_searchapp/domain/search_result_model.dart';
import 'package:atak_searchapp/presentation/home_page_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final HomePageController controller = HomePageController();

  const mockQuery = 'Maringá';
  const mockPage = 0;

  final String token = await controller.loginAndGetJWTBearerToken();
  List<SearchResultModel> searchResultModelListFromPuppeteer =
      await controller.fetchSearchResultModelWithPuppeteer(
          token: token, query: mockQuery, page: mockPage);
  List<SearchResultModel> searchResultModelListFromCheerio =
      await controller.fetchSearchResultModelWithCheerio(
          token: token, query: mockQuery, page: mockPage);

  group('Testing fetch search results with both Puppeteer and Cheerio:', () {
    test('Search results from Puppeteer list should contain at least 3 items.',
        () {
      expect(searchResultModelListFromPuppeteer.length > 2, true,
          reason:
              'It should have fetched at least 3 items from search results.');
    });

    test('Search results from Cheerio list should contain at least 3 items.',
        () {
      expect(searchResultModelListFromCheerio.length > 2, true,
          reason:
              'It should have fetched at least 3 items from search results.');
    });
  });
}
