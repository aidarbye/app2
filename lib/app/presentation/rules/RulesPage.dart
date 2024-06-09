import 'package:flutter/material.dart';
import 'package:medimom/app/data/RuleViewData.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/rules/RuleInfoPage.dart';

class RulesPage extends StatefulWidget {

  const RulesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RulesPage();
  }
}

class _RulesPage extends State<RulesPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(249, 126, 134, 1),
        body: Container(
          color: const Color.fromRGBO(249, 126, 134, 1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 14),
                          child: const Text(
                            "Что можно что нельзя",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: _generateButtons(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _generateButtons() {
    List<Widget> results = [];
    for (int i = 0; i < 6; i += 2) {
      results.add(
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              _getButton(rules[i]),
              Container(width: 14),
              _getButton(rules[i + 1])
            ],
          ),
        )
      );
    }
    return results;
  }

  void _changePage(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Widget _getButton(RuleViewData rule) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _changePage(RuleInfoPage(rule: rule));
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(249, 126, 134, 0.3),
                    shape: BoxShape.circle
                ),
                child: Icon(
                  rule.icon,
                  color: const Color.fromRGBO(249, 126, 134, 1),
                  size: 40,
                ),
              ),
              Text(
                rule.title,
                style: const TextStyle(
                    color: Color.fromRGBO(249, 126, 134, 1),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final List<RuleViewData> rules = [
    RuleViewData(
        icon: Icons.home_filled,
        title: "Дом и работа",
        rules: [
          RuleInfo(
              type: 0,
              name: "Средства от комаров",
              info: "Согласно исследованиям Агентства охраны окружающей среды, большинство репеллентов (ДЭТА, пикаридин, IR3535 или масло лимонного эвкалипта) при правильном применении абсолютно безопасны. Это означает избегание попадания репеллента на слизистые, в ранки, на кожу лица, своевременное мытье рук, нанесение на одежду.\nНамного опаснее, считают ученые, заражение вирусом Зика, переносчиками которого являются комары. Хотя в странах центральной и восточной Европы отмечены единичные завозные случаи заражения, укусы комаров к тому же способны спровоцировать аллергию, сильный зуд, занесение инфекции в местах расчесов."
          ),
          RuleInfo(
              type: 1,
              name: "Поднятие тяжестей",
              info: "Нетяжелые вещи можно переносить (ноутбук, бутылка воды и т. д.) на любом сроке, как и брать на руки маленького ребенка, если он уже у вас есть. Национальный институт по охране труда в США рекомендует ограничить вес: до 20-й недели - допускается до 16,3 кг, во второй половине беременности - не более 11,7 кг. В любом случае в каждом конкретном случае это может быть другой вес: зависит от срока, физической формы женщины, высоты поднятия.\nЕсли работа связана с поднятием тяжестей, нормы для беременных зависят от законодательства страны: в России это вес не более 2,5 кг дважды в час, в США повышенным риском считается поднятие тяжестей чаще раза в 5 минут или нагибание более 20 р. в день."
          ),
          RuleInfo(
              type: 2,
              name: "Весь день на ногах",
              info: "Длительное пребывание на ногах для беременных чревато вероятностью преждевременных родов и снижением роста ребенка. Особенно это касается женщин, у которых уже существуют отклонения в здоровье: сердечно-сосудистые патологии, варикоз и другие болезни сосудов. Согласно информации Американского колледжа акушеров и гинекологов, беременным вредно находиться более 2 часов в стоячем положении во второй половине беременности. Если вы вынуждены работать стоя, обязательно двигайте ногами, переступайте и делайте небольшие перерывы, чтобы восстановить кровоток и снизить усталость."
          ),
          RuleInfo(
              type: 1,
              name: "Смартфоны",
              info: "Любое ЭМИ (электромагнитное излучение) обладает хотя бы минимальной дозой радиации. Хотя мы ежедневно облучаемся природными источниками (например, солнечный свет), в век технологий интенсивность фонового излучения возрастает - это работающие холодильники, подключенные стиральные машины, микроволновки, компьютеры. Смартфоны при включении также излучают микродозы, которые совсем не полезны будущему плоду.\nСогласно ряду исследований в нескольких странах (Дания, Нидерланды, Испания, Южная Корея), результатом такого воздействия могут стать гиперактивность и невнимательность ребенка."
          ),
          RuleInfo(
              type: 1,
              name: "Внимание",
              info: "Используемые в ксероксе и принтере вещества обладают высоким раздражающим эффектом при попадании на слизистые горла и носа. Поэтому при их работе не стоит находиться слишком близко, чаще проветривать помещение.\nХотя проверенных результатов о воздействии принтеров на беременных нет, в технике подобного плана широко распространено применение тонера, способного спровоцировать аллергическую реакцию. А это для беременных с их повышенной чувствительностью - прямой фактор риска сильного раздражения дыхательных путей, что чревато кашлем и чиханием."
          ),
        ]
    ),
    RuleViewData(
      icon: Icons.health_and_safety_outlined,
      title: "Здоровье",
      rules: [
        RuleInfo(
          type: 1,
          name: "Средства от кашля",
          info: "Если кашель простудный, следует лечить простуду, тогда кашель пройдет сам, ведь он является защитной реакцией организма. Для облегчения в первые дни рекомендуется использовать безобидные (леденцы) или народные (травы) средства в добавление к назначенному врачом лекарству.\nДоктор акушерства и гинекологии Робин Хорсагер-Борер рекомендует использовать при беременности безрецептурные средства с декстрометрофаном или гуафенезином.\nКодеин, который раньше использовался для лечения кашля, относится к опиоидам, поэтому его лучше исключить."
        ),
        RuleInfo(
          type: 1,
          name: "Средства от диареи",
          info: "Прием лекарств в этом случае зависит от степени расстройства. Рекомендации ACG\n(Американский университет гастоэнтерологии) допускают\nсамостоятельный прием безрецептурных препаратов при легкой диарее - например, Лоперамид. Проспективное исследование не выявило связи лечения этим препаратом в 1 триместре с аномалиями плода.\nПри более серьезной ситуации, когда расстройство сопровождается признаками отравления (температура, тошнота), и требуются более сильные лекарства, беременной следует обратиться к врачу."
        ),
        RuleInfo(
          type: 1,
          name: "Вакцинация",
          info: "Своевременная вакцинация защитит вас и вашего ребенка от ряда инфекций. Однако их стоит делать только после консультации с лечащим врачом. Современные препараты для вакцинации разработаны с учетом состояния беременной женщины и максимально безопасны.\nВо время беременности центр профилактики заболеваний США (CDC) рекомендует делать 2 прививки: от гриппа (инъекцию, а не живую) и от коклюша (оптимально между 27 и 36 неделей).\nУже будучи беременными, не стоит прививаться живой вакциной, от вирусов папилломы, кори, ветряной оспы, а также ряда т. н. туристических вакцин (брюшной тиф, желтая лихорадка, японский "
        ),
        RuleInfo(
          type: 2,
          name: "Антидепрессанты",
          info: "Согласно исследованию, проведенному в\nДании на протяжении 14 лет, самый большой % психических отклонений у детей наблюдался в группе, где матери продолжали прием лекарств (13,6%), и в группе, где женщины начали принимать антидепрессанты (14,5%).\nПри наличии у женщин депрессивных состояний во время беременности врач может порекомендовать альтернативные методы (акупунктура, психотерапевт и др.), снижающие медикаментозное воздействие на организм."
        ),
        RuleInfo(
          type: 1,
          name: "Антибиотики",
          info: "Как и любое лекарство во время беременности, антибиотики назначаются только лечащим врачом и только при превышении их пользы над возможным вредом в отсутствие лечения.Многие женщины во время беременности (до 67%) принимают антибиотики по рекомендации врача для лечения инфекций мочевыводящих путей. По данным медицинского журнала «Исследование врожденных дефектов» (США), повышенному риску врожденных дефектов у ребенка подвергаются женщины, принимавшие лекарства из группы цефалоспоринов, нитрофурантоин, триметоприм-сульфаметоксазол. Самым безобидным действием обладают антибиотики группы пенициллинов."
        ),
      ]
    ),
    RuleViewData(
      icon: Icons.bubble_chart,
      title: "Красота",
      rules: [
        RuleInfo(
          type: 2,
          name: "Тату",
          info: "Процедура может вызвать воспаление кожи даже у здорового человека, а беременные с их выросшей чувствительностью и сниженным иммунитетом подвергаются повышенной опасности. Вот только основные риски: до 6% делающих тату людей инфицируются и вынуждены принимать лекарства, передающиеся через кровь заболевания (СПИД, гепатит, инфекционный эндокардит), некачественные чернила с загрязнениями.Каждый из этих факторов - реальная угроза не только будущей мамочке, но и плоду.Акушерка Салли Уранг (медицинский консультативный совет BabyCenter)подтверждает, что потенциальные риски перевешивают необходимость нанесения тату- она вполне может подождать несколько месяцев"
        ),
        RuleInfo(
          type: 1,
          name: "Скрабы",
          info: "Наиболее безопасны домашние скрабы, сделанные своими руками: на основе морской соли, сахара, кофейной гущи, бусинок жожоба.Еще один обязательный компонент - ароматические масла (кроме масел базилика, орегано, тимьяна, обладающих спазмалитическим эффектом). Если вы хотите использовать готовые средства убедитесь, что в них нет вредных компонентов (советует медицинский ресурс Healthline): ретиноидов, гидрохинона, перекиси бензоила, формальдегида, хлорида алюминия, тетрациклина и др. Выполняйте все рекомендации по применению и обязательно проконсультируйтесь с врачом."
        ),
        RuleInfo(
          type: 2,
          name: "Пирсинг",
          info: "Организм беременной более уязвим для инфекций, поскольку ресурсы направлены и на создание новой жизни. Поэтому прокалывание любых частей тела нежелательно из-за снижения иммунитета и возможного заражения. При неблагоприятном развитии событий рана будет заживать долго, к тому же существует риск чрезмерной кровопотери, развития абсцесса, занесения опасных инфекций через кровь (гепатит).Акушер-гинеколог Андреа Чисхолм считает, что пирсинг может также нанести вред плоду. Некоторые исследования показывают, что материнская инфекция способна привести к осложнениям беременности, преждевременным родам, вызвать врожденные дефекты. Опасность происходит не только от болезни, но и от возможных аллергических реакций, медикаментов для лечения при инфицировании."
        ),
        RuleInfo(
          type: 2,
          name: "Отбеливание зубов",
          info: "Все отбеливающие средства для зубов, как профессиональные, так и для самостоятельного применения, содержат перекись водорода. Препарат будет находиться в ротовой полости некоторое время, что потенциально включает в себя всасывание через слизистую. Исследований по степени риска для беременных не проводилось, однако врачи советуют не повышать опасные факторы, которых в этот период и так хватает. Безопасным, считают медики, является использование отбеливающей зубной пасты или натуральных средств: ананас, кокосовое масло, пищевая сода, сырые овощи. А вот ополаскиватель для рта из-за содержания алкоголя также лучше исключить из своего «рациона»."
        ),
        RuleInfo(
          type: 0,
          name: "Массаж",
          info: "Для большинства беременных массаж - метод альтернативной медицины, помогающий облегчить состояние при депрессии, радикулите, болях в спине, сильных тошноте и рвоте. Массажные техники, по заявлению доктора медицины Гейл Пеззулло-Бургс (акушер-гинеколог), позволяют снизить прием медикаментов и даже сократить продолжительность родов в среднем на 3 часа. Однако, как и любая медицинская процедура, массаж при беременности должен проводиться хорошим специалистом.Осторожности требуют состояния: утренние недомогания, изжога, варикоз, боль в пояснице, гестационный диабет, отеки.Полностью процедура противопоказана беременным женщинам с осложнениями. тромбоз глубоких вен, проблемы с плацентой, преэклампсия."
       )
      ]
    ),
    RuleViewData(
      icon: Icons.apple,
      title: "Питание",
      rules: [
        RuleInfo(
          type: 0,
          name: "Шоколад",
          info: "Умеренное потребление шоколада, хотя он содержит кофеин и сахар, приветствуется и полезно как ребенку, так и матери. Плитка темного шоколада в 45 г содержит примерно 30 мг кофеина, а молочного - 11 мг. При этом ACOG (Американский колледж акушеров и гинекологов) рекомендует при беременности не превышать ежедневное употребление кофеина в количестве 200 мг. Если вы захотите побаловать себя шоколадкой, обязательно учтите содержащийся в ней сахар и кофеин при составлении дневного рациона."
        ),
        RuleInfo(
          type: 1,
          name: "Фастфуд",
          info: "Фастфуд содержит много соли, сахара, насыщенных жиров, консервантов и добавок. Его никак нельзя отнести к здоровой пище, поэтому при беременности он допускается только как экстренный перекус в редких случаях. При этом обязательно убедитесь в свежести и достаточной тепловой обработке всех входящих в него продуктов. Вашему ребенку требуется полноценное и здоровое питание для нормального развития, что он может получить только при правильно организованном и сбалансированном рационе."
        ),
        RuleInfo(
          type: 0,
          name: "Мёд",
          info: "Если у вас нет аллергии на мед, то его можно принимать до 6 ч. л. в день (рекомендации Американской кардиологической ассоциации), заменив им сахар. Это более здоровый продукт с содержанием антиоксидантов, витаминов, ферментов. Хотя некоторая часть меда перед продажей пастеризуется, в «сыром» виде, по мнению пчеловодов, он более полезен. Просто найдите надежного поставщика этого продукта - и будьте здоровы."
        ),
        RuleInfo(
          type: 1,
          name: "Заменитель сахара",
          info: "Заменители целесообразно использовать тем, кто в этом нуждается: женщинам с сахарным диабетом, гестационным диабетом, инсулинорезистентным. Даже самые безопасные подсластители (в т. ч. натуральные) рекомендуется принимать в ограниченных количествах, поскольку их действие на беременных и плод изучено недостаточно. В любом случае получите консультацию у своего врача и диетолога."
         ),
        RuleInfo(
          type: 0,
          name: "Сырое мясо/рыба",
          info: "Сырые или недоваренные мясо, рыба, морепродукты, яйца несут в себе опасность заражения паразитами или микробами. Пищу в таком виде не рекомендуется употреблять не только беременным, но и всем остальным. Для беременных опасность вдвойне, поскольку инфекции могут передаться через кровь плоду, а при лечении в кровь будут поступать продукты распада медикаментов.В то же время ACOG напоминает о важности присутствия в рационе вышеупомянутых продуктов, но с надлежащей тепловой обработкой."
        )
      ]
    ),
    RuleViewData(
      icon: Icons.airplanemode_active_rounded,
      title: "Путешествия",
      rules: [
        RuleInfo(
          type: 1,
          name: "Подъем в горы",
          info: "Если во время беременности вы чувствуете себя хорошо, то сам по себе подъем в горы не представляет опасности, помимо интенсивной физической нагрузки. Одно из исследований, проводившихся среди женщин, часто путешествующих и тренировавшихся во время беременности на больших высотах, не выявило серьезных осложнений.Однако разные женщины реагируют по-разному на большие высоты, поэтому возможен риск гипоксии на большой высоте и «высотная болезнь». Но главная опасность - отсутствие медицинской помощи. Поэтому перед подъемом беспристрастно оцените свое состояние и, если надо, проконсультируйтесь с врачом."
        ),
        RuleInfo(
          type: 0,
          name: "Ремень безопасности",
          info: "Главное - правильно пристегнуться: поясной опустить ниже живота (ни в коем случае не выше), а плечевой поместить между грудями. Рекомендации ACOG: женщина получит максимальную защиту при дополнительном использовании подушки безопасности, но только при условии правильно размещенных ремней."
        ),
        RuleInfo(
          type: 2,
          name: "Поездки в страны третьего мира",
          info: "Чаще всего это страны Юго-Восточной Азии, Экваториальной Африки, Центральной и Южной Америки. Все они характеризуются жарким климатом, который при беременности грозит гипертермией. Есть и другие риски: заражение паразитами и опасными инфекциями, необходимость делать прививки, низкий уровень медицины.Если вы решили поехать отдыхать, самое безопасное время - 2 триместр. Из стран следует отдавать предпочтение Южной Европе, России, Турции, ОАЭ."
        ),
        RuleInfo(
          type: 1,
          name: "Автомобиль",
          info: "Некоторые исследования приводят данные о возможном повышенном риске аварийной ситуации на дороге при вождении беременными, однако прямых противопоказаний нет. Доктор медицинских наук из Нью Йорка Кейси Гэйтер утверждает, что беременным можно садиться за руль при соблюдении нескольких правил: иметь под рукой прохладную воду во избежание обезвоживания, каждые 2 часа делать перерывы и выходить из машины для разминки, правильно пристегиваться."
        ),
        RuleInfo(
          type: 1,
          name: "Поезд",
          info: "Путешествовать на поезде безопасно до 37 недели - времени, когда потенциально могут случиться роды. При наличии осложненной беременности даже до этого срока поездка должна быть одобрена вашим врачом.Вот несколько рекомендаций от экспертов BabyCenter по безопасному путешествию на поезде: придите к посадке пораньше (некоторые поезда останавливаются на 2 мин.), избегайте толпы, пристегивайте сумки во время походов в туалет, имейте при себе основные лекарства и медицинские записи, держитесь во время движения, выбирайте удобную обувь и оставайтесь на связи."
        ),
      ],
    ),
    RuleViewData(
      icon: Icons.sports_gymnastics,
      title: "Фитнес",
      rules: [
        RuleInfo(
          type: 2,
          name: "Теннис",
          info: "Статистика и научные исследования подтверждают: у мам-теннисисток более высокий уровень плотности костей, что гарантирует такие же показатели и будущим младенцам. Многие теннисистки продолжают заниматься этим видом спорта вплоть до 3-го триместра.Однако тем, кто не занимался теннисом раньше, постоянные нагрузки с прыжками и резкой сменой положения могут не пойти на пользу. Особенно если раньше были выкидыши или вы долго не могли забеременеть. В этом случае лучше выбрать более безопасные виды спорта (бег, ходьба, плаванье, аэробика).Любые физические нагрузки планируйте вместе с врачом, соблюдайте рекомендации по безопасности, будьте осторожны в любой ситуации - и ваша беременность пройдет благополучно."
        ),
        RuleInfo(
          type: 1,
          name: "Танцы",
          info:"Танцевальные упражнения - это своеобразная физическая нагрузка, только под музыку, что может сделать тренировку приятной. Однако следует избегать прыжков и скачков, резких поворотов и смены положений, подпрыгиваний. Прислушивайтесь к своему телу, не допускайте перенапряжения или перегрева, и наращивайте продолжительность занятий постепенно. Танцами не рекомендуется заниматься при болезнях сердца или легких, угрозе преждевременных родов, проблемах с плацентой или шейкой матки, тяжелой анемии. В любом случае посоветуйтесь с лечащим врачом."
        ),
        RuleInfo(
          type: 1,
          name: "Пробежки",
          info: "По мнению большинства специалистов в области акушерства и гинекологии, беременные могут бегать на любом сроке беременности и на любые расстояния. При этом им не стоит забывать об осторожности: носить удобную обувь, выбирать ровные дорожки, не доводить себя до изнеможения, сосредоточиться исключительно на технике, а не на скорости. И, конечно, прислушиваться к своему организму, избегая дискомфорта. Все рекомендации относятся к физически здоровым женщинам без осложнений беременности."
        ),
        RuleInfo(
          type: 1,
          name: "Растяжка",
          info: "Растяжка при правильном и ежедневном выполнении помогает снять боль в спине и пояснице, сделать мышцы более пластичными и оставаться физически активным, а по некоторым исследованиям - помогает снизитьАД. Доктор Джеймс Гринберг из Бостона рекомендует вначале проконсультироваться с врачом, подобрать упражнения (лучше с тренером) и соблюдать осторожность. Меры безопасности при выполнении растяжки: разогревать мышцы заранее, не подпрыгивать, избегать перенапряжения. Если вы не уверены в безопасности упражнений, запишитесь к инструктору по пренатальной йоге или просто побеседуйте с ним."
        ),
        RuleInfo(
          type: 0,
          name: "Велотренажер",
          info: "Езда на велотренажере - еще один из самых приветствуемых врачами видов спорта. Такие упражнения, считает акушер-Бриттани Роблес, принесут пользу вам и вашему ребенку, помогая поддерживать хорошую физическую форму. Однако перенапряжение, как всегда, нежелательно. Кроме этого, вы должны оставаться хорошо гидратированной и избегать перегрева. Как и при других видах тренировок, в случае отсутствия опыта начинайте с минимального времени - 5-10 мин., постепенно наращивая продолжительность до 30 мин."
        ),
      ]
    )
  ];

}