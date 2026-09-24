import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      String userId,
      String userPassword,
      ) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': userId,
          'password': userPassword,
        }),
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

        //저장 확인용 테스트 프린트
        // print(accessToken);
        // print(gender);

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
}