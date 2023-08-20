import 'dart:ui';

import 'package:edna/globals/myColors.dart';
import 'package:edna/globals/myFonts.dart';
import 'package:flutter/material.dart';

class BudgetRange extends StatefulWidget {
  void Function(String text) setBudgetRange;

  BudgetRange({super.key, required this.setBudgetRange});

  @override
  State<BudgetRange> createState() => _BudgetRangeState();
}
enum BudgetRanges { lowest, lowMid, midHigh, highest }

class _BudgetRangeState extends State<BudgetRange> {

  BudgetRanges? _budgetRange = BudgetRanges.lowest;


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Change Budget Range",
                style: MyFonts.serifHeading,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 24,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListTile(
                  title: Text('Lowest', style: MyFonts.radioText,),
                  leading: Radio<BudgetRanges>(
                    value: BudgetRanges.lowest,
                    groupValue: _budgetRange,
                    onChanged: (BudgetRanges? value) {
                      setState(() {
                        _budgetRange = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListTile(
                  title: Text('Low - Mid Range', style: MyFonts.radioText,),
                  leading: Radio<BudgetRanges>(
                    value: BudgetRanges.lowMid,
                    groupValue: _budgetRange,
                    onChanged: (BudgetRanges? value) {
                      setState(() {
                        _budgetRange = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListTile(
                  title: Text('Mid - High Range', style: MyFonts.radioText,),
                  leading: Radio<BudgetRanges>(
                    value: BudgetRanges.midHigh,
                    groupValue: _budgetRange,
                    onChanged: (BudgetRanges? value) {
                      setState(() {
                        _budgetRange = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListTile(
                  title: Text('Highest', style: MyFonts.radioText,),
                  leading: Radio<BudgetRanges>(
                    value: BudgetRanges.highest,
                    groupValue: _budgetRange,
                    onChanged: (BudgetRanges? value) {
                      setState(() {
                        _budgetRange = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24,)
            ],
          ),
          InkWell(
            onTap: () {
              if(_budgetRange == BudgetRanges.lowest) {
                widget.setBudgetRange("Lowest");
              } else if(_budgetRange == BudgetRanges.lowMid) {
                widget.setBudgetRange("Low - Mid Range");
              } else if(_budgetRange == BudgetRanges.midHigh) {
                widget.setBudgetRange("Mid - High Range");
              } else if(_budgetRange == BudgetRanges.highest) {
                widget.setBudgetRange("Highest");
              }
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.green10,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Apply changes",
                    style: TextStyle(
                      fontFamily: 'General Sans',
                      fontSize: 16,
                      fontVariations: [
                        FontVariation("wght", 500),
                      ],
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 24,
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
