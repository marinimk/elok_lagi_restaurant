import 'package:elok_lagi_restaurant/view/screen/menu/food_tile.dart';
import 'package:elok_lagi_restaurant/view/screen/menu/menuUpdate.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/models/food.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final food = Provider.of<List<Food>>(context);
    return food.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            height: MediaQuery.of(context).size.height,
            child: Text(
              'There are no food items available for sale. \nAdd food items by clicking \'+\' at the bottom right corner of the screen',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: food.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: MenuUpdate(
                              food: food[index],
                              fid: food[index].fid,
                            )),
                  ),
                    // MaterialPageRoute(
                    //     builder: (context) => ),
                child: Card(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: FoodTile(food: food[index])),
              );
            },
          );
  }
}
