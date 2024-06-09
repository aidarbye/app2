import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class OpinionPage extends StatefulWidget {

  const OpinionPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OpinionPage();
  }
}

class _OpinionPage extends State<OpinionPage> with TickerProviderStateMixin {
  late final tabC = TabController(
    length: 3, 
    vsync: this,initialIndex: 1,
  );
  @override
  void dispose() {
    tabC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Советы"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: ListView(
            children: [
              IntrinsicHeight(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[    
                      const SizedBox(height: 8,),
                      const Text(
                        "Важные статьи этой недели",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: TabBarView(
                          controller: tabC,
                          viewportFraction: 0.7,
                          physics: const AlwaysScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          children: [
                            ImageSover(
                              title: "Полезная еда при беременности, что можно, что не стоит и чем лучше пренебречь",
                              assetPath: "assets/images/firstt.png",
                              color: Colors.green,
                              controller: tabC,
                              index: 0,
                            ),
                            ImageSover(
                              title: "О беременности и как она проходит",
                              assetPath: "assets/images/second.png",
                              color: Colors.orange,
                              controller: tabC,
                              index: 1,
                            ),
                            ImageSover(
                              title: "Важные обследования при беременности и как они проходят",
                              assetPath: "assets/images/thirdd.png",
                              color: Colors.blue,
                              controller: tabC,
                              index: 2,
                            ),
                          ]
                        ),
                      ),
                    ],   
                  )  
                )
              ),

              const SizedBox(height: 60),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:(context) {
                        return const SoverPage2();
                      },
                    )
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 50,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 400,
                    child: Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/womanvom.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 190,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "6 способов справиться с тошнотой",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: Text(
                                    'Вместо выражения “утренний токсикоз”, наводящего на ошибочный вывод, что тошнота возникает только по утрам, следует помнить, что она может возникать в любое время суток. Некоторые простые способы справиться с тошнотой включают употребление небольших порций пищи, избегание жирных и острых блюд, регулярное питье воды, отдых и избегание резких запахов.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            )
                          )
                        ),
                        Positioned(
                          top: 170,
                          left: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xffF97E86),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: const SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Icons.feed,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}

class SoverPage2 extends StatelessWidget {
  const SoverPage2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вместо выражения “утренний токсикоз”, наводящего на ошибочный вывод, что тошнота возникает только по утрам, следует помнить, что она может возникать в любое время суток. Некоторые простые способы справиться с тошнотой включают употребление небольших порций пищи, избегание жирных и острых блюд, регулярное питье воды, отдых и избегание резких запахов.'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: const [Text(
          "Вместо выражения “утренний токсикоз”, наводящего на ошибочный вывод, что тошнота возникает только по утрам, следует помнить, что она может возникать в любое время суток. Некоторые простые способы справиться с тошнотой включают употребление небольших порций пищи, избегание жирных и острых блюд, регулярное питье воды, отдых и избегание резких запахов. Также полезно включать в рацион продукты, богатые витамином B6, такие как бананы, авокадо и орехи. Если тошнота становится сильной или постоянной, важно обратиться к врачу для получения профессиональной помощи.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400
          ),
        ),]
      ),
    );
  }
}

class ImageSover extends StatelessWidget {
  final String title;
  final TabController controller;
  final String assetPath;
  final int index;
  final Color color;
  
  const ImageSover({
    super.key,
    required this.title,
    required this.controller,
    required this.assetPath,
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:(context) {
              return SovetPage(
                index: index,
                title: title,
                assetPath: assetPath,
              );
            },
          )
        );
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double scale = 1.0;
          if (controller.index == index) {
              scale = 1.1;
            } else if (controller.previousIndex == index) {
              scale = 0.9;
          } 
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color
          ),
          child: Stack(
            children: [
              Image.asset(
                assetPath,
              ),
              Positioned(
                bottom: 10,              
                left: 0,
                right: 0,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SovetPage extends StatelessWidget {
  final int index;
  final String title;
  final String assetPath;

  const SovetPage({
    super.key,
    required this.index,
    required this.title,
    required this.assetPath,
  });

  static const List<String> text = [
    """Беременность — важный период, когда питание играет ключевую роль в здоровье матери и ребенка. Полезная еда включает фрукты, овощи, цельные зерна, белковые продукты и молочные продукты. Они обеспечивают необходимые витамины, минералы и питательные вещества.
Не стоит употреблять сырые или недоваренные продукты, такие как сырое мясо и яйца, а также непастеризованные молочные продукты. Также лучше избегать чрезмерного потребления кофеина и сладостей.
Пренебречь стоит фастфудом, газированными напитками и продуктами с высоким содержанием добавленных сахаров и жиров. Эти продукты могут привести к ненужному увеличению веса и недостатку необходимых питательных веществ.
""",
    """Беременность — это удивительный и важный этап в жизни женщины, состоящий из трех триместров. В каждом из них происходят значительные изменения в организме будущей матери и развитие плода.

Первый триместр — это время значительных гормональных изменений и раннего развития плода. Во втором триместре многие женщины начинают чувствовать себя лучше, а живот начинает расти. Третий триместр готовит женщину к родам, и плод активно развивается.

Каждая беременность уникальна и может сопровождаться разными симптомами и ощущениями. Важно внимательно следить за своим здоровьем, посещать врача и следовать его рекомендациям.""",
    """Важные обследования при беременности помогают следить за здоровьем матери и развитием плода. Они включают анализы крови, ультразвуковые исследования и специальные скрининги.

На ранних сроках беременности проводятся анализы крови для определения уровня гормонов, группы крови и наличия инфекций. Ультразвуковые исследования помогают оценить развитие плода и исключить аномалии.

Во втором триместре проводится пренатальный скрининг для оценки риска генетических заболеваний. На поздних сроках беременности может потребоваться допплерометрия и кардиотокография для оценки состояния плода.""",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Image.asset(assetPath),
          const SizedBox(height: 20,),

          Text(
            text[index],
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}