import "package:floor/floor.dart";
import "package:tempo/features/daily_news/data/models/article_model.dart";

@dao
abstract class ArticleDao {

  @Insert()
  Future<void> insertArticle(ArticleModel article);
  @delete
  Future<void> deleteArticle(ArticleModel article);
  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticle();
}
