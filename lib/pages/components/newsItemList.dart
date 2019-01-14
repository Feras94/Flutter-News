import 'package:flutter/material.dart';
import '../../models/newsItem.dart';
import './newsItemCard.dart';

class NewsItemList extends StatelessWidget {
  final List<NewsItem> newsItems;

  NewsItemList({this.newsItems});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // we do a + 1 to show the legal attribution text
      itemCount: newsItems.length + 1,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, itemIndex) {
        if (itemIndex == newsItems.length) {
          // show legal text for the last item
          return Center(
            child: Text(
              'Powered by NewsAPI.org',
              style: Theme.of(context).textTheme.caption,
            ),
          );
        }

        // build up news cards for items
        return NewsItemCard(
          newsItem: newsItems[itemIndex],
        );
      },
      // we're just adding spaces between items for now
      separatorBuilder: (context, itemIndex) {
        return SizedBox(height: 4);
      },
    );
  }
}
