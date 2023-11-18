import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:project/camera_page.dart';

class AlcoholCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Expanded(
            child: Container(
              color: Colors.pink,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 40),
                    //메인텍스트
                    Text(
                      '오늘의\n음주 수치', // \n을 사용하여 줄바꿈
                      textAlign: TextAlign.left, // 텍스트를 왼쪽 정렬
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상을 밝은 색으로 변경, 배경이 어두운 경우
                      ),
                    ),
                    SizedBox(height: 40),

                    //와인잔
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 아이콘들을 가운데 정렬
                      children: List.generate(7, (index) => Icon(Icons.wine_bar, size: 40, color: Colors.black)),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
            ),
          ),

          SizedBox(height: 40),
          Text(
            'AI 음주 측정하기',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼들을 균등
                    children: <Widget>[

                      // 카메라 아이콘 버튼
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CameraApp()));
                          // 카메라 촬영 기능을 여기에 구현

                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.camera_alt, size: 50), // 카메라 아이콘
                            Text('카메라 촬영'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            minimumSize: Size(150, 150)
                        ),
                      ),

                      // 그림 아이콘 버튼
                      ElevatedButton(
                        onPressed: () {
                          // 여기에 그림 아이콘 버튼의 기능을 구현
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.image, size: 50),
                            Text('그림 업로드'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            minimumSize: Size(150, 150)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text('오늘의 메시지', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(' - 오늘 저녁은 술자리가 있는 날! -'),
                ],
              ),
            ),
          ),

          //메뉴바 버튼
          BottomNavigationBar(
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
              if (index == 1) { // 설정 아이콘 인덱스
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}