import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_5/sample_custom_scroll_view.dart';
import 'package:flutter_learning/chapter_5/sample_gridview.dart';
import 'package:flutter_learning/chapter_5/sample_listview.dart';
import 'package:flutter_learning/chapter_5/sample_scroll_controller.dart';
import 'package:flutter_learning/chapter_5/sample_singelchildscrollview.dart';

class NaviChapter5 extends StatelessWidget {
  var itemTitles = [
    "5.1 SingleChildScrollView",
    "5.2 ListView",
    "5.3 GridView",
    "5.4 CustomScrollView",
    "5.5 滚动监听及控制",
  ];

  var itemWidgets = [
    SingleScrollViewTest(),
    ListViewTest(),
    GridViewTest(),
    CustomScrollViewTest(),
    ScrollControllerTest()
  ];

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
