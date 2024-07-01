import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'article_detail_screen.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('News App'),
      ),
      body: FutureBuilder(
        future: newsProvider.fetchArticles(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                final article = newsProvider.articles[index];
                return ListTile(
                  leading: !article.urlToImage.isEmpty
                      ? Image.network(article.urlToImage, fit: BoxFit.cover, width: 100, height: 100)
                      : const CircularProgressIndicator(),
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
