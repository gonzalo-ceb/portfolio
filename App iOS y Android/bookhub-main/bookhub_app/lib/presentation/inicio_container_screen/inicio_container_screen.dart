import 'package:bookhub_app/presentation/user_screen_page/user_screen_page.dart';
import 'package:bookhub_app/presentation/vender_libro_screen/vender_libro_screen.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../inicio_page/inicio_page.dart';

// ignore_for_file: must_be_immutable
class InicioContainerScreen extends StatelessWidget {
  InicioContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.inicioPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: _buildBottombar(context),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottombar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Icbaselinehome:
        return AppRoutes.inicioPage;
      case BottomBarEnum.Botnvender:
        return AppRoutes.venderLibroScreen;
      // case BottomBarEnum.Iconparksolidmessage:
      //   return "/";
      case BottomBarEnum.Solaruserbold:
        return AppRoutes.usuarioScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.inicioPage:
        return InicioPage();
      case AppRoutes.venderLibroScreen:
        return VenderLibroScreen(onBookAdded: (Book ) {  },);
      case AppRoutes.usuarioScreen:
        return UserScreen();
      default:
        return DefaultWidget();
    }
  }
}
