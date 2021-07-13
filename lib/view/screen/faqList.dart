import 'package:elok_lagi_restaurant/view/screen/faq.dart';
import 'package:flutter/material.dart';

class FAQList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
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
            // buildNewTitle(),
            buildCardNewHistory(context),
          ],
        ),
      ),
    );
  }

  // Widget buildNewTitle() {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     child: Text(
  //       'Today\'s History',
  //       style: TextStyle(
  //         fontSize: 30,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

  Widget buildCardAcahTry(BuildContext context, String q) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FAQ()),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(
            q,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // trailing: Text(
          //   '12:00',
          //   style: TextStyle(
          //       // fontWeight: FontWeight.bold,
          //       // fontSize: 18,
          //       ),
          // ),
        ),
      ),
    );
    // count = count + 1;
  }

  Widget buildCardNewHistory(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: Colors.amber,
        child: ListView(
          children: [
            buildCardAcahTry(context, 'How do I set up Elok Lagi Merchants?'),
            buildCardAcahTry(context, 'How do I update the food menu?'),
            buildCardAcahTry(
                context, 'Can I change the status of my restaurant?'),
            buildCardAcahTry(context, 'Can I deactivate my account?'),
            buildCardAcahTry(context, 'How to I contact HQ?'),
          ],
        ),
      ),
    );
  }
}
