import 'package:atak_searchapp/config/initial_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATAK SearchApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      getPages: RoutesConfig.routes(),
    );
  }
}
