import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_switch/custom_switch.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _status;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<RestaurantData>(
        initialData: RestaurantData(),
        stream: DatabaseService(uid: user.uid).restaurantData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurant = snapshot.data;
            return Scaffold(
              drawer: ElrDrawer(),
              appBar: ElrAppBar('SETTINGS', false),
              body: Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Status'),
                  subtitle: Text(restaurant.status ? 'Open' : 'Close'),
                  trailing: CustomSwitch(
                    activeColor: colorsConst[500],
                    value: restaurant.status,
                    onChanged: (val) async {
                      print("VALUE : $val");
                      setState(() => _status = val);
                      await DatabaseService(uid: user.uid)
                          .updateStatus(_status);
                    },
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
