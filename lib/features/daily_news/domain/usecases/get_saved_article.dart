import 'package:tempo/core/usecases/usecase.dart';
import 'package:tempo/features/daily_news/domain/entities/article.dart';
import 'package:tempo/features/daily_news/domain/repositories/article_repository.dart';

class GetSavedArticleUseCase
    implements Usecase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
