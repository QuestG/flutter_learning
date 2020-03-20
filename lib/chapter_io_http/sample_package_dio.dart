import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DioTestState();
  }
}

class _DioTestState extends State<DioTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Dio"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: DioInstance()
                .dio
                .get("https://api.github.com/orgs/flutterchina/repos"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                if (snapshot.hasError) {
                  return Text(snapshot.error);
                }

                return ListView(
                  children: response.data.map<Widget>((e) {
                    return ListTile(title: Text(e["full_name"]));
                  }).toList(),
                );
              }

              return CircularProgressIndicator();
            }),
      ),
    );
  }

  @override
  void dispose() {
    DioInstance().dio.close();
    super.dispose();
  }
}

//单例形式的Dio
class DioInstance {
  static DioInstance _instance = DioInstance._();

  DioInstance._() {
    _dio = Dio();
  }

  static DioInstance _sharedInstance() {
    return _instance;
  }

  factory DioInstance() => _sharedInstance();

  Dio _dio;

  Dio get dio => _dio;
}
