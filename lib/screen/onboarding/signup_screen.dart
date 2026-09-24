import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/app_function/app_function.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //컨트롤러
  final TextEditingController _idCtrl = TextEditingController(); // 유저 아이디 컨트롤러
  final TextEditingController _passwordCtrl =
  TextEditingController(); //유저 계정 비밀번호 컨틀홀러
  final TextEditingController _passwordCheckCtrl =
  TextEditingController(); // 유저 계정 비밀번호 확인 컨트롤러
  final TextEditingController _nameCtrl =
  TextEditingController(); // 유저 이름 컨트롤러
  final TextEditingController _emailCtrl =
  TextEditingController(); // 유저 이메일 컨트롤러
  final TextEditingController _phoneCtrl =
  TextEditingController(); // 유저 전화번호 컨트롤러

  //비밀번호 보임/숨김 상태 변수
  bool _isPasswordShow = false;
  bool _isPasswordCheckShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), //이전으로 돌아기기용 앱바

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

                  const SizedBox(height: 5),

                  //2. 상단 앱 문구
                  const Text(
                    'Picky와 함께 안목 있는 쇼핑을 시작해보세요',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 30),

                  //3. 회원가입 입력 부분

                  // (1) 아이디
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

                  // (2) 비밀번호
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '비밀번호',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _passwordCtrl,
                    obscureText: !_isPasswordShow,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordShow = !_isPasswordShow;
                          });
                        },
                        icon: Icon(
                          _isPasswordShow
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "비밀번호를 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  // (3) 비밀번호 확인
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '비밀번호 확인',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _passwordCheckCtrl,
                    obscureText: !_isPasswordCheckShow,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordCheckShow =
                            !_isPasswordCheckShow;
                          });
                        },
                        icon: Icon(
                          _isPasswordCheckShow
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "비밀번호를 다시 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  // (4) 이름
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '이름',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _nameCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "이름을 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  // (5) 이메일
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
                      hintText: "이메일을 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  // (6) 전화번호
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '전화번호',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "전화번호를 입력해주세요.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 4. 회원가입 버튼
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 55),
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        //todo 회원 가입 로직 추가하기
                        AppFunction.showBuilding(context);
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 5. 로그인 화면 이동 텍스트 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 수정
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "이미 계정이 있으신가요?",
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