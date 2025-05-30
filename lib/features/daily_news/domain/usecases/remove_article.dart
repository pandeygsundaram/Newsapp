import 'package:tempo/core/usecases/usecase.dart';
import 'package:tempo/features/daily_news/domain/entities/article.dart';
import 'package:tempo/features/daily_news/domain/repositories/article_repository.dart';

class RemoveArticleUseCase
    implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity ? params}) {
    return _articleRepository.removeArticle(params!);
  }
}
