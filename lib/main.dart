import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:project/add_drunk_setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_nickname_page.dart';
import 'package:project/alcohol_check_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _updatePages();
  }

  void _updatePages() {
    _pages = [
      Padding(
        padding: EdgeInsets.all(30),
        child: AddNickName(selectedIndex: _selectedIndex,onIncrement: _incrementIndex, ),
      ),
      Padding(
        padding: EdgeInsets.all(30),
        child: AddDrunkSetting(selectedIndex: _selectedIndex,onIncrement: _incrementIndex, ),
      ),
    ];
  }
  void _incrementIndex() {
    setState(() {
      _selectedIndex++;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            // 데이터가 있으면 메인 페이지를 표시
            return MaterialApp(
              title: "Main Page",
              home: AlcoholCheckPage(),
            );
          } else {
            // 데이터가 없으면 기본 페이지를 표시
            return MaterialApp(
                title: 'Flutter Demo',
                home: Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: AppBar(
                    title: Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/splash.png", fit: BoxFit.cover, width: 70,),
                    ),
                    backgroundColor: Color.fromRGBO(198, 155, 114, 0.78),
                    toolbarHeight: 100,
                  ),
                  body: IndexedStack(
                    index: _selectedIndex,
                    children: _pages,
                  ),
                )
            );
          }
        } else {
          // 데이터 로딩 중
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}

Future<Map<String, dynamic>?> getData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? nickName = prefs.getString('nickName');
  final List<String>? drunkSetting = prefs.getStringList('drunkSetting');
  if (nickName != null && drunkSetting != null) {
    return {'nickName': nickName, 'drunkSetting': drunkSetting};
  }
  return null;
}