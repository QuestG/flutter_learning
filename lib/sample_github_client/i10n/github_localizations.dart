import 'package:flutter/material.dart';
import 'package:flutter_learning/sample_github_client/i10n/arb/messages_all.dart';
import 'package:intl/intl.dart';

class GithubLocalizations {
  static Future<GithubLocalizations> load(Locale locale) {
    var name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    var localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((v) {
      Intl.defaultLocale = localeName;
      return GithubLocalizations();
    });
  }

  static GithubLocalizations of(BuildContext context) {
    return Localizations.of<GithubLocalizations>(context, GithubLocalizations);
  }

  String get title {
    return Intl.message('SimulateGitHub',
        name: 'title', desc: 'Title for Simulating GitHub');
  }

  String get home {
    return Intl.message('home', name: 'home', desc: 'Home');
  }

  String get login {
    return Intl.message('login', name: 'login', desc: 'login github');
  }

  String get noDescription {
    return Intl.message("noDescription",
        name: "noDescription", desc: "No Description");
  }

  String get theme {
    return Intl.message("theme", name: "theme", desc: "app theme");
  }

  String get language {
    return Intl.message("language", name: "language", desc: "app language");
  }

  String get logout {
    return Intl.message("logout", name: "logout", desc: "app logout");
  }

  String get logoutTip {
    return Intl.message("logoutTip", name: "logoutTip", desc: "app logoutTip");
  }

  String get cancel {
    return Intl.message("cancel", name: "cancel", desc: "cancel");
  }

  String get yes {
    return Intl.message("yes", name: "yes", desc: "yes");
  }

  String get userName {
    return Intl.message("userName", name: "userName", desc: "userName");
  }

  String get userNameOrEmail {
    return Intl.message("userNameOrEmail",
        name: "userNameOrEmail", desc: "userNameOrEmail");
  }

  String get userNameRequired {
    return Intl.message("userNameRequired",
        name: "userNameRequired", desc: "userNameRequired");
  }

  String get password {
    return Intl.message("password", name: "password", desc: "password");
  }

  String get passwordRequired {
    return Intl.message("passwordRequired",
        name: "passwordRequired", desc: "passwordRequired");
  }

  String get userNameOrPasswordWrong {
    return Intl.message("userNameOrPasswordWrong",
        name: "userNameOrPasswordWrong", desc: "userNameOrPasswordWrong");
  }

  String get auto {
    return Intl.message("auto", name: "auto", desc: "auto");
  }
}

class GithubLocalizationsDelegate
    extends LocalizationsDelegate<GithubLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GithubLocalizations> load(Locale locale) {
    return GithubLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<GithubLocalizations> old) {
    return true;
  }
}
