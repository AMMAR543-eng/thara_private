import '../../../index/index_main.dart';

class ArticleModelResponse {
  final ArticleDataModel? data;

  const ArticleModelResponse({this.data});

  factory ArticleModelResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ArticleModelResponse();
    return ArticleModelResponse(
      data:
          json['data'] != null ? ArticleDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.toJson()};
}

class ArticleDataModel {
  final List<ArticleItemModel>? items;
  final Pagination? meta;

  const ArticleDataModel({this.items, this.meta});

  factory ArticleDataModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ArticleDataModel();
    return ArticleDataModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ArticleItemModel.fromJson(e))
          .toList(),
      meta: json['meta'] != null ? Pagination.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
        'meta': meta?.toJson(),
      };
}

class ArticleDetailsModelResponse {
  final ArticleDetailsData? data;

  const ArticleDetailsModelResponse({this.data});

  factory ArticleDetailsModelResponse.fromJson(Map<String, dynamic> json) {
    return ArticleDetailsModelResponse(
      data: json['data'] != null
          ? ArticleDetailsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

class ArticleDetailsData {
  final ArticleItemModel? article;

  ArticleDetailsData({this.article});

  factory ArticleDetailsData.fromJson(Map<String, dynamic> json) {
    return ArticleDetailsData(
      article: json['article'] != null
          ? ArticleItemModel.fromJson(json['article'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {'article': article?.toJson()};
}

class ArticleItemModel {
  final String? id;
  final String? title;
  final String? image;
  final String? content;
  final String? publishDate;

  const ArticleItemModel({
    this.id,
    this.title,
    this.image,
    this.publishDate,
    this.content,
  });

  factory ArticleItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ArticleItemModel();
    return ArticleItemModel(
      id: json['id'] as String?,
      content: json['content'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      publishDate: json['publish_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'title': title,
        'image': image,
        'publish_date': publishDate,
      };
}
