class SearchResultModel {
  String? title;
  String? link;

  SearchResultModel({this.title, this.link});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title!;
    data['link'] = link!;
    return data;
  }
}
