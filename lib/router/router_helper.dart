import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'messages.dart';

class RouterHelper {
  static String routeHost = "/host";

  static void Function(String? route, Map<String, Object>? params)? openFlutterRoute;

  //注册消息通道
  static final _routerMessageChannel =
      BasicMessageChannel<String?>("flutter_hybrid_stack_message_channel", StringCodec());

  static registerApp() {
    //防止下面空异常
    WidgetsFlutterBinding.ensureInitialized();
    //注册消息监听
    _routerMessageChannel.setMessageHandler((String? message) async {
      if (message != null) {
        print("received message -> $message");
        var receivedMessage = ReceivedMessage.formJson(json.decode(message));
        // Get.toNamed(FlutterMapper.noAnimRoute("${messageBean.route}"),
        //     preventDuplicates: false);
        // Get.toNamed("${messageBean.route}", preventDuplicates: false);
        _openFlutterRoute(route: "${receivedMessage.route}", params: receivedMessage.params);
      }
    });
  }

  static sendInitFinishMessage() {
    print("发送初始化成功的消息");

    ///发送初始化成功的消息
    _routerMessageChannel.send("flutter_engine_init_finish");
  }

  static sendMessage(SendMessage bean) async {
    var result = await _routerMessageChannel.send(json.encode(bean.toJson()));
    print("操作结果返回 -> $result");
  }

  static _openFlutterRoute({required String? route, Map<String, Object>? params}) {
    openFlutterRoute?.call(route, params);
  }

  static openNative(
      {required String? route, HashMap<String, Object>? params}) {
    if (route == null) {
      print("route should not be null!");
    } else {
      var msgBean = SendMessage.routeNativeMsg(route, params);
      sendMessage(msgBean);
    }
  }
}
