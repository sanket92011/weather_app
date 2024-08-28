import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar(
      {super.key,
      required this.title,
      required this.useCustomIcon,
      required this.isCenter,
      required this.onClick,
      required this.imagePath,
      required this.icon});

  final Text title;
  final IconData icon;
  final bool useCustomIcon;
  bool isCenter = false;
  final VoidCallback onClick;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isCenter ? Center(child: title) : title,
      actions: [
        IconButton(
            onPressed: onClick,
            icon: useCustomIcon ? Image.asset(imagePath) : Icon(icon))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
