import 'package:cgen/constants/app_colors.dart';
import 'package:cgen/cores/utils/app_info.dart';
import 'package:cgen/cores/utils/size_config.dart';
import 'package:cgen/feature/home/binding/home_binding.dart';
import 'package:cgen/flavors/env.dart';
import 'package:cgen/routes/route_pages.dart';
import 'package:cgen/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_framework/responsive_framework.dart';

var getKey = Get.key;
ApiClient myApiClient = ApiClient();
late AppInfo appInfo;

var env = ENV.STAG;
bool debug = true;
bool showAlice = true;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CGen',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          error: AppColors.red,
          onError: AppColors.red,
          background: AppColors.background,
          onBackground: AppColors.black,
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      navigatorKey: Get.key,
      getPages: RoutePages.pages,
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      locale: Locale("id"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'),
      ],
      builder: (context, widget) {
        SizeConfig().init(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(
                SizeConfig.screenWidth,
                scaleFactor: 1,
              ),
            ],
            background: Container(
              color: AppColors.background,
            ),
          ),
        );
      },
    );
  }
}
