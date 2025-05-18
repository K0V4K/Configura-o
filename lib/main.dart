import 'package:flutter/material.dart';
import 'package:flutter_application/src/auth/sign_in_screen.dart';
import 'package:flutter_application/src/pages_routes/app_pages.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Presence+',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,

      initialRoute: PagesRoutes.signInRoute,

      getPages: AppPages.pages,
    );
  }
}
