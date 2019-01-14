import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/newsItem.dart';

class ViewPage extends StatelessWidget {
  // The model to view
  final NewsItem newsItem;
  ThemeData _appTheme;

  ViewPage({this.newsItem});

  @override
  Widget build(BuildContext context) {
    // cache the app theme to avoid fetching it everytime
    _appTheme = Theme.of(context);

    return Scaffold(
      // wrap in SingleChildScrollView to handle long contents and scrolling
      body: SingleChildScrollView(
        child: Column(
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
      ),
      // used to open the news item in the web browser
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: () {
          launch(newsItem.url);
        },
        tooltip: 'Open in Browser',
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: '${newsItem.imageUrl}',
      child: CachedNetworkImage(
        height: 300,
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
          style: _appTheme.textTheme.headline,
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
          Icon(Icons.web, size: 16),
          SizedBox(width: 2),
          Text(newsItem.source),
          // seperator
          SizedBox(width: 16),
          // seperator
          Icon(Icons.account_circle, size: 16),
          SizedBox(width: 2),
          Text(newsItem.author ?? newsItem.source),
        ],
      ),
      // seperator
      SizedBox(height: 16),
      // seperator
      Text(
        // some items don't have content (API fault?!)
        newsItem.content ?? 'NO CONTENT AVAILABLE',
        // using a bigger font for readability
        style: _appTheme.textTheme.body1.copyWith(fontSize: 16),
      )
    ];
  }
}
