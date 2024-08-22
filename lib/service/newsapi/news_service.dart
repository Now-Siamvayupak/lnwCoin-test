import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'api_key.dart';

abstract class INewsService {
  Future<List<dynamic>> getNews();
}

class NewsService extends INewsService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiKeys.baseURL));
  final String _pathNews = "&apikey=${ApiKeys.apiKeyId}";

  @override
  Future<List<dynamic>> getNews() async {
    Set<String> uniqueTitles = Set();  // Set to store unique titles
    List<dynamic> filteredArticles = [];  // List to store filtered articles

    try {
      final response = await _dio.get(_pathNews);

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> articles = response.data['articles'];
        for (var article in articles) {
          String title = article['title'];
          if (!uniqueTitles.contains(title)) {  // Check if title is unique
            uniqueTitles.add(title);  // Add to set of titles
            filteredArticles.add(article);  // Add to filtered list
          }
        }
        return filteredArticles;  // Return the filtered list of articles
      } else {
        log("Status Code: ${response.statusCode} \n Status Message: ${response.statusMessage}");
        return [];  // Return an empty list or handle as needed
      }
    } on DioError catch (e) {
      log("Dio Error Message: $e");
      return [];  // Return an empty list or handle as needed
    } catch (e) {
      log("Generic Error: $e");
      return [];  // Return an empty list or handle as needed
    }
  }
}
