import 'package:flutter/material.dart';
import 'package:expansion_widget/expansion_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> image = [
    'https://media.formula1.com/image/upload/t_16by9North/f_auto/q_auto/v1706626658/fom-website/2023/Miscellaneous/GettyImages-1656999898.jpg',
    'https://www.reuters.com/resizer/v2/IBHAY7HSKBJW5PWLS3RQHBCCXE.jpg?auth=f13efb04a4a52b38a4415455f31ef93727c5d0a2eeca2b3dcf134b3b9044214d&width=1920',
    'https://imgsrv.crunchyroll.com/cdn-cgi/image/fit=contain,format=auto,quality=85,width=1200,height=675/catalog/crunchyroll/6b17182a3518d7406f0e69687f773f4f.jpg',
    'https://i.ytimg.com/vi/FN93WoPDJS0/maxresdefault.jpg',
    'https://gagadget.com/media/post_big/Pss7zC2NTf9it64A6rmEs-1200-80.jpg'
  ];

  List<String> newsName = [
    'Lando Norris finally win',
    'Man City buy a new goalkeeper',
    'Kimetsu no Yaiba new seson',
    'Legendary group',
    'New Pixel'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('First Try'),
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return newsCard(image[index], newsName[index], 'BBC', context);
            }));
  }
}

Widget newsCard(String img, String newsName, String newspaper,  BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    clipBehavior: Clip.antiAlias,
    color: Colors.white,
    child: ExpansionWidget.autoSaveState(
        initiallyExpanded: false,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
            onTap: () => toogleFunction(animated: true),
            child: Column(children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.black54,
                          Colors.black.withOpacity(0)
                        ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                    child: Ink.image(
                      image: NetworkImage(img),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      left: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newspaper,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                          Text(
                            newsName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24),
                          )
                        ],
                      ))
                ],
              ),
            ]),
          );
        },
        content: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: const Text('Description'),
        )),
  );
}
