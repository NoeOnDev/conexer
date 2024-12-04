import 'package:flutter/material.dart';
import '../../widgets/news_card.dart';
import '../../widgets/view_template.dart';
import '../../services/news_service.dart';
import '../../models/news_response.dart';

class NewsScreen extends StatefulWidget {
  final String token;
  final NewsService newsService;

  const NewsScreen({
    super.key,
    required this.token,
    required this.newsService,
  });

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsResponse>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = widget.newsService.getLocalityNews(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Noticias',
      scaffoldType: ScaffoldType.citizen,
      content: FutureBuilder<List<NewsResponse>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            if (errorMessage.contains('No news found')) {
              return const Center(
                child: Text('No se encontraron noticias para su localidad.'),
              );
            } else {
              return Center(child: Text('Error: $errorMessage'));
            }
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron noticias.'));
          } else {
            final newsList = snapshot.data!;
            return Column(
              children: newsList.map((news) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: NewsCard(
                    title: news.title,
                    locality: news.locality,
                    description: news.description,
                    date: news.createdAt,
                    image: Image.asset(
                      'assets/img/img_news.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
