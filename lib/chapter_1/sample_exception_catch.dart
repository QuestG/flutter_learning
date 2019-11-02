import 'package:flutter/material.dart';

/// dart单线程模型
///
/// java和Object-C是多线程模型的编程语言，任意一个线程触发异常且该异常未被捕获时，就会导致整个进程退出。
/// 但dart和javascript不会，因为它们都是单线程模型。
///
/// Dart 在单线程中是以消息循环机制来运行的，其中包含两个任务队列，一个是“微任务队列” microtask queue，另一个叫做“事件队列” event queue。
/// 查看Dart运行原理图可以发现，微任务队列的执行优先级高于事件队列。
///
/// 现在来介绍一下Dart线程运行过程，请查看Dart运行原理图，入口函数 main() 执行完后，消息循环机制便启动了。
/// 首先会按照先进先出的顺序逐个执行微任务队列中的任务，当所有微任务队列执行完后便开始执行事件队列中的任务，事件任务执行完毕后再去执行微任务，如此循环往复，生生不息。
///
/// 在Dart中，所有的外部事件任务都在事件队列中，如IO、计时器、点击、以及绘制事件等，而微任务通常来源于Dart内部，
/// 并且微任务非常少，之所以如此，是因为微任务队列优先级高，如果微任务太多，执行时间总和就越久，事件队列任务的延迟也就越久，
/// 对于GUI应用来说最直观的表现就是比较卡，所以必须得保证微任务队列不会太长。值得注意的是，我们可以通过Future.microtask(…)方法向微任务队列插入一个任务。
///
/// 在事件循环中，当某个任务发生异常并没有被捕获时，程序并不会退出，而直接导致的结果是当前任务的后续代码就不会被执行了，也就是说一个任务中的异常是不会影响其它任务执行的。
///
/// 在发生异常时，Flutter默认的处理方式是弹一个ErrorWidget，分析_debugReportException代码后得到，error最终处理是FlutterError的onError。
/// 所以，如果需要自定义上报异常，只需提供一个错误处理回调即可。
///
/// 异常收集的几种方式：
/// 1. try/catch
/// 2. 对于async异常，使用Future api，catchError
/// 3. runZoned 此为Dart语言的功能
/// 4. FlutterError.onError
/// 5. Isolate.current.addErrorListener
///
///
class ErrorCatchRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catch Error"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("上报异常"),
          onPressed: () {},
        ),
      ),
    );
  }
}
