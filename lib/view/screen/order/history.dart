import 'package:elok_lagi_restaurant/view/screen/order/prevOrder.dart';
import 'package:elok_lagi_restaurant/view/widgets/elrAppBar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elrDrawer.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _History createState() => _History();
}

// int count = 1;

class _History extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElrAppBar('History', false),
      drawer: ElrDrawer(),
      body: Container(
        padding: EdgeInsets.all(5),
        color: Color(0xffE8E8E8),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          //mainAxisSize: ,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildNewTitle(),
            buildCardNewHistory(),
          ],
        ),
      ),
    );
  }

  Widget buildNewTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Today\'s History',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildCardAcahTry(int count) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrevOrder()),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(
            'History #$count',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: Text(
            '12:00',
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                // fontSize: 18,
                ),
          ),
        ),
      ),
    );
    // count = count + 1;
  }

  Widget buildCardNewHistory() {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: Colors.amber,
        child: ListView(
          children: [
            buildCardAcahTry(1),
            buildCardAcahTry(2),
            buildCardAcahTry(3),
            buildCardAcahTry(4),
            buildCardAcahTry(5),
            buildCardAcahTry(6),
            buildCardAcahTry(7),
            buildCardAcahTry(8),
            buildCardAcahTry(9),
            buildCardAcahTry(10),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        buildShowAlert(context);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.fiber_manual_record,
            size: 15,
            color: Colors.green,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'OPEN',
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
    );
  }

  buildShowAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Your restaurant is Open')),
          // titlePadding: EdgeInsets.fromWindowPadding(padding, devicePixelRatio),
          content: Text('Do you want to change your status?'),
          actions: [
            OutlinedButton(
              onPressed: () {},
              child: Row(children: [
                Icon(
                  Icons.fiber_manual_record,
                  size: 15,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ]),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1.5,
                ),
                // backgroundColor: Colors.black,
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    size: 15,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Busy',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1.5,
                ),
                // backgroundColor: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
