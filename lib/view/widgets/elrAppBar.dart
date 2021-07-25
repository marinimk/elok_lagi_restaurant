import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: true,
      title: Text(widget.title),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child:
              widget.isProfile ? statusButton(context) : notificationButton(),
        ),
      ],
    );
  }

  Stack notificationButton() {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
        ),
        Positioned(
          left: 14,
          top: 11,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  AwesomeDialog awesomeDialog(BuildContext context) {
    String currStatus = isOpen ? 'OPEN' : 'CLOSE';
    String newStatus = isOpen ? 'CLOSE' : 'OPEN';
    return AwesomeDialog(
      context: context,
      borderSide: BorderSide(width: 5, color: colorsConst[100]),
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      title: 'Your restaurant is currently $currStatus',
      desc: 'Do you want to change the status to $newStatus?',
      showCloseIcon: true,
      btnCancelText: 'Close',
      btnOkText: 'Open',
      btnCancelOnPress: () {
        setState(() async {
          isOpen = false;
        });
      },
      btnOkOnPress: () {
        setState(() => isOpen = true);
      },
    )..show();
  }

  ElevatedButton statusButton(BuildContext context) {
    Color color = isOpen ? colorsConst[800] : Colors.red;
    IconData icon = isOpen
        ? Icons.check_circle_outline_outlined
        : Icons.not_interested_outlined;
    String status = isOpen ? 'OPEN' : 'CLOSE';
    return ElevatedButton(
      onPressed: () => awesomeDialog(context),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            status,
          ),
        ],
      ),
      style: elevatedButtonStyle().copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
    );
  }
}
