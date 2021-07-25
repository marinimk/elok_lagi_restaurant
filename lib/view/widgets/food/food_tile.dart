import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  FoodTile({this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            child: (food.imageURL != null)
                ? Image.network(food.imageURL,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center)
                : Image.asset(
                    'assets/images/defaultFood.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                  ),
            width: 125,
            height: 125,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  food.name.inCaps,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                child: Text(food.description.inCaps,
                    style:
                        TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
              ),
              SizedBox(height: 4),
              foodInfoCard('Original price: ',
                  'RM ${food.oriPrice.toStringAsFixed(2).toString()}'),
              SizedBox(height: 4),
              foodInfoCard('Selling price: ',
                  'RM ${food.salePrice.toStringAsFixed(2).toString()}'),
              SizedBox(height: 4),
              foodInfoCard('Available pax: ', food.pax.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Row foodInfoCard(String title, String info) {
    return Row(
      children: [
        Container(
            width: 100,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),
        Container(
            child: Text(
          info,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        )),
      ],
    );
  }
}
