import 'package:flutter/material.dart';

class MediMomTabBadges extends StatelessWidget {

  final int amount;

  const MediMomTabBadges({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    if (amount == 0) {
      return const SizedBox(width: 0, height: 0);
    }
    var amountText = amount < 0 ? "" : (amount > 99 ? "99+" : amount.toString());
    var numberLength = amountText.toString().length;
    return amount > 0 ? Container(
      margin: const EdgeInsets.only(top: 26, right: 3),
      alignment: Alignment.center,
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle
      ),
      child: Text(
        amountText,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontSize: numberLength < 2 ? 10 : (numberLength > 2 ? 7 : 8),
            fontWeight: FontWeight.w600
        ),
      ),
    ) : Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(top: 14, right: 10),
      decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle
      ),
    );
  }
}