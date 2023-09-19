import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitegastos/carousel/carousel_data.dart';
import 'package:sitegastos/pages/main_page.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final List<CarouselData> items = [
    CarouselData(
        icon: Icons.attach_money,
        text:
            'Criei uma lista e adicione o seus gastos para ter um gerenciamento mais fácil'),
    CarouselData(
        icon: Icons.auto_graph_outlined,
        text:
            ' Com a opção de criar metas a sua vida fica mais fácil na hora de realizar um sonho '),
    CarouselData(
        icon: Icons.mobile_friendly, text: 'Facilidade na palma da sua mão'),
  ];

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    _checkFirstSeen();
    super.initState();
  }

  void _checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.8,
                aspectRatio: 16 / 9,
                initialPage: 0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                enableInfiniteScroll: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(microseconds: 800),
                autoPlayCurve: Curves.bounceIn,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: items.map((item) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.deepPurple.shade100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 120.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        item.text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jura(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DotsIndicator(
              dotsCount: items.length,
              position: _currentIndex.toInt(),
              decorator: DotsDecorator(
                activeColor: Colors.deepPurple,
                color: Colors.deepPurple.shade100,
                size: Size(10, 10),
                activeSize: Size(20, 10),
                spacing: EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: Text(
                'Começar',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
