import 'package:boxed_project/helper/preference_helper.dart';
import 'package:boxed_project/providers/app/app_pro.dart';
import 'package:boxed_project/providers/auth/auth_pro.dart';
import 'package:boxed_project/providers/reserve/reserve_pro.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefHelper.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _routes = RouteName();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppPro>(
          create: (_) => AppPro(),
        ),
        ChangeNotifierProvider<AuthPro>(
          create: (_) => AuthPro(),
        ),
        ChangeNotifierProvider<ReservePro>(
          create: (_) => ReservePro(),
        ),
        // ChangeNotifierProvider<GlobalPro>(
        //   create: (_) => GlobalPro(),
        // ),
        // ChangeNotifierProvider<ServicePro>(
        //   create: (_) => ServicePro(),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Boxed Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Palette.themecolor,
          ),
          fontFamily: Constants.appFontFamily,
          useMaterial3: true,
        ),
        routerConfig: _routes.myrouter,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: double.infinity,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: TABLET),
            const ResponsiveBreakpoint.autoScale(double.infinity,
                name: DESKTOP),
          ],
        ),
      ),
    );
  }
}
