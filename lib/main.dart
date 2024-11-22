import 'package:app2/homepages/clientdashboard/dashoptions.dart';
import 'package:app2/homepages/clientdashboard/firstoption.dart';
import 'package:app2/homepages/therapistdashboard/therapistdash.dart';
import 'package:app2/homepages/therapistdashboard/therapisthome.dart';
import 'package:app2/index.dart';
import 'package:app2/layout_body/layout_body.dart';
import 'package:app2/login/authprovider.dart';
import 'package:app2/login/login.dart';
import 'package:app2/questionaire/preferences.dart';
import 'package:app2/questionaire/questionaire.dart';
import 'package:app2/register/register.dart';
import 'package:app2/therapist/careers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(

    //HERE

    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Integrate(navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              name: 'home',
              path: '/',
              builder: (context, state) => const LayoutTemplate(),
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  buildPageWithoutAnimation(
                context: context,
                state: state,
                child: const LayoutTemplate(),
              ),
            ),
            GoRoute(
              name: 'Login',
              path: '/login',
              builder: (context, state) => const LoginUI(),
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  buildPageWithoutAnimation(
                context: context,
                state: state,
                child: const LoginUI(),
              ),
            ),
            GoRoute(
              name: 'Careers',
              path: '/careers',
              builder: (BuildContext context, GoRouterState state) => const CareersPage(),
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  buildPageWithoutAnimation(
                context: context,
                state: state,
                child: const CareersPage(),
              ),
            ),

            // GoRoute(
            // name: 'register',
            // path: '/register/:role',
            // builder:(context, state) {
            //   final role = state.pathParameters['role']!;
            //   return RegisterUI(role: role);
            // },
            // ),
          ]),
        ],
      ),
      //here
      GoRoute(
        name: 'register',
        path: '/register/:role',
        builder: (context, state) {
          final role = state.pathParameters['role']!;
          return RegisterUI(
            role: role,
          );
        },
      ),
      GoRoute(
        name: 'questionaire',
        path: '/questionaire',
        builder: (context, state) => const Questionaire(),
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithoutAnimation(
          context: context,
          state: state,
          child: const Questionaire(),
        ),
      ),
      GoRoute(
        name: 'preferences',
        path: '/preferences',
        builder: (context, state) => const PreferencesPage(),
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithoutAnimation(
          context: context,
          state: state,
          child: const PreferencesPage(),
        ),
      ),
      GoRoute(
        name: 'therapist',
        path: '/therapist',
        builder: (context, state) => const TherapistHomePage(),
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithoutAnimation(
          context: context,
          state: state,
          child: const TherapistDashboard(),
        ),
        redirect: (context, state) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          if (!authProvider.isAuthenticated ||
              authProvider.role != 'THERAPIST') {
            return '/login';
          }
          return null;
        },
      ),
      GoRoute(
        name: 'client',
        path: '/client',
        builder: (context, state) => const ClientDashboard(),
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithoutAnimation(
          context: context,
          state: state,
          child: const ClientDashboard(),
        ),
        redirect: (context, state) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          if (!authProvider.isAuthenticated || authProvider.role != 'CLIENT') {
            return '/login';
          }
          return null;
        },
      ),
    ]);

void main() {
  usePathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..loadToken(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );

    // const MaterialApp(
    //   color: Colors.white,
    //   debugShowCheckedModeBanner: false,
    //   home:
    //   Nothing(),
    //   //Homie(),
    //   //HomePage(),
    //   //Integrate(),
    //   //LoginUI()
    //   //RegisterUI(),
    //   //CalenderView(),
    //   //Responsivelogin(),
    // );
  }
}

// import "package:app2/buttons/buttons.dart";
// import "package:flutter/material.dart";
// import "package:go_router/go_router.dart";

// class LeftStuff extends StatelessWidget {
//   const LeftStuff({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//     padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
//     child: Row(
//             //mainAxisAlignment: MainAxisAlignment.center,
//             children: [

//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
//                   child: Buttons(btnName: "Register", colour: Colors.black, containWidth: 150, containHeight: 50, radius: 10, onPressed: () {
//                     GoRouter.of(context).go("/register");
//                     },),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   child: Buttons(btnName: "Contact Us", colour: Colors.grey, containWidth: 150, containHeight: 50, radius: 10, onPressed: () { },),
//                 ),

//                 ]
//           ),

//       );

//   }
// }

// navigatorKey: _rootNavigatorKey,
// initialLocation: '/',
// routes: <RouteBase>[
//   StatefulShellRoute.indexedStack(
//     builder: (context, state, navigationShell) {
//       return Integrate(navigationShell);
//     },
//     branches: [
//       StatefulShellBranch(
//         routes: [
//           GoRoute(
//             name: 'home',
//             path: '/',
//             builder: (context, state) => const LayoutTemplate(),
//           ),
//           GoRoute(
//             name: 'Login',
//             path: '/login',
//             builder: (context, state) => const LoginUI(),
//           ),
//           GoRoute(
//             name: 'Careers',
//             path: '/careers',
//             builder: (context, state) => const CareersPage(),
//             routes: [
//               GoRoute(
//                 name: 'register',
//                 path: 'register/:role',
//                 builder: (context, state) {
//                   final role = state.pathParameters['role']!;
//                   return RegisterUI(role: role);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   ),
//   GoRoute(
//     name: 'admin',
//     path: '/admin',
//     builder: (context, state) => const AdminHomePage(),
//     redirect: (context, state) {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       if (!authProvider.isAuthenticated || authProvider.role != 'ADMIN') {
//         return '/login';
//       }
//       return null;
//     },
//   ),
//   GoRoute(
//     name: 'client',
//     path: '/client',
//     builder: (context, state) => const ClientHomePage(),
//     redirect: (context, state) {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       if (!authProvider.isAuthenticated || authProvider.role != 'CLIENT') {
//         return '/login';
//       }
//       return null;
//     },
//   ),
// ],);

CustomTransitionPage<void> buildPageWithoutAnimation({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child);
}
