import 'package:flutter/material.dart';

class ElrAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isProfile;
  ElrAppBar(this.title, this.isProfile);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _ElrAppBarState createState() => _ElrAppBarState();
}

class _ElrAppBarState extends State<ElrAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
    );
  }
}
