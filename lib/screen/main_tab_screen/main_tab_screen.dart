import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {

  //화면 관리 변수
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(), //1. 홈 화면
          ]
      ),

      //바텀 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        type: BottomNavigationBarType.fixed,

        //클릭 시 리빌드 처리
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },

        //클릭 시 각 탭 효과 처리
        selectedItemColor: AppColor.primary,
        selectedFontSize: 14,
        unselectedFontSize: 12,


        items: [
          BottomNavigationBarItem(label: "홈", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "장바구니", icon: Icon(Icons.shopping_bag)),
          BottomNavigationBarItem(label: "위시 리스트", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: "마이 페이지", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
