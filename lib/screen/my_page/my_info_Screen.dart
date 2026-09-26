import 'package:flutter/material.dart';
import 'package:dummyjson/provider/userInfo_provider.dart';
import 'package:provider/provider.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<UserinfoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "내 정보",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 프로필 사진 + 이름 (중앙 정렬)
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 1),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          userInfo.profileImg,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 48, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      userInfo.username,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userInfo.email,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // 2. 기본 정보 섹션
              _buildSectionLabel("기본 정보"),
              _buildInfoCard([
                _InfoRow(icon: Icons.badge_outlined, label: "아이디", value: userInfo.username),
                _InfoRow(icon: Icons.mail_outline, label: "이메일", value: userInfo.email),
                _InfoRow(icon: Icons.person_outline, label: "이름", value: "${userInfo.firstName} ${userInfo.lastName}"),
                _InfoRow(icon: Icons.wc_outlined, label: "성별", value: userInfo.gender),
              ]),

              const SizedBox(height: 20),

              // 3. 계정 정보 섹션
              _buildSectionLabel("계정 정보"),
              _buildInfoCard([
                _InfoRow(icon: Icons.fingerprint, label: "회원 번호", value: userInfo.id.toString()),
                _InfoRow(icon: Icons.verified_user_outlined, label: "계정 상태", value: "인증됨"),
              ]),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 섹션 라벨
  Widget _buildSectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  // 정보 카드 (여러 개의 InfoRow를 담는 흰색 박스)
  Widget _buildInfoCard(List<_InfoRow> rows) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          final row = rows[index];
          final isLast = index == rows.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    Icon(row.icon, size: 20, color: Colors.black54),
                    const SizedBox(width: 12),
                    Text(
                      row.label,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Spacer(),
                    Text(
                      row.value,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 14,
                  endIndent: 14,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// 정보 한 줄을 표현하는 간단한 데이터 클래스
class _InfoRow {
  final IconData icon;
  final String label;
  final String value;

  _InfoRow({required this.icon, required this.label, required this.value});
}