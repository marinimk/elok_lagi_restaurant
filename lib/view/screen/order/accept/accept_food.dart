import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/fooditem.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptFood extends StatelessWidget {
  final String oid;
  AcceptFood({this.oid});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<FoodItem>>(
      stream: DatabaseService(uid: user.uid, fid: oid).acceptFoodItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final fooditem = snapshot.data;
          return Container(
            height: 250,
            color: colorsConst[100],
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: fooditem.length,
              itemBuilder: (context, index) {
                double totalPrice =
                    fooditem[index].salePrice * fooditem[index].paxWanted;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${fooditem[index].paxWanted} x',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 13,
                          child: Text(
                            fooditem[index].name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            'RM ${totalPrice.toStringAsFixed(2).toString()}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
