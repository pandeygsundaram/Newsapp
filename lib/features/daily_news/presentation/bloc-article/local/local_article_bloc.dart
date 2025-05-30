import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tempo/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:tempo/features/daily_news/domain/usecases/remove_article.dart';
import 'package:tempo/features/daily_news/domain/usecases/save_article.dart';
import 'package:tempo/features/daily_news/presentation/bloc-article/local/local_article_event.dart';
import 'package:tempo/features/daily_news/presentation/bloc-article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  LocalArticleBloc(this._getSavedArticleUseCase, this._removeArticleUseCase,
      this._saveArticleUseCase)
      : super(const LocalArticlesLoading()){
          on <GetSavedArticles> (onGetSavedArticles);
          on<RemoveArticle> (onRemoveArticle);
          on<SaveArticle> (onSaveArticle);
      }

  void onGetSavedArticles(GetSavedArticles event,Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(     
      RemoveArticle removearticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removearticle.article);
        final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle( 
      SaveArticle savearticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: savearticle.article);
    final articles = await _getSavedArticleUseCase(params: savearticle.article);
    emit(LocalArticlesDone(articles));
  }



}
