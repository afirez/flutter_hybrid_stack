import 'package:flutter/material.dart';
import 'package:flutter_hybrid_stack/router/messages.dart';
import 'package:flutter_hybrid_stack/router/router_helper.dart';

class RouteNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var currentRoute = route.settings.name;

    ///如果HostWidget加载成功，则告知Native FlutterEngine初始化成功
    if (currentRoute == RouterHelper.routeHost) {
      RouterHelper.sendInitFinishMessage();
    }
    ///与native同步入栈情况
    else {
      _sendMessage(0, route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    /// 与native同步出栈情况
    _sendMessage(1, route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    ///与native同步栈被replace
    _sendMessage(2, newRoute, oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    /// 暂时没用到
    print("告知Native当前出栈的信息");
  }

  void _sendMessage(
      int type, Route<dynamic>? route, Route<dynamic>? previousRoute) {
    String? currentRoute = route?.settings.name;
    String? preRoute = previousRoute?.settings.name;

    if (currentRoute == null) {
      throw Exception("入栈的路由为空？这应该是不可能的");
    }
    var sendMsg =
    SendMessage.flutterRouteChangeMsg(type, currentRoute, preRoute);

    RouterHelper.sendMessage(sendMsg);
  }
}