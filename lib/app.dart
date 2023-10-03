import 'package:adb_server_manager/features/backend_details/bloc/backends_control_options_bloc.dart';
import 'package:adb_server_manager/features/server_list/bloc/backend_listing_bloc.dart';
import 'package:adb_server_manager/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BackendListingBloc(),
      child: MaterialApp.router(
        title: "ADB Server Manager",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter().router,
      ),
    );
    //  MaterialApp(
    //   title: 'Flutter Demo',
    //   theme:
    //   home: const ServerListingScreen(),
    // );
  }
}
