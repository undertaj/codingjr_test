import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_m/pages/hidden_drawer_page.dart';
import 'package:project_m/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'editor/view.dart';
import 'editor/input.dart';
import 'editor/highlighter.dart';

class Editor extends StatefulWidget {
  const Editor({super.key, this.path = ''});
  final String path;
  @override
  _Editor createState() => _Editor();
}

class _Editor extends State<Editor> {
  late DocumentProvider doc;
  @override
  void initState() {
    doc = DocumentProvider();
    doc.openFile(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => doc),
      Provider(create: (context) => Highlighter())
    ], child:  InputListener(
        child: Scaffold(
            body: View1(),

        )
    ));
  }
}

void main() async {
  ThemeData themeData = ThemeData(
    useMaterial3: false,
    fontFamily: 'FiraCode',
    primaryColor: foreground,
    scaffoldBackgroundColor: background,

  );
  runApp(MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const Scaffold(
          // body: Editor(path: 'assets/tinywl.c'),
          body: MyApp(),
      ),
  ));
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return HomePage();
    return HiddenDrawerPage();
  }
}

