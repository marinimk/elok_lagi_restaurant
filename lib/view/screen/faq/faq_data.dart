import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/faq.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/view/widgets/elrAppBar.dart';

class FAQData extends StatefulWidget {
  @override
  _FAQDataState createState() => _FAQDataState();

  final String faqid;
  FAQData({this.faqid});
}

class _FAQDataState extends State<FAQData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FAQ>(
        stream: DatabaseService(uid: widget.faqid).faq,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final faq = snapshot.data;
            return Scaffold(
              appBar: ElrAppBar('FAQ', false),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        decoration: BoxDecoration(
                          color: colorsConst[400],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: faqCard('Question: ', faq.question),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        decoration: BoxDecoration(
                          color: colorsConst[100],
                          border: Border.all(width: 5, color: colorsConst[400]),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: faqCard('Answer:', faq.answer),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Column faqCard(String title, String faq) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(title, style: TextStyle(fontSize: 16))),
        Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Text(
              faq,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
