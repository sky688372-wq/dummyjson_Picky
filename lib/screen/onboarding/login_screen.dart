import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/app_function/app_function.dart';
import 'package:dummyjson/provider/userInfo_provider.dart';
import 'package:dummyjson/screen/main_tab_screen/main_tab_screen.dart';
import 'package:dummyjson/screen/onboarding/find_password_screen.dart';
import 'package:dummyjson/screen/onboarding/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //컨트롤러
  final TextEditingController _idCtrl = TextEditingController(); // 유저 아이디 컨트롤러
  final TextEditingController _passwordCtrl =
  TextEditingController(); //유저 계정 비밀번호 컨틀홀러

  //유저 로그인 유지 기능 상태 변수
  bool _keepLoggedIn = false;

  //비밀번호 보임/숨김 상태 변수
  bool _isPasswordShow = false;

  //로그인 요청 중 상태 관리 변수
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            //양옆 일정 페딩
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 5),

                //2. 상단 앱 문구
                const Text(
                  '안목 있는 당신을 위한 큐레이션',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

                //3. 텍스트 필드와 텍스트 부분

                // (1) 이메일 또는 아아디 텍스트 필드
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '아이디',
                      style: TextStyle(fontSize: 16, color: Colors.black),
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

                // (2) 계정 비밀번호
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '비밀번호',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),

                TextField(
                  controller: _passwordCtrl,
                  obscureText: _isPasswordShow ? false : true,
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

                // 4. 로그인 유지, 체크박스 / 비밀번호 찾기 텍스트 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 로그인 유지 체크 박스
                    Row(
                      children: [
                        Checkbox(
                          value: _keepLoggedIn,
                          onChanged: (value) {
                            setState(() {
                              _keepLoggedIn = value ?? false;
                            });
                          },
                        ),

                        const Text("로그인 유지"),
                      ],
                    ),

                    //비밀번호 찾기 텍스트 버튼
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FindPasswordScreen(),
                          ),
                        );
                      },
                      child: Text("비밀번호를 잊으셨나요?"),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 5. 로그인 버튼
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
                    onPressed: _isLoading
                        ? null // 로그인 요청 중 버튼 비활성화
                        : () async {
                      // 로그인 요청 시작
                      setState(() {
                        _isLoading = true;
                      });

                      final success = await context
                          .read<UserinfoProvider>()
                          .tryLogin(
                        _idCtrl.text.trim(),
                        _passwordCtrl.text.trim(),
                      );

                      if (!context.mounted) return;

                      // 로그인 요청 종료
                      setState(() {
                        _isLoading = false;
                      });

                      if (success) { // 성공 시 다음 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainTabScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColor.primary,
                            content: Text(
                              "아이디 또는 비밀번호가 일치하지 않습니다.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    // 서버 응답을 기다리는 동안 중앙에 로딩 표시
                    child: _isLoading
                        ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                        : Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 6.  다른 계정으로 로그인 구분선
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Divider()),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text('소셜 계정으로 로그인하기'),
                      ),

                      Expanded(child: Divider()),
                    ],
                  ),
                ),

                // 7. 다른 소셜 계정으로 로그인 버튼

                // (1) 구글 로그인 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  onPressed: () {
                    AppFunction.showBuilding(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: 20,
                        height: 20,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 8. 회원 가입 이동 텍스트 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('계정이 없으신가요?'),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "회원 가입하기",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}