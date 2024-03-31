import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'document.dart';
import 'highlighter.dart';

class DocumentProvider extends ChangeNotifier {
  Document doc = Document();

  Future<bool> openFile(String path) async {
    bool res = await doc.openFile(path);
    touch();
    return res;
  }

  void touch() {
    notifyListeners();
  }
}

class ViewLine extends StatelessWidget {
  const ViewLine({this.lineNumber = 0, this.text = '', super.key});

  final int lineNumber;
  final String text;

  @override
  Widget build(BuildContext context) {
    DocumentProvider doc = Provider.of<DocumentProvider>(context);
    Highlighter hl = Provider.of<Highlighter>(context);
    List<InlineSpan> spans = hl.run(text, lineNumber, doc.doc);

    final gutterStyle = TextStyle(
        fontFamily: 'FiraCode', fontSize: gutterFontSize, color: comment);
    double gutterWidth =
        getTextExtents(' ${doc.doc.lines.length} ', gutterStyle).width;

    return Stack(children: [
      Padding(
          padding: EdgeInsets.only(left: gutterWidth),
          child: RichText(text: TextSpan(children: spans), softWrap: true)),
      Container(
          width: gutterWidth,
          alignment: Alignment.centerRight,
          child: Text('${lineNumber + 1} ', style: gutterStyle)),
    ]);
  }
}

class View1 extends StatefulWidget {
  const View1({super.key, this.path = ''});
  final String path;

  @override
  _View1 createState() => _View1();
}

class _View1 extends State<View1> {
  late ScrollController scroller;

  @override
  void initState() {
    scroller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DocumentProvider doc = Provider.of<DocumentProvider>(context);
    return ListView.builder(
        controller: scroller,
        itemCount: doc.doc.lines.length,
        itemBuilder: (BuildContext context, int index) {
          print(doc.doc.lines[index]);
          return ViewLine(lineNumber: index, text: doc.doc.lines[index]);
        });
  }
}
