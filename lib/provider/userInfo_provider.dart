import 'package:dummyjson/screen/home_screen/home_screen.dart';
import 'package:dummyjson/screen/onboarding/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserinfoProvider extends ChangeNotifier {
  String accessToken = '';
  String refreshToken = '';
  int id = 0;
  String username = '';
  String email = '';
  String firstName = '';
  String lastName = '';
  String gender = '';
  String profileImg = ''; //프로필 이미지 실제로는 'image'로 옴

  Future<bool> tryLogin(
    bool keepLogin,
    String userId,
    String userPassword,
  ) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': userId, 'password': userPassword}),
      );

      if (response.statusCode == 200) {
        print("통신 성공"); //todo
        print("데이터 : \n${response.body}");

        final parseData = jsonDecode(response.body);

        //provider에 데이터 저장
        accessToken = parseData['accessToken'];
        refreshToken = parseData['refreshToken'];
        id = parseData['id'];
        username = parseData['username'];
        email = parseData['email'];
        firstName = parseData['firstName'];
        lastName = parseData['lastName'];
        gender = parseData['gender'];
        profileImg = parseData['image'];

        // 로그인 유지를 선택했다면 로컬(암호화 저장소)에도 저장
        if (keepLogin) {
          final storage = FlutterSecureStorage();
          await storage.write(key: 'accessToken', value: accessToken);
          await storage.write(key: 'refreshToken', value: refreshToken);
        }

        notifyListeners();

        return true;
      } else {
        print("통신 오류, 오류 코드 ${response.statusCode}"); //todo
        print(response.body);
        return false;
      }
    } catch (e) {
      print("통신 실패, $e");
      return false;
    }
  }

  // 로그아웃 시 정보들을 없애는 매서드
  Future<void> logout(BuildContext context) async{

    //로컬에 있는 데이터들 삭제
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');

    accessToken = '';
    refreshToken = '';
    id = 0;
    username = '';
    email = '';
    firstName = '';
    lastName = '';
    gender = '';
    profileImg = '';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  //로컬에 저장된 값들이 있다면 바로 메인 화면으로 이동시키기
  Future<bool> tryAutoLogin() async {
    final storage = FlutterSecureStorage();
    final savedToken = await storage.read(key: 'accessToken');

    if (savedToken == null) {
      return false; // 저장된 토큰 없음 -> 로그인 화면으로
    }

    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/auth/me'),
        headers: {'Authorization': 'Bearer $savedToken'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        accessToken = savedToken;
        refreshToken = await storage.read(key: 'refreshToken') as String;
        id = data['id'];
        username = data['username'];
        email = data['email'];
        firstName = data['firstName'];
        lastName = data['lastName'];
        gender = data['gender'];
        profileImg = data['image'];

        notifyListeners();
        print("로그인 성공");
        return true; // 자동 로그인 성공
      } else {
        // 토큰이 만료됐거나 무효함 → 로컬 저장값도 삭제
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        print("로그인 실패");
        return false;
      }
    } catch (e) {
      print("자동 로그인 실패: $e");
      return false;
    }
  }
}
