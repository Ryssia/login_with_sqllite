import 'package:flutter/material.dart';

import 'common/routes/view_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    initialRoute: RoutesApp.home,
    onGenerateRoute: RoutesApp.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
