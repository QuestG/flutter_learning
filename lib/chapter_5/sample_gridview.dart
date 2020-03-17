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
              //横轴子元素的数量
              crossAxisCount: 3,
              //子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
              //子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的。
              //注意，这里的子元素指的是子组件的最大显示空间，注意确保子组件的实际大小不要超出子元素的空间。
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
              //maxCrossAxisExtent为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的。
              //举个例子，如果ViewPort的横轴长度是450，那么当maxCrossAxisExtent的值在区间[450/4，450/3)内的话，子元素最终实际长度都为112.5。
              //意思就是120 * 3 < 450 < 120 * 4,所以最终子元素的个数确定为4个，子元素的长度为450/4.0，为112.5
              maxCrossAxisExtent: 120,
              //宽高比，childAspectRatio所指的子元素横轴和主轴的长度比为最终的长度比。
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
          //GridView.count、GridView.extent都只适合子Widget较少的情况，其他情况还是需要GridView.Builder动态创建。
          //另外，pub上有一个包“flutter_staggered_grid_view” ，它实现了一个交错GridView的布局模型。
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
