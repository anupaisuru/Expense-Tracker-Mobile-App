import 'package:flutter/material.dart';

import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/constants/colors.dart';

class IncomeExpenseCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imgUrl;
  final Color bgColor;
  const IncomeExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imgUrl,
    required this.bgColor,
  });

  @override
  State<IncomeExpenseCard> createState() => _IncomeExpenseCardState();
}

class _IncomeExpenseCardState extends State<IncomeExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefalutPadding),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Image.asset(widget.imgUrl, width: 70)),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 17,
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$ ${widget.amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20,
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
