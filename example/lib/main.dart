import 'package:flutter/material.dart';
import 'package:flutter_hybrid_stack/router/router_helper.dart';
import 'package:flutter_hybrid_stack/router/route_navigator_observer.dart';
import 'package:flutter_hybrid_stack_example/widget/detail_widget.dart';
import 'package:flutter_hybrid_stack_example/widget/home_widget.dart';
import 'package:flutter_hybrid_stack_example/widget/router_mapper.dart';

import 'package:get/get.dart';


void main() {
  var getApp = GetMaterialApp(
    initialRoute: FlutterMapper.ROUTER_HOST,
    getPages: [
      GetPage(
          name: FlutterMapper.ROUTER_HOST,
          page: () => HostWidget(),
          transition: Transition.noTransition),
      GetPage(
          name: FlutterMapper.ROUTER_HOME_NO_ANIM,
          page: () => HomeWidget(),
          transition: Transition.noTransition),
      GetPage(
          name: FlutterMapper.ROUTER_HOME,
          page: () => HomeWidget(),
          transition: Transition.rightToLeft),
      GetPage(
          name: FlutterMapper.ROUTER_DETAIL_NO_ANIM,
          page: () => DetailWidget(),
          transition: Transition.noTransition),
      GetPage(
          name: FlutterMapper.ROUTER_DETAIL,
          page: () => DetailWidget(),
          transition: Transition.rightToLeft),
    ],
    navigatorObservers: [RouteNavigatorObserver()],

  );
  RouterHelper.routeHost = FlutterMapper.ROUTER_HOST;
  RouterHelper.openFlutterRoute = (route, params) {
    Get.toNamed(route ?? "", preventDuplicates: false);
  };
  RouterHelper.registerApp();
  runApp(getApp);
}

class HostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
