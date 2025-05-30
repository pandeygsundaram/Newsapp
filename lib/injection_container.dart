import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tempo/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:tempo/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:tempo/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:tempo/features/daily_news/domain/repositories/article_repository.dart';
import 'package:tempo/features/daily_news/domain/usecases/get_article.dart';
import 'package:tempo/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:tempo/features/daily_news/domain/usecases/remove_article.dart';
import 'package:tempo/features/daily_news/domain/usecases/save_article.dart';
import 'package:tempo/features/daily_news/presentation/bloc-article/local/local_article_bloc.dart';
import 'package:tempo/features/daily_news/presentation/bloc-article/remote/remote_article_bloc.dart';

final s1 = GetIt.instance;

Future<void> initializeDependencies() async {
  try {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    s1.registerSingleton<AppDatabase>(database);
  } catch (e) {
    print("Error initializing database: $e");
  }

  //singleton are the once whose single instance is circulated throughout the app
  print("   Doing initial print");
  s1.registerSingleton<Dio>(Dio());
  print("   import ted dio package");
  s1.registerSingleton<NewsApiService>(NewsApiService(s1()));
  print("  instantiated newsapiservice");
  s1.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(s1(), s1()));
  print("  done with the articlerepository implementation");
  s1.registerSingleton<GetArticleUseCase>(GetArticleUseCase(s1()));
  print("  ran the getarticle function");
  //bloc wala part

  s1.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(s1()));


  s1.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(s1()));

  s1.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(s1()));

  //factory are the once which are instantiated again and again

  s1.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(s1()));

  s1.registerFactory
      <LocalArticleBloc>(() => LocalArticleBloc(s1(), s1(), s1()));
  
  print(" mounted the remotearticle bloc");
}
