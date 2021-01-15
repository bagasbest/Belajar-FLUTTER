import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            navIcon: Icons.home,
            navTitle: "Halaman Utama",
            isActive: true,
          ),
          BottomNavItem(
            navIcon: Icons.show_chart,
            navTitle: "Progress Kamu",
          ),
          BottomNavItem(
            navIcon: Icons.settings,
            navTitle: "Pengaturan",
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData navIcon;
  final String navTitle;
  final Function navNavigatorTo;
  final bool isActive;

  const BottomNavItem({
    this.navIcon,
    this.navTitle,
    this.navNavigatorTo,
    this.isActive = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navNavigatorTo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(navIcon, color: isActive ? Colors.pink : Colors.black),
          Text(
            navTitle,
            style: TextStyle(color: isActive ? Colors.pink : Colors.black),
          ),
        ],
      ),
    );
  }
}
