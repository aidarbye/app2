import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';

class CalendarPage extends StatefulWidget {
  final int? index;
  const CalendarPage({super.key,this.index});
  @override
  State<StatefulWidget> createState() {
    return _CalendarPage();
  }
}

class _CalendarPage extends State<CalendarPage> {
  late int currentTabIndex = widget.index ?? 0;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: ConstValue.topMargin, left: ConstValue.leftMarginS, right: ConstValue.rightMargin, bottom: 20),
                height: 40,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 30,
                      height: 30,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: HeaderText(
                          text: "Календарь"
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  initialIndex: widget.index ?? 0,
                  length: 37, 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[                      
                      TabBar(
                        
                        tabAlignment: TabAlignment.start,
                        splashFactory: NoSplash.splashFactory,
                        isScrollable: true,
                        enableFeedback: false,
                  
                        padding: EdgeInsets.zero,
                  
                        labelStyle: const TextStyle(
                          color:Color(0xffF97E86),
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),

                        unselectedLabelStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                        ),
                  
                        indicator: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.white,
                            width: 0,
                          )
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: const EdgeInsets.only(bottom: 7),
                        physics: const AlwaysScrollableScrollPhysics(),
                        onTap: (value) => setState(() => currentTabIndex = value),
                        tabs: List.generate(37, (index) => Container(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 16,bottom: 20),
                          child: 
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text(
                                "${index + 1}",
                                ),
                                const Text(
                                "неделя",
                                ),
                             ],
                           ) ,
                        ))
                      ),
                      const Expanded(
                        child: TabBarView(
                          viewportFraction: 1,
                          physics: AlwaysScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          children: [
                            LookAFruct(
                              color: Colors.red,
                              assetPath: "assets/images/4w.png",
                              title: "Размер вашего малышка как зернышко мака",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/5w.png",
                              title: "Размер вашего малышка как кунжутное зернышко",
                            ),
                            LookAFruct(
                              color: Colors.brown,
                              assetPath: "assets/images/6w.png",
                              title: "Размер вашего малышка как одна чечевица",
                            ),
                            LookAFruct(
                              color: Colors.purple,
                              assetPath: "assets/images/7w.png",
                              title: "Размер вашего малышка как ягода",
                            ),
                            LookAFruct(
                              color: Colors.brown,
                              assetPath: "assets/images/8w.png",
                              title: "Размер вашего малышка как боб",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/9w.png",
                              title: "Размер вашего малышка как виноград",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/10w.png",
                              title: "Размер вашего малышка как кумкват",
                            ),
                            LookAFruct(
                              color: Colors.purple,
                              assetPath: "assets/images/11w.png",
                              title: "Размер вашего малышка как грейпфруктик",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/12w.png",
                              title: "Размер вашего малышка как лайм",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/13w.png",
                              title: "Размер вашего малышка как горошина",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/14w.png",
                              title: "Размер вашего малышка как лимон",
                            ),
                            LookAFruct(
                              color: Colors.pink,
                              assetPath: "assets/images/15w.png",
                              title: "Размер вашего малышка как яблоко",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/16w.png",
                              title: "Размер вашего малышка как авокадо",
                            ),
                            LookAFruct(
                              color: Colors.purple,
                              assetPath: "assets/images/17w.png",
                              title: "Размер вашего малышка как чеснок",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/18w.png",
                              title: "Размер вашего малышка как перец",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/19w.png",
                              title: "Размер вашего малышка как томат",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/20w.png",
                              title: "Размер вашего малышка как банан",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/21w.png",
                              title: "Размер вашего малышка как морковь",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/22w.png",
                              title: "Размер вашего малышка как спагетти сквиш",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/23w.png",
                              title: "Размер вашего малышка как манго",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/24w.png",
                              title: "Размер вашего малышка как кукуруза",
                            ),
                            LookAFruct(
                              color: Colors.pink,
                              assetPath: "assets/images/25w.png",
                              title: "Размер вашего малышка как свекла",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/26w.png",
                              title: "Размер вашего малышка как сельдерей",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/27w.png",
                              title: "Размер вашего малышка как хлопок",
                            ),
                            LookAFruct(
                              color: Colors.purple,
                              assetPath: "assets/images/28w.png",
                              title: "Размер вашего малышка как баклажан",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/29w.png",
                              title: "Размер вашего малышка как тыква",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/30w.png",
                              title: "Размер вашего малышка как капуста",
                            ),
                            LookAFruct(
                              color: Colors.grey,
                              assetPath: "assets/images/31w.png",
                              title: "Размер вашего малышка как кокос",
                            ),
                            LookAFruct(
                              color: Colors.brown,
                              assetPath: "assets/images/32w.png",
                              title: "Размер вашего малышка как картошка",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/33w.png",
                              title: "Размер вашего малышка как ананас",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/34w.png",
                              title: "Размер вашего малышка как дыня",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/35w.png",
                              title: "Размер вашего малышка как большая тыква",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/36w.png",
                              title: "Размер вашего малышка как салат",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/37w.png",
                              title: "Размер вашего малышка как чард",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/38w.png",
                              title: "Размер вашего малышка как лук порей",
                            ),
                            LookAFruct(
                              color: Colors.green,
                              assetPath: "assets/images/39w.png",
                              title: "Размер вашего малышка как арбуз",
                            ),
                            LookAFruct(
                              color: Colors.orange,
                              assetPath: "assets/images/40w.png",
                              title: "Размер вашего малышка как очень большая тыква",
                            ),
                          ]
                        ),
                      ),
                    ],   
                  )  
                )
              )
            ],
          ),
        ),
    );
  }
}

class LookAFruct extends StatelessWidget {
  final Color color;
  final String assetPath;
  final String title;
  const LookAFruct({
    super.key,
    required this.color,
    required this.assetPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.width * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: RadialGradient(
            colors: [
              color.withOpacity(1.0),
              color..withOpacity(1.0),
              color..withOpacity(0.2),
            ],
            stops: const [0.1, 1.6, 0.3],
            center: Alignment.center,
            radius: 1.0,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Center(
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.fitWidth,
                  scale: 2.4,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 30,
              right: 30,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.5,
                  fontFamily: "Rubik",
                  color: Colors.white
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}