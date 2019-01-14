import 'package:flutter/material.dart';
import '../../models/newsItem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../view.dart';

class NewsItemCard extends StatelessWidget {
  final NewsItem newsItem;
  ThemeData _appTheme;

  NewsItemCard({this.newsItem});

  @override
  Widget build(BuildContext context) {
    // cache the theme data to avoid fetching it multiple times
    _appTheme = Theme.of(context);

    return Card(
      // wrap contents in InkWell to provide ripples and tap event
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildImage(),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildContents(),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewPage(newsItem: newsItem)),
          );
        },
        splashColor: Colors.deepOrange,
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: '${newsItem.imageUrl}',
      child: CachedNetworkImage(
        height: 150,
        fit: BoxFit.cover,
        imageUrl: newsItem.imageUrl,
        placeholder: new Center(
          child: new Container(
            padding: EdgeInsets.all(16),
            child: new CircularProgressIndicator(),
          ),
        ),
        errorWidget: new Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: new Icon(
              Icons.error,
              color: Colors.red,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContents() {
    return <Widget>[
      Hero(
        tag: newsItem.title,
        child: Text(
          newsItem.title,
          style: _appTheme.textTheme.title,
        ),
      ),
      // seperator
      SizedBox(height: 8),
      // seperator
      Text(
        newsItem.publishedAt,
        style: _appTheme.textTheme.caption,
      ),
      // seperator
      SizedBox(height: 8),
      // seperator
      Row(
        children: <Widget>[
          Icon(
            Icons.web,
            size: 16,
          ),
          SizedBox(width: 2),
          Text(newsItem.source),
          // seperator
          SizedBox(width: 16),
          // seperator
          Icon(
            Icons.account_circle,
            size: 16,
          ),
          SizedBox(width: 2),
          Text(newsItem.author ?? newsItem.source),
        ],
      ),
    ];
  }
}
