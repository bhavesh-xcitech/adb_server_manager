import 'package:adb_server_manager/features/backend_details/backend_details_screen.dart';
import 'package:adb_server_manager/features/home.dart';
import 'package:adb_server_manager/features/login/log_in_screen.dart';
import 'package:adb_server_manager/features/server_list/backends_list_screen.dart';
import 'package:adb_server_manager/features/splash_screen/splash_screen.dart';
import 'package:adb_server_manager/routers/error_screen.dart';
import 'package:adb_server_manager/routers/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: AppRouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      // GoRoute(
      //   name: AppRouteNames.chargingDetailsRouteName,
      //   path: AppRouteNames.chargingDetailsRouteName,
      //   pageBuilder: (context, state) => MaterialPage(
      //     key: state.pageKey,
      //     child: ChargingDetailsScreenNew(
      //       data: (state.extra as Map)['data'],
      //     ),
      //   ),
      // ),
      GoRoute(
        name: AppRouteNames.splash,
        path: AppRouteNames.splash,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.home,
        path: AppRouteNames.home,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      //  GoRoute(
      //   name: AppRouteNames.serverLogs,
      //   path: AppRouteNames.serverLogs,
      //   pageBuilder: (context, state) => MaterialPage(
      //     key: state.pageKey,
      //     child:  ServersLogsScreen(),
      //   ),
      // ),
      GoRoute(
        name: AppRouteNames.serverListing,
        path: AppRouteNames.serverListing,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const BackendsListingScreen(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.backendDetails,
        path: AppRouteNames.backendDetails,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: BackendDetails(
            serverName: (state.extra as Map).containsKey('name')
                ? ((state.extra as Map)['name'] as String)
                : null,
            index: (state.extra as Map)['index'],
          ),
        ),
      ),
      GoRoute(
        name: AppRouteNames.logIn,
        path: AppRouteNames.logIn,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      // GoRoute(
      //   name: AppRouteNames.accountInfoRouteName,
      //   path: AppRouteNames.accountInfoRouteName,
      //   pageBuilder: (context, state) => MaterialPage(
      //     key: state.pageKey,
      //     child: const AccountInformationScreen(),
      //   ),
      // ),

      // GoRoute(
      //     name: AppRouteNames.chargingStationRouteName,
      //     path: '${AppRouteNames.chargingStationRouteName}/:id',
      //     pageBuilder: (context, state) {
      //       return MaterialPage(
      //         key: state.pageKey,
      //         child: StationDetailsScreen(
      //           id: state.pathParameters['id'] ?? '',
      //           chargerId: (state.extra as Map).containsKey('chargerId')
      //               ? ((state.extra as Map)['chargerId'] as String)
      //               : null,
      //           distance: (state.extra as Map).containsKey('distance')
      //               ? ((state.extra as Map)['distance'] as String)
      //               : null,
      //           onPop: (state.extra as Map).containsKey('onPop')
      //               ? ((state.extra as Map)['onPop'] as Function)
      //               : null,
      //         ),
      //       );
      //     }),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorScreen(
        e: state.error,
      ),
    ),
  );
}
