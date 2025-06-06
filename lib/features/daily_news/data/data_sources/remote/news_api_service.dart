import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tempo/core/constants/constants.dart';
import 'package:tempo/features/daily_news/data/models/article_model.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
