import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  // Velog 링크 열기
  Future<void> _launchVelog() async {
    final Uri url = Uri.parse('https://velog.io/@han090213/DummyJSON-%EC%87%BC%ED%95%91-%EC%95%B1-%EA%B8%B0%ED%9A%8D-%EC%B6%94%EC%83%81%ED%99%94');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다.')));
      }
    }
  }

  // 더미 제이슨 사이트로 이동 하는 부분
  Future<void> _launchDummyJSON() async {
    final Uri url = Uri.parse('https://dummyjson.com/');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다.')));
      }
    }
  }

  // Flutter 공식 페이지로 이동하도록 하는 함수
  Future<void> _launchFlutter() async {
    final Uri url = Uri.parse('https://flutter.dev/');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다.')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 0. 앱바
      appBar: AppBar(
        title: const Text(
          "앱 정보",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // 1. 앱 로고
              Image.asset(
                'assets/app_logo/app_logo.png',
                width: 100,
                height: 100,
              ),

              const SizedBox(height: 16),

              // 2. 앱 이름
              const Text(
                "Picky",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              // 3. 버전 정보
              Text(
                "버전 1.0.0",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),

              const SizedBox(height: 12),

              // 4. 한 줄 소개
              const Text(
                "안목 있는 당신을 위한 큐레이션",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 40),

              const Divider(),

              const SizedBox(height: 12),

              // 5. 개발 관련 정보 리스트
              
              //개발 블로그
              _buildInfoTile(
                icon: Icons.article_outlined,
                title: "개발 블로그",
                subtitle: "개발자의 개발 블로그로 바로가기",
                onTap: _launchVelog,
              ),

              //개발 과정 블로그(현재 비공개 상태)
              _buildInfoTile(
                icon: Icons.article_outlined,
                title: "개발 과정",
                subtitle: "Velog에서 개발 과정 보기",
                onTap: _launchVelog,
              ),

              //사용한 API 더미 제이슨 사이트로 이동
              _buildInfoTile(
                icon: Icons.api_outlined,
                title: "사용한 API",
                subtitle: "DummyJSON",
                onTap: _launchDummyJSON,
              ),

              // 개발 프레임 워크 Flutter 공식 홈페이지로 이동
              _buildInfoTile(
                icon: Icons.code_outlined,
                title: "개발 프레임워크",
                subtitle: "Flutter",
                onTap: _launchFlutter,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.grey.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: Icon(icon, color: Colors.black87),
              title: Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              trailing: onTap != null
                  ? const Icon(Icons.open_in_new, size: 18, color: Colors.black38)
                  : null,
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
