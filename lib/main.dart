import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:magical_music/database/models/musicDbModel.dart';
import 'package:magical_music/database/models/toolDbModel.dart';
import 'package:magical_music/database/services/musicDB.dart';
import 'package:magical_music/database/services/toolDB.dart';
import 'package:magical_music/stateManagement/bindings/bindings.dart';
import 'package:magical_music/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MusicDbModelAdapter());
  Hive.registerAdapter(ToolDbModelAdapter());
  await Hive.openBox<MusicDbModel>(MusicDB.boxname);
  await Hive.openBox<ToolDbModel>(ToolsDB.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
      initialBinding: MusicBindings(),
      initialRoute: Routes.home,
      theme: ThemeData(
        textTheme: GoogleFonts.courgetteTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
