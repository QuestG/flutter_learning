// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "title": MessageLookupByLibrary.simpleMessage("模拟GitHub"),
        "home": MessageLookupByLibrary.simpleMessage("主页"),
        "login": MessageLookupByLibrary.simpleMessage("登录"),
        "noDescription": MessageLookupByLibrary.simpleMessage("没有描述信息"),
        "theme": MessageLookupByLibrary.simpleMessage("主题"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "logout": MessageLookupByLibrary.simpleMessage("登出"),
        "logoutTip": MessageLookupByLibrary.simpleMessage("登出提示"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "yes": MessageLookupByLibrary.simpleMessage("确认"),
        "userName": MessageLookupByLibrary.simpleMessage("用户名"),
        "userNameOrEmail": MessageLookupByLibrary.simpleMessage("用户名或邮箱"),
        "userNameRequired": MessageLookupByLibrary.simpleMessage("需要用户名"),
        "password": MessageLookupByLibrary.simpleMessage("密码"),
        "passwordRequired": MessageLookupByLibrary.simpleMessage("需要密码"),
        "userNameOrPasswordWrong":
            MessageLookupByLibrary.simpleMessage("用户名或密码错误"),
        "auto": MessageLookupByLibrary.simpleMessage("跟随系统")
      };
}
