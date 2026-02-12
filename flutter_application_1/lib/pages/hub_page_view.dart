import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/app_colors.dart';
import 'package:flutter_application_1/chat_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/pagmeditar.dart';
import 'package:flutter_application_1/pages/Audiopage.dart';

class HubPageView extends StatefulWidget {
  final int initialIndex;

  const HubPageView({super.key, this.initialIndex = 0});

  @override
  State<HubPageView> createState() => _HubPageViewState();
}

class _HubPageViewState extends State<HubPageView> {
  late int currentPage;

  final List<Widget> listPage = [
    HomePage(),
    PagMeditar(),
    AudioPage(),
    ChatPage(),
  ];

  final List<_MenuData> menuItems = const [
    _MenuData(icon: Icons.home, label: 'Home'),
    _MenuData(icon: Icons.self_improvement, label: 'Meditação'),
    _MenuData(icon: CupertinoIcons.music_note_2, label: 'Áudios'),
    _MenuData(icon: Icons.chat, label: 'Medfy'),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            listPage[currentPage],
            Positioned(
              left: largura * 0.04,
              right: largura * 0.04,
              bottom: altura * 0.025,
              child: _BottomNavBar(
                items: menuItems,
                currentIndex: currentPage,
                onItemSelected: (index) {
                  print(index);
                  if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                    return;
                  }

                  setState(() => currentPage = index);
                },
                larguraTela: largura,
                alturaTela: altura,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String label;

  const _MenuData({required this.icon, required this.label});
}

class _BottomNavBar extends StatelessWidget {
  final List<_MenuData> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;
  final double larguraTela;
  final double alturaTela;

  const _BottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
    required this.larguraTela,
    required this.alturaTela,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 Altura do menu proporcional à tela
    final double containerHeight = alturaTela * 0.11; // ~11% da altura
    final double iconSize = larguraTela > 800 ? 48 : 38;
    final double fontSize = larguraTela > 800 ? 18 : 15;
    final double spacing = larguraTela > 800 ? 8 : 4;

    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: AppColors.verdePrincipal,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          items.length,
          (index) => _MenuItem(
            data: items[index],
            isActive: currentIndex == index,
            onTap: () => onItemSelected(index),
            iconSize: iconSize,
            fontSize: fontSize,
            spacing: spacing,
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final _MenuData data;
  final bool isActive;
  final VoidCallback onTap;
  final double iconSize;
  final double fontSize;
  final double spacing;

  const _MenuItem({
    required this.data,
    required this.isActive,
    required this.onTap,
    required this.iconSize,
    required this.fontSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.amareloMenu;
    final Color inactiveColor = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            data.icon,
            size: iconSize,
            color: isActive ? activeColor : inactiveColor,
            shadows: isActive
                ? [
                    const Shadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          SizedBox(height: spacing),
          Text(
            data.label,
            style: TextStyle(
              color: isActive ? activeColor : inactiveColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
              shadows: isActive
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}
