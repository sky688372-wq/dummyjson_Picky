import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/app_function/app_function.dart';
import 'package:flutter/material.dart';

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({super.key});

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  //컨트롤러
  final TextEditingController _idCtrl =
  TextEditingController(); // 유저 아이디 컨트롤러
  final TextEditingController _emailCtrl =
  TextEditingController(); // 유저 이메일 컨트롤러

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //이전으로 돌아기기용 앱바
      appBar: AppBar(),

      body: SafeArea(
        child: Center(
          child: Padding(
            //양옆 일정 페딩
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 1. 최상단 앱 로고
                  Image.asset(
                    'assets/app_logo/app_logo.png',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),

                  const Text(
                    'Picky',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. 비밀번호 찾기 안내 문구
                  const Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    '가입하신 아이디와 이메일을 입력해주세요.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 3. 아이디 입력
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '아이디',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _idCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "아이디를 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  // 4. 이메일 입력
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '이메일',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "가입하신 이메일을 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 5. 비밀번호 찾기 버튼
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        //실제 비밀번호 찾기 기능은 추가 안함
                        AppFunction.showBuilding(context);
                      },
                      child: const Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 6. 로그인 화면 이동 텍스트 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "비밀번호가 기억나셨나요?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "   로그인하기",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}