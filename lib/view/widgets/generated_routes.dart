import 'package:elok_lagi_restaurant/view/authenticate/signinup.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_list.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_order.dart';
import 'package:elok_lagi_restaurant/view/screen/order/decline/decline_order.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    MaterialPageRoute route;

    switch (settings.name) {
      case '/AcceptList':
        return MaterialPageRoute(builder: (_) => AcceptList());
        break;
      case '/AcceptOrder':
        if (args is Map) {
          route =
              MaterialPageRoute(builder: (_) => AcceptOrder(aid: args['aid']));
        }
        return route;
        break;
      case '/DeclineOrder':
        if (args is Map) {
          route =
              MaterialPageRoute(builder: (_) => DeclineOrder(did: args['did']));
        }
        return route;
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('No such route')),
          body: Center(
            child: Container(
                child: Text(
                    'No such route is available. Please return to previous page')),
          ));
    });
  }
}
