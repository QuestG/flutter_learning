import 'package:flutter/material.dart';

class ScaffoldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaffoldRouteState();
  }
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  TabController _tabController;
  List tabs = ["Android", "Flutter", "Kotlin"];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Standard Mateial App"),
        //Widget位于AppBar右边
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {})
        ],
        //leading为null，实现默认的leading按钮，否则进行替换
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(Icons.dashboard),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        //生成tab菜单，Tab有三个可选参数，分别为文本、图标和自定义Widget。TabBar只能生成一个静态的菜单。并没有生成Tab页
        bottom: TabBar(
          tabs: tabs
              .map((tab) => Tab(
                    text: tab,
                  ))
              .toList(),
          controller: _tabController,
        ),
      ),

      ///drawer和endDrawer分别接受一个Widget来作为页面的左、右抽屉菜单。
//      drawer: SecondDrawer(),
      drawer: MyDrawer(),
//      bottomNavigationBar: sampleBottomNavigationBarItem(),
      bottomNavigationBar: BottomAppBarTest(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      //TabBarView可以实现Tab页，同时可以配合TabBar实现同步切换和滑动状态同步。通过TabController监听Tab菜单的切换来切换Tab页。
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                e,
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            );
          }).toList()),
    );
  }

  ///使用BottomNavigationBarItem实现图片和文字结合的效果
  BottomNavigationBar sampleBottomNavigationBarItem() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            icon: Icon(Icons.business), title: Text("Business")),
        BottomNavigationBarItem(icon: Icon(Icons.school), title: Text("School"))
      ],
      currentIndex: _selectedIndex,
      fixedColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

//通过Scaffold的bottomNavigationBar属性来设置底部导航
//BottomAppBar 组件，它可以和FloatingActionButton配合实现这种“打洞”效果
class BottomAppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      //底部导航栏打一个圆形的洞
      shape: CircularNotchedRectangle(),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: null,
          ),
          SizedBox(), //中间位置空出
          IconButton(
            icon: Icon(Icons.business),
            onPressed: null,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
      ),
    );
  }
}

///另一种形式的抽屉菜单
class SecondDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///DrawerHelper主要用来显示用户账号信息
          DrawerHeader(
            child: buildPadding(),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          //此处需要注意，ListView需要用Expanded包裹，否则Drawer会显示失败，原因暂未知。
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text("add account"),
                leading: Icon(Icons.add),
              ),
              ListTile(
                title: Text("manage accounts"),
                leading: Icon(Icons.settings),
              ),
            ],
          ))
        ],
      ),
    );
  }

  ///构建一个普通的Widget
  Padding buildPadding() {
    return Padding(
      padding: EdgeInsets.only(top: 28),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ClipOval(
              child: Image.asset(
                "assets/ic_avatar.png",
                width: 60,
              ),
            ),
          ),
          Text(
            "Quest",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

///使用MediaQuery.removePadding，但目前我还不熟悉它的源码。
class RemovePaddingSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ClipOval(
                child: Image.asset(
                  "assets/ic_avatar.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Text(
              "Quest",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
