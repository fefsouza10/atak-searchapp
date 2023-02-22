import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
            appBar: AppBar(
              title: const Text('Atak SearchApp'),
            ),
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: ((text) => {controller.query = text}),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Pesquisar...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: 'Pesquisar com Cheerio',
                        child: ElevatedButton(
                            onPressed: (() async => {
                                  controller.resetPage(),
                                  await controller
                                      .fetchSearchResultModelWithCheerio(
                                          query: controller.query,
                                          page: controller.page)
                                }),
                            child: const Text('Pesquisar com Cheerio')),
                      ),
                      Tooltip(
                        message: 'Pesquisar com Puppeteer',
                        child: ElevatedButton(
                            onPressed: (() async => {
                                  controller.resetPage(),
                                  await controller
                                      .fetchSearchResultModelWithPuppeteer(
                                          query: controller.query,
                                          page: controller.page)
                                }),
                            child: const Text('Pesquisar com Puppeteer')),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.7,
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.searchResultList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if (controller.searchResultList.isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Tooltip(
                                    message:
                                        'Resultado da Pesquisa com ${controller.lastSearchEngineUsed.name}',
                                    child: Column(
                                      children: [
                                        Text(controller
                                            .searchResultList[index].title
                                            .toString()),
                                        TextButton(
                                          onPressed: () async {
                                            String url = controller
                                                .searchResultList[index].link
                                                .toString();
                                            await launchUrlString(url,
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Text(controller
                                              .searchResultList[index].link
                                              .toString()),
                                        ),
                                        const Divider(thickness: 2.0),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await controller.previousPage();
                            },
                            child: const Text('Página anterior')),
                        controller.searchResultList.isNotEmpty
                            ? Text(controller.pageNumber)
                            : Container(),
                        ElevatedButton(
                            onPressed: () async {
                              await controller.nextPage();
                            },
                            child: const Text('Próxima página')),
                      ],
                    ),
                  )
                ],
              ),
            )),
        onLoading: const Center(child: CircularProgressIndicator()));
  }
}
