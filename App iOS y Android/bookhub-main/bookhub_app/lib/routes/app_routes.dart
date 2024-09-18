// import 'dart:js';

import 'package:bookhub_app/presentation/inicio_page/inicio_page.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/detalle_libro_screen/detalle_libro_screen.dart';
import '../presentation/inicio_container_screen/inicio_container_screen.dart';
import '../presentation/vender_libro_screen/vender_libro_screen.dart';
import 'package:bookhub_app/presentation/user_screen_page/user_screen_page.dart';

class AppRoutes {
  static const String inicioContainerScreen = '/inicio_container_screen';

  static const String inicioPage = '/inicio_page';

  static const String detalleLibroScreen = '/detalle_libro_screen';

  static const String venderLibroScreen = '/vender_libro_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String usuarioScreen = '/user_screen_page';



  static Map<String, WidgetBuilder> routes = {
    inicioContainerScreen: (context) => InicioContainerScreen(),
    venderLibroScreen: (context) => VenderLibroScreen(onBookAdded: (Book ) {  },),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => InicioContainerScreen(),
    usuarioScreen: (context) => UserScreen(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detalleLibroScreen:
        final args = settings.arguments as Book;
        return MaterialPageRoute(builder: (context) => DetalleLibroScreen(book: args));
    //...
      default:
        return null;
    }
  }

}
