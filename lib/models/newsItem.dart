class NewsItem {
  final String source;
  final String imageUrl;
  final String title;
  final String description;
  final String content;
  final String url;
  final String publishedAt;
  final String author;

  NewsItem({this.source, this.imageUrl, this.title, this.description, this.content, this.url, this.publishedAt, this.author});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      source: json['source']['name'],
      imageUrl: json['urlToImage'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      author: json['author'],
    );
  }
}
