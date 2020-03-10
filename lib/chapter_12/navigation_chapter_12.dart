import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_12/i10n/sample_intl.dart';
import 'package:flutter_learning/chapter_12/sample_localizations.dart';

// ignore: must_be_immutable
class NaviChapter12 extends StatelessWidget {
  var itemTitles = ["12.1 实现Localizations", "12.2 使用Intl包"];

  var itemWidgets = [LocalizationsTest(), IntlTest()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row and Column"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index < itemWidgets.length) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => itemWidgets[index]));
                } else {
                  //arguments为true是因为onGenerateRoute中的逻辑是根据bool值进行判断的
                  Navigator.pushNamed(context, itemTitles[index],
                      arguments: true);
                }
              },
              child: ListTile(
                title: Text(itemTitles[index]),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey);
          },
          itemCount: itemTitles.length),
    );
  }
}
