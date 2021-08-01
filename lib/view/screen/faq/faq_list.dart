import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/faq.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/faq/faq_data.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FAQList extends StatefulWidget {
  @override
  _FAQListState createState() => _FAQListState();
}

class _FAQListState extends State<FAQList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<FAQ>>(
      stream: DatabaseService(uid: user.uid).faqList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FAQ> faq = snapshot.data;
          return Scaffold(
            appBar: ElrAppBar('FAQ', false),
            drawer: ElrDrawer(),
            body: Container(
              padding: EdgeInsets.all(5),
              color: Color(0xffE8E8E8),
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: faq.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: FAQData(
                              faqid: faq[index].faqid,
                            )));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(faq[index].question,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
