import 'package:tempo/core/resources/data_state.dart';
import 'package:tempo/core/usecases/usecase.dart';
import 'package:tempo/features/daily_news/domain/entities/article.dart';
import 'package:tempo/features/daily_news/domain/repositories/article_repository.dart';

class GetArticleUseCase
    implements Usecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticle();
  }
}
