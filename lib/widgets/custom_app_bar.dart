import 'package:flutter/material.dart';
import 'package:weather/pages/cities.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppbar({
    super.key,
    required this.title,
    required this.useCustomIcon,
    required this.isCenter,
    required this.onClick,
    required this.imagePath,
    required this.onThemeButtonClicked,
    required this.icon,
    required this.showRefreshIndicator,
    required this.showGlobeIcon,
  });

  final Text title;
  final bool useCustomIcon;
  bool isCenter = false;
  bool showRefreshIndicator = false;
  final VoidCallback onThemeButtonClicked;
  final IconData icon;
  bool showGlobeIcon = false;
  final VoidCallback onClick;
  final String imagePath;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.isCenter ? Center(child: widget.title) : widget.title,
      actions: [
        widget.showRefreshIndicator
            ? IconButton(
                onPressed: () async {
                  String? refresh = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Cities(),
                    ),
                  );
                  if (refresh == "refresh") {
                    // Handle refresh action if necessary
                    widget.onClick();
                  }
                },
                icon: const Icon(Icons.public),
              )
            : const SizedBox(),
        widget.showGlobeIcon
            ? IconButton(
                onPressed: widget.onClick,
                icon: widget.useCustomIcon
                    ? Image.asset(widget.imagePath)
                    : const Icon(Icons.refresh),
              )
            : const SizedBox(),
      ],
    );
  }
}
