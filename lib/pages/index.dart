import 'package:flutter/material.dart';
import './components/drawer.dart';
import '../api/api.dart';
import '../models/newsItem.dart';
import './components/newsItemList.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Future<List<NewsItem>> newsItemsFuture;

  @override
  void initState() {
    super.initState();
    newsItemsFuture = AppApi.instance.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest World News'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder<List<NewsItem>>(
          future: newsItemsFuture,
          builder: (context, snapshot) {
            // if we are finished we either have the data ready or an error occured
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return NewsItemList(
                  newsItems: snapshot.data,
                );
              } else if (snapshot.hasError) {
                return _buildErrorView(snapshot.error);
              }
            }

            // By default, show a loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorView(error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              size: 64,
              color: Colors.grey,
            ),
            // seperator
            SizedBox(height: 8),
            // seperator
            Text(
              'Failed to fetch the lastest news for you',
              style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey),
            ),
            // seperator
            SizedBox(height: 16),
            // seperator
            RaisedButton(
              child: Text(
                'Retry',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepOrange,
              onPressed: () {
                _handleRefresh();
              },
            ),
            // seperator
            SizedBox(height: 16),
            // seperator
            Text(
              "$error",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    // refresh the news future and return null to hide the refresh indicator
    setState(() {
      newsItemsFuture = AppApi.instance.fetchNews();
    });
    return Future.value(null);
  }
}
