import 'package:flutter/material.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:first_try/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> news = [];

  @override
  void initState() {
    fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('First Try'),
        ),
        body: ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            return newsCard(news[index].urlToImage, news[index].title,
                news[index].name, news[index].description);
          },
        ));
  }

  Future<void> fetchPost() async {
    final uri = Uri.parse(
        "https://newsapi.org/v2/everything?q=gta&apiKey=461e498b5e1e43e4849b6e6d358c3da3");
    final response = await http.get(uri);
    var jdata = jsonDecode(response.body);
    if (jdata['status'] == 'ok') {
      jdata['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Post nws = Post(
            urlToImage: element["urlToImage"],
            title: element["title"],
            name: element['source']["name"],
            description: element["description"],
          );
          setState(() {
            news.add(nws);
          });
        }
      });
    }
  }
}

Widget newsCard(img, title, newspaper, desc) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    clipBehavior: Clip.antiAlias,
    color: Colors.white,
    child: ExpansionWidget.autoSaveState(
      initiallyExpanded: false,
      titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
        return InkWell(
          splashColor: Colors.white12,
          onTap: () => toogleFunction(animated: true),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center)),
                    child: Ink.image(
                      image: NetworkImage(img),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newspaper,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14),
                        ),
                        Text(
                          title,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
      content: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        child: Text(desc),
      ),
    ),
  );
}
