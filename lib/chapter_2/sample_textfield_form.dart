import 'package:flutter/material.dart';

class TextFieldAndFormRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextFieldAndFormRouteState();
  }
}

class _TextFieldAndFormRouteState extends State<TextFieldAndFormRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("输入框与表单"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFieldARoute(),
            FocusTestRoute(),
            FormTestRoute()
          ],
        ),
      ),
    );
  }
}

//TextField的基本使用
class TextFieldARoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextFieldARouteState();
  }
}

/// 获取输入内容或者监听文本变化有两种方式：
///
/// 1. 定义两个变量，用于保存用户名和密码，然后在onChange触发时，各自保存一下输入内容。
/// 2. 通过controller直接获取。
class _TextFieldARouteState extends State<TextFieldARoute> {
  TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      print(_userNameController.text);
    });
    //设置默认值
//    _userNameController.text = "quest";
//    //设置选中的内容
//    _userNameController.selection = TextSelection(
//        baseOffset: 2, extentOffset: _userNameController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: Column(
          children: <Widget>[
            //使用inputDecorationTheme，在获取到焦点时，labelText没有高亮显示的效果了
            Theme(
                data: Theme.of(context).copyWith(
                    //Theme中的hintColor无法设置下划线的颜色，只能指定hintText的颜色
                    hintColor: Colors.grey,
                    inputDecorationTheme: InputDecorationTheme(
                        //TextField的下划线颜色有多种属性来设置，
                        //this.errorBorder,
                        //    this.focusedBorder,
                        //    this.focusedErrorBorder,
                        //    this.disabledBorder,
                        //    this.enabledBorder,
                        //    this.border,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200])),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 14))),
                child: TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200])),
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person)),
                )),
            //不使用inputDecorationTheme，保留labelText高亮显示的效果
            Container(
              child: TextField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入登录密码",
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]))),
            )
          ],
        ));
  }
}

/// 焦点可以通过FocusNode和FocusScopeNode来控制，
/// 默认情况下，焦点由FocusScope来管理，它代表焦点控制范围，
/// 可以在这个范围内可以通过FocusScopeNode在输入框之间移动焦点、设置默认焦点等。
/// 我们可以通过FocusScope.of(context) 来获取Widget树中默认的FocusScopeNode。
class FocusTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FocusTestRouteState();
  }
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  var focusNode1 = FocusNode();
  var focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
    //监听焦点变化
    focusNode1.addListener(() => print(focusNode1.hasFocus));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText: "input 1"),
          ),
          TextField(
            focusNode: focusNode2,
            decoration: InputDecoration(labelText: "input 2"),
          ),
          Builder(builder: (context) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("移动焦点"),
                  onPressed: () {
                    //指定焦点的方式1：FocusScope.of(context).requestFocus(focusNode2);
                    //如下为指定焦点的方式2：
                    if (focusScopeNode == null) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(focusNode2);
                  },
                ),
                RaisedButton(
                  child: Text("隐藏键盘"),
                  onPressed: () {
                    // 当所有编辑框都失去焦点时键盘就会收起
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                )
              ],
            );
          })
        ],
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormTestRouteState();
  }
}

class _FormTestRouteState extends State<FormTestRoute> {
  var _userController = TextEditingController();
  var _pwdController = TextEditingController();
  GlobalKey _globalKey = GlobalKey<_FocusTestRouteState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      key: _globalKey,
      child: Column(
        children: <Widget>[
          TextFormField(
              controller: _userController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
              validator: (v) {
                return v.trim().length > 0 ? null : "用户名不能为空";
              }),
          TextFormField(
            controller: _pwdController,
            obscureText: true,
            decoration:
                InputDecoration(labelText: "密码", prefixIcon: Icon(Icons.lock)),
            validator: (v) {
              return v.trim().length > 5 ? null : "密码不能少于6位";
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 28),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                  onPressed: () {
                    //在这里不能通过此方式获取FormState，context不对
                    //print(Form.of(context));

                    // 通过_formKey.currentState 获取FormState后，
                    // 调用validate()方法校验用户名密码是否合法，校验
                    // 通过后再提交数据。
                    if ((_globalKey.currentState as FormState).validate()) {
                      //验证通过提交数据
                      print("提交登录数据");
                    }
                  },
                  child: Text("登录"),
                  padding: EdgeInsets.all(15),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
