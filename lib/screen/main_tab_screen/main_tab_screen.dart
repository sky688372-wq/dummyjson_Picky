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
          HomeScreen(),                                          // 0. 홈 화면
          Center(child: Text('장바구니 화면 준비 중')),              // 1. 장바구니 화면
          Center(child: Text('위시리스트 화면 준비 중')),            // 2. 위시리스트 화면
          Center(child: Text('마이페이지 화면 준비 중')),            // 3. 마이페이지 화면
        ],
      ),

      //바텀 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },

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