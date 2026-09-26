import 'package:dummyjson/app_color/app_color.dart';
import 'package:dummyjson/app_function/app_function.dart';
import 'package:dummyjson/provider/userInfo_provider.dart';
import 'package:dummyjson/screen/my_page/app_info_screen.dart';
import 'package:dummyjson/screen/my_page/my_info_Screen.dart';
import 'package:dummyjson/screen/onboarding/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // 토글 상태 -> 실제로는 기능 X
  bool _isDarkMode = false;
  bool _isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    //가독성을 위해서 유저 정보 변수처리
    final userInfo = context.watch<UserinfoProvider>();

    return Scaffold(
      // 0. 앱바
      appBar: AppBar(
        title: Text(
          "My Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Image.asset('assets/app_logo/app_logo.png', fit: BoxFit.cover),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 1. 상단 유저 프로필 카드
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.primary,
                        AppColor.primary.withValues(alpha: 0.75),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primary.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 프로필 이미지 (원형 + 흰 테두리)
                            Container(
                              width: 74,
                              height: 74,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  userInfo.profileImg,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // 유저 이름 + 이메일
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userInfo.username,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mail_outline,
                                        size: 13,
                                        color: Colors.white70,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          userInfo.email,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Divider(
                          color: Colors.white.withValues(alpha: 0.3),
                          height: 1,
                        ),
                        const SizedBox(height: 14),

                        // 하단 정보 뱃지 (편집/설정 진입점 느낌)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.verified_user,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "인증된 계정",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 13,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. 각종 설정들
                const SizedBox(height: 24),

                _buildSectionTitle("계정"),
                _buildMenuTile(
                  icon: Icons.receipt_long_outlined,
                  title: "주문 내역",
                  onTap: () {
                    AppFunction.showBuilding(context);
                  },
                ),
                _buildMenuTile(
                  icon: Icons.location_on_outlined,
                  title: "배송지 관리",
                  onTap: () {
                    AppFunction.showBuilding(context);
                  },
                ),

                _buildMenuTile(
                  icon: Icons.account_circle,
                  title: "내 정보 보기",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyInfoScreen()),
                    );
                  },
                ),

                const SizedBox(height: 20),

                _buildSectionTitle("설정"),
                _buildMenuTile(
                  icon: Icons.dark_mode_outlined,
                  title: "다크 모드",
                  trailing: Switch(
                    value: _isDarkMode,
                    activeThumbColor: AppColor.primary,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                ),
                _buildMenuTile(
                  icon: Icons.notifications_outlined,
                  title: "알림 설정",
                  trailing: Switch(
                    value: _isNotificationOn,
                    activeThumbColor: AppColor.primary,
                    onChanged: (value) {
                      setState(() {
                        _isNotificationOn = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                _buildSectionTitle("기타"),
                _buildMenuTile(
                  icon: Icons.info_outline,
                  title: "앱 정보",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppInfoScreen()),
                    );
                  },
                ),
                _buildMenuTile(
                  icon: Icons.logout,
                  title: "로그아웃",
                  titleColor: Colors.red,
                  iconColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("로그아웃"),
                          content: const Text("정말 로그아웃 하시겠습니까?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // 다이얼로그 닫기
                              },
                              child: const Text("취소"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context); // 다이얼로그 닫기
                                context.read<UserinfoProvider>().logout(context); //로그아웃 함수 불러와서 로컬 데이터 삭제 provider의 데이터 삭제

                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                        (route) => false,
                                  );
                                }
                              },
                              child: const Text(
                                "로그아웃",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 섹션 제목 (계정 / 설정 / 기타)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  // 공통 메뉴 타일
  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.grey.withValues(alpha: 0.1),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: Icon(icon, color: iconColor ?? Colors.black87),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: titleColor ?? Colors.black87,
              ),
            ),
            trailing:
                trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.black38,
                ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
