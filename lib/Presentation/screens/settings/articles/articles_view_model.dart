import 'package:get/get.dart';
import 'package:thara/index/index_main.dart';

class ArticlesViewModel extends GetxController {
  List<ArticleItemModel>? list_articles;
  ArticleItemModel? article_details;

  @override
  onInit() {
    getArticles();
    super.onInit();
  }

  getArticles() {
    SettingsService().getArticles(
      voidCallBack: (data) {
        list_articles = data.data?.items;
        update();
      },
    );
  }

  getArticle_details(String key) {
    SettingsService().getArticleDetails(
      id: key,
      voidCallBack: (data) {
        article_details = data.data?.article;
        print("article_details is ${article_details?.toJson()}");
        update();
      },
    );
  }
}
