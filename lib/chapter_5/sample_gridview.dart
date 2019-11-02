import 'package:flutter/material.dart';

class GridViewTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridViewTestState();
  }
}

class _GridViewTestState extends State<GridViewTest> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.green,
            //GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，
            //通过它可以快速的创建横轴固定数量子元素的GridView
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 3,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          Container(
            color: Colors.red,
            //GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent，
            //通过它可以快速的创建纵轴子元素为固定最大长度的的GridView
            child: GridView.extent(
              shrinkWrap: true,
              maxCrossAxisExtent: 120,
              //宽高比
              childAspectRatio: 2,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                  ),
                  itemCount: _icons.length,
                  itemBuilder: (context, index) {
                    if (index == _icons.length - 1 && _icons.length < 20) {
                      _retrieveIcons();
                    }
                    return Icon(_icons[index]);
                  }))
        ],
      ),
    );
  }
}
