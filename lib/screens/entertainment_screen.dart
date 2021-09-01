import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/loader.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/widgets/show_dialogue.dart';
import 'package:provider/provider.dart';

class EntertainmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Expanded(
      child: FutureBuilder(
        future: newsProvider.entertainmentNews.isEmpty
            ? newsProvider.getAndFetchNews('entertainment').catchError((error) => showCustomDialogue(context, error))
            : Future.value(true),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Loader()
                : Consumer<NewsProvider>(
                    builder: (context, newsItem, child) => Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: RefreshIndicator(
                        onRefresh: () =>
                            newsProvider.getAndFetchNews('entertainment').catchError((error) => showCustomDialogue(context, error)),
                        displacement: 2,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return NewsCard(
                              news: newsItem.entertainmentNews[index],
                            );
                          },
                          itemCount: newsItem.entertainmentNews.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
