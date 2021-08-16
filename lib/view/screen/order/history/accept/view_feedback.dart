import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ViewFeedback extends StatefulWidget {
  final String ruid;
  final String fid;
  ViewFeedback({this.ruid, this.fid});
  @override
  ViewFeedbackState createState() => ViewFeedbackState();
}

class ViewFeedbackState extends State<ViewFeedback> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<AcceptHistory>(
      stream: DatabaseService(uid: user.uid, fid: widget.fid).acceptHistoryData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AcceptHistory history = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                    readOnly: true,
                    validator: (val) => val.isEmpty
                        ? 'please field in your new $widget.title.toLowerCase()'
                        : '',
                    initialValue: history.feedback,
                    decoration:
                        textInputDecoration(Icons.border_color, 'Feedback')),
              ),
              SizedBox(height: 5),
              RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: history.rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (val) {},
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(Icons.sentiment_very_dissatisfied,
                            color: Colors.red);
                      case 1:
                        return Icon(Icons.sentiment_dissatisfied,
                            color: Colors.redAccent);
                      case 2:
                        return Icon(Icons.sentiment_neutral,
                            color: Colors.amber);
                      case 3:
                        return Icon(Icons.sentiment_satisfied,
                            color: Colors.lightGreen);
                      case 4:
                        return Icon(Icons.sentiment_very_satisfied,
                            color: Colors.green);
                      default:
                        return Container();
                    }
                  }),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: buttonTextRow(Icons.check_circle, 'NICE'),
                    style: elevatedButtonStyle().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () async => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
