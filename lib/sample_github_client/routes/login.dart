import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_learning/sample_github_client/common/global.dart';
import 'package:flutter_learning/sample_github_client/common/net.dart';
import 'package:flutter_learning/sample_github_client/common/share.dart';
import 'package:flutter_learning/sample_github_client/i10n/github_localizations.dart';
import 'package:flutter_learning/sample_github_client/models/user_git_hub.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _userNameController.text = Global.profile.lastLogin;
    if (_userNameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GithubLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(gm.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userNameOrEmail,
                    prefixIcon: Icon(Icons.person),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : gm.userNameRequired;
                  }),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: gm.password,
                    hintText: gm.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : gm.passwordRequired;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text(gm.login),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      UserGitHub user;
      try {
        user = await GitHubApi(context)
            .login(_userNameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          log(GithubLocalizations.of(context).userNameOrPasswordWrong,
              name: 'GitHub');
          showToast(GithubLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          log('login failed: ${e.toString()}', name: 'GitHub');
          showToast(e.toString());
        }
      }
      if (user != null) {
        // 返回
        Navigator.of(context).pop();
      }
    }
  }

  void showToast(String content) {
    Toast.show(content, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
