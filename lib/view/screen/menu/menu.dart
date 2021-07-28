import 'package:elok_lagi_restaurant/models/food.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:elok_lagi_restaurant/view/screen/menu/food_list.dart';
import 'package:elok_lagi_restaurant/view/screen/menu/menuAdd.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return loading
        ? Loading()
        : StreamProvider<List<Food>>.value(
            initialData: [],
            value: DatabaseService(uid: user.uid).food,
            child: Scaffold(
              appBar: ElrAppBar('Menu', false),
              drawer: ElrDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuAdd(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                // color: Colors.grey,
                child: FoodList(),
              ),
            ),
          );
  }
}
