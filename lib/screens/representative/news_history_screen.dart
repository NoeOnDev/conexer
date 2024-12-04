import 'package:flutter/material.dart';
import '../../widgets/news_card.dart';
import '../../widgets/view_template.dart';
import '../../services/news_service.dart';
import '../../models/news_response.dart';

class NewsHistoryScreen extends StatefulWidget {
  final String token;
  final NewsService newsService;

  const NewsHistoryScreen({
    super.key,
    required this.token,
    required this.newsService,
  });

  @override
  NewsHistoryScreenState createState() => NewsHistoryScreenState();
}

class NewsHistoryScreenState extends State<NewsHistoryScreen> {
  late Future<List<NewsResponse>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = widget.newsService.getUserNews(widget.token);
  }

  void _createNews(BuildContext context) {
    Navigator.pushNamed(context, '/create-news');
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Historial de Noticias',
      scaffoldType: ScaffoldType.representative,
      content: FutureBuilder<List<NewsResponse>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            if (errorMessage.contains('No news found')) {
              return const Center(
                child: Text('Aún no ha creado ninguna noticia.'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNews(context),
        backgroundColor: const Color(0x8077A1DD),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
