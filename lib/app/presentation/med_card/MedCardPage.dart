import 'package:flutter/material.dart';
import 'package:medimom/app/presentation/check_lists/check_list.dart';
import 'package:medimom/app/presentation/document/document_page.dart';
import 'package:medimom/app/presentation/orders/orders_page.dart';
import 'package:medimom/app/presentation/pack/ConstValue.dart';
import 'package:medimom/app/presentation/pack/HeaderText.dart';
import 'package:medimom/app/presentation/pack/SimpleText.dart';
import 'package:medimom/app/presentation/personal_data/personal_data_page.dart';

class MedCardPage extends StatefulWidget {
  const MedCardPage({super.key});
  @override
  State<StatefulWidget> createState() => _MedCardPage();
}

class _MedCardPage extends State<MedCardPage> {
  _changePage(widget) => Navigator.push(context,MaterialPageRoute(builder: (_) => widget));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ConstValue.leftMarginS, right: ConstValue.rightMarginS, top: ConstValue.topMargin),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          const HeaderText(
            text: "Медкарта",
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: InkWell(
              onTap: () {
                _changePage(const PersonalDataPage());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 126, 134, 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SimpleText(text: "Личные данные", color: Colors.black, size: 14),
                      SimpleText(text: "Учет", color: Colors.black.withOpacity(0.6), size: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: InkWell(
              onTap: () {
                _changePage(const OrdersPage());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 126, 134, 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(
                      Icons.calendar_view_day_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SimpleText(text: "Приемы", color: Colors.black, size: 14),
                      SimpleText(text: "Запланированные и завершенные приемы", color: Colors.black.withOpacity(0.6), size: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 13),
          //   child: InkWell(
          //     onTap: () {
          //       _changePage(const DocumentPage(isAnalyze: true));
          //     },
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           margin: const EdgeInsets.only(right: 10),
          //           width: 25,
          //           height: 25,
          //           padding: const EdgeInsets.all(5),
          //           decoration: BoxDecoration(
          //               color: const Color.fromRGBO(249, 126, 134, 1),
          //               borderRadius: BorderRadius.circular(5)
          //           ),
          //           child: Image.asset(
          //             "assets/images/injection.png",
          //             width: 18,
          //             height: 18,
          //           ),
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const SimpleText(text: "Анализы", color: Colors.black, size: 14),
          //             SimpleText(text: "Результаты ваших анализов", color: Colors.black.withOpacity(0.6), size: 12),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(top: 13),
          //   child: InkWell(
          //     onTap: () {
          //       _changePage(const DocumentPage(isAnalyze: false));
          //     },
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           margin: const EdgeInsets.only(right: 10),
          //           padding: const EdgeInsets.all(5),
          //           width: 25,
          //           height: 25,
          //           decoration: BoxDecoration(
          //               color: const Color.fromRGBO(249, 126, 134, 1),
          //               borderRadius: BorderRadius.circular(5)
          //           ),
          //           child: Image.asset(
          //             "assets/images/recipe.png",
          //             width: 18,
          //             height: 18,
          //           ),
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const SimpleText(text: "Рецепты", color: Colors.black, size: 14),
          //             SimpleText(text: "Рецепты которые вам прописал ваш доктор", color: Colors.black.withOpacity(0.6), size: 12),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 13),
            child: InkWell(
              onTap: () {
                _changePage(const CheckList());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(5),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 126, 134, 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Image.asset(
                      "assets/images/recipe.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SimpleText(text: "Чек лист", color: Colors.black, size: 14),
                      SimpleText(text: "Чек листы в которых происходит отметка событий", color: Colors.black.withOpacity(0.6), size: 12),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

