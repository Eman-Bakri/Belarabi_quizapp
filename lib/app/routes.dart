import 'package:go_router/go_router.dart';
import 'package:quiz_app_with_eman/ui/screens/quiz_screen.dart';

import '../ui/screens/home_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/profile_screen.dart';
import '../ui/screens/splash_screen.dart';

class PageName {
  static const homeRoute = "/home";
  static const splashRoute = "/splash";
  static const introSliderRoute = "/introSlider";
  static const profileRoute = "/profile";
  static const quizRoute = "quiz";
}

class Routes {
  final GoRouter _router = GoRouter(
    initialLocation: PageName.splashRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: PageName.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
          path: PageName.homeRoute,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
                path: "quiz",
                builder: (context, state) {
                  Map<String, String?> args =
                      state.extra as Map<String, String?>;
                  return QuizScreen(
                    language: args["language"],
                    category: args["category"],
                    subCategory: args["subcatgeory"],
                    level: args["level"],
                  );
                }
                // builder: (context, state) => QuizScreen(
                //   language: state.pathParameters['language'],
                //   category: state.pathParameters['category'],
                //   subCategory: state.pathParameters['subcatgeory'],
                //   level: state.pathParameters['level'],
                // ),
                )
          ]),
      GoRoute(
        path: PageName.introSliderRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: PageName.profileRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );

  GoRouter get getRouter => _router;
}












// import 'dart:developer';

// import 'package:flutter/cupertino.dart';

// import '../ui/screens/splashScreen.dart';

// class Routes {
//   static const splash = "splash";

//   static String currentRoute = splash;

//   static Route onGenrateRouted(RouteSettings routeSettings) {
//     currentRoute = routeSettings.name ?? "";

//     log(name: "Current Route", currentRoute);

//     switch (routeSettings.name) {
//       case splash:
//         return CupertinoPageRoute(builder: (_) => SplashScreen());
//       default:
//         return CupertinoPageRoute(builder: (_) => SplashScreen());
//     }
//   }
// }
