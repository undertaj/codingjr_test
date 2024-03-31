import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _change = true;

  final _selectedColor = Color(0xff464646);
  final _unselectedColor = Color(0xff9a9a9a);
  final _tabs = [
    Tab(text: 'Description'),
    Tab(text: 'Editorial'),
    Tab(text: 'Solutions'),
  ];


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _showPlagiarismWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red), // Red alert icon
              SizedBox(width: 10), // Add some spacing between the icon and text
              Text('Plagiarism Warning'),
            ],
          ),
          content: Text('Submitting code that is not your own may result in penalties.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor,
        toolbarHeight: 0,

        bottom:
        _change ?
        TabBar(
          controller: _tabController,
          indicatorPadding: EdgeInsets.only(top: 8, bottom: 8,left: 8, right: 8),

          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xffF7F7F7),
          ),
          dividerHeight: 0.0,
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xff919191),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: _tabs,
        ) :
        PreferredSize(
          preferredSize: Size.fromHeight(43),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: _selectedColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xffF7F7F7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Code',
                        ),
                      )
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return TestResultsBottomSheet();
                            },
                          );
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xff38ad19),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Run',
                              ),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (_) {
                            return AlertDialog(
                              title: // Add some spacing between the icon and text
                                  Text('Are you sure you want to submit the code ?'),



                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the AlertDialog
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {

                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Code submitted successfully'),
                                      ),
                                    );// Close the AlertDialog
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xffF7F7F7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Submit',
                              ),
                            )
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),

        ),
      ),


      body: GestureDetector(
        onHorizontalDragEnd: (_){
          setState(() {
            _change = !_change;
          });
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Editor(path: 'assets/tinywl.c')));
        },


        child:
        _change ?
        TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              child: Center(
                child: Text("Description\nSwipe right to code->", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            Container(
              child: Center(
                child: Text("Editorial", style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            Container(
              child: Center(
                child: Text("Solutions",style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
          ],
        ) :
        Editor(path: 'assets/tinywl.c'),
      ),
      floatingActionButton: _change ? null : FloatingActionButton(
        onPressed: () {
          _showPlagiarismWarning(context);
        },
        child: Icon(Icons.warning), // Display the warning icon
        backgroundColor: Colors.red, // Set background color of FAB
      ),
    );
  }
}


class TestResultsBottomSheet extends StatefulWidget {
  @override
  _TestResultsBottomSheetState createState() => _TestResultsBottomSheetState();
}

class _TestResultsBottomSheetState extends State<TestResultsBottomSheet> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Test Results',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: _isExpanded ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            const Column(
              children: [
                ListTile(
                  title: Text('Test 1'),
                  trailing: Icon(Icons.check),
                ),
                ListTile(
                  title: Text('Test 2'),
                  trailing: Icon(Icons.close),
                ),
              ],
            ),
        ],
      ),
    );
  }
}