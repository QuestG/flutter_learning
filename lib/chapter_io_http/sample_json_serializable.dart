import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_io_http/json_serializable/user.dart';

///通过命令生成json模版的存在的问题就是要为每一个json写模板。
class JsonSerializableRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String jsonTest = '{"name":"quest","email":"quest@workharder.com"}';

    User user = User.fromJson(json.decode(jsonTest));

    return Scaffold(
      appBar: AppBar(
        title: Text("Json序列化"),
      ),
      body: Center(
        child: Text("name: ${user.name}  email: ${user.email}"),
      ),
    );
  }
}
