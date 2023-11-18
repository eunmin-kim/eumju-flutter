import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alcohol_check_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nickname = '';
  String selectedDrink = '';
  String drinkAmount = '';
  String drinkUnit = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nickname = prefs.getString('nickName') ?? 'Unknown';
      selectedDrink = prefs.getString('juJong') ?? 'None';
      drinkAmount = prefs.getString('juRang') ?? '0';
      drinkUnit = prefs.getString('juRangUnit') ?? '잔';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '회원정보',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100), //간격
            //아이콘
            Icon(Icons.account_circle, size: 200, color: Colors.grey),
            SizedBox(height: 20), //간격
            //닉네임
            Text(
              '닉네임: $nickname',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), //간격
            //주량
            Text(
              '주량: $selectedDrink $drinkAmount$drinkUnit',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 100), //간격
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        onTap: (index) {
          if (index == 0) { // 홈 버튼
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AlcoholCheckPage()),
            );
          }
        },
      ),
    );
  }
}