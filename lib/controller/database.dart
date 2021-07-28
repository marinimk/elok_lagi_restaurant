import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi_restaurant/models/accept.dart';
import 'package:elok_lagi_restaurant/models/decline.dart';
import 'package:elok_lagi_restaurant/models/customer.dart';
import 'package:elok_lagi_restaurant/models/faq.dart';
import 'package:elok_lagi_restaurant/models/food.dart';
import 'package:elok_lagi_restaurant/models/fooditem.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/order.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  String uid;
  String fid;
  String cuid;
  DatabaseService({@required this.uid, this.fid, this.cuid});

  // collection reference
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');
  final CollectionReference faqCollection =
      FirebaseFirestore.instance.collection('faqMerchant');
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customer');

  //? Restaurant @ profile
  //Create and Update restaurant information
  Future updateRestaurantData(String name, String category, String location,
      String phoneNum, bool status, String imageURL) async {
    return await restaurantCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'category': category,
      'location': location,
      'phoneNum': phoneNum,
      'status': status,
      'imageURL': imageURL
    });
  }

  //retreiving a restaurant's information
  RestaurantData _restaurantDataFromSS(DocumentSnapshot snapshot) {
    return RestaurantData(
      uid: uid,
      name: snapshot.data()['name'] ?? '',
      category: snapshot.data()['category'] ?? '',
      location: snapshot.data()['location'] ?? '',
      phoneNum: snapshot.data()['phoneNum'] ?? '',
      status: snapshot.data()['status'] ?? false,
      imageURL: snapshot.data()['imageURL'] ?? '',
    );
  }

  Stream<RestaurantData> get restaurantData {
    return restaurantCollection.doc(uid).snapshots().map(_restaurantDataFromSS);
  }

  // //retrieving a list of restaurants from FB. i dont think this was used in merchant's app.
  // List<Restaurant> _restaurantListFromSS(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Restaurant(
  //       name: doc.data()['name'] ?? '',
  //       category: doc.data()['category'] ?? '',
  //       location: doc.data()['location'] ?? '',
  //       phoneNum: doc.data()['phoneNum'] ?? '',
  //       status: doc.data()['status'] ?? false,
  //       imageURL: doc.data()['imageURL'] ?? '',
  //     );
  //   }).toList();
  // }

  // Stream<List<Restaurant>> get restaurant {
  //   return restaurantCollection.snapshots().map(_restaurantListFromSS);
  // }

  //? Customer
  //customer data from snapshot
  CustomerData _customerDataFromSS(DocumentSnapshot snapshot) {
    return CustomerData(
      uid: uid,
      username: snapshot.data()['username'] ?? '',
      location: snapshot.data()['location'] ?? '',
      phoneNum: snapshot.data()['phoneNum'] ?? '',
      imageURL: snapshot.data()['imageURL'] ?? '',
    );
  }

  Stream<CustomerData> get customerData {
    return customerCollection.doc(uid).snapshots().map(_customerDataFromSS);
  }

  //? Food
  //create food & read
  Future addFood(String name, String description, double oriPrice,
      double salePrice, int pax, String imageURL) async {
    var newFoodDoc = restaurantCollection.doc(uid).collection('food').doc();
    return await newFoodDoc.set({
      'fid': newFoodDoc.id,
      'ruid': uid,
      'name': name,
      'description': description,
      'oriPrice': oriPrice,
      'salePrice': salePrice,
      'datetime': DateTime.now(),
      'pax': pax,
      'imageURL': imageURL,
    });
  }

  //update food data
  Future updateFood(String name, String description, double oriPrice,
      double salePrice, int pax, String imageURL) async {
    return await restaurantCollection
        .doc(uid)
        .collection('food')
        .doc(fid)
        .update({
      'name': name,
      'description': description,
      'oriPrice': oriPrice,
      'salePrice': salePrice,
      'datetime': DateTime.now(),
      'pax': pax,
      'imageURL': imageURL,
    });
  }

  //delete food data
  Future<void> deleteFood() async =>
      await restaurantCollection.doc(uid).collection('food').doc(fid).delete();

  //returning the list of foods in a restaurant
  List<Food> _foodListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp dtTS = doc.data()['datetime'] as Timestamp;
      DateTime dtDT = dtTS.toDate();
      String date =
          '${dtDT.day.toString().padLeft(2, '0')}/${dtDT.month.toString().padLeft(2, '0')}/${dtDT.year.toString().padLeft(2, '0')}';

      String datetime = '$date ${DateFormat('jm').format(dtDT)}';
      return Food(
        fid: doc.data()['fid'] ?? '',
        name: doc.data()['name'] ?? '',
        description: doc.data()['description'] ?? '',
        oriPrice: doc.data()['oriPrice'] ?? 0.0,
        salePrice: doc.data()['salePrice'] ?? 0.0,
        datetime: datetime ?? '00/00/0000 00.00',
        pax: doc.data()['pax'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Food>> get food {
    return restaurantCollection
        .doc(uid)
        .collection('food')
        .orderBy('datetime', descending: true)
        .snapshots()
        .map(_foodListFromSS);
  }

  //returning a single food item int
  Food _foodDataFromSS(DocumentSnapshot snapshot) {
    Timestamp dtTS = snapshot.data()['datetime'] as Timestamp;
    DateTime dtDT = dtTS.toDate();
    String date =
        '${dtDT.day.toString().padLeft(2, '0')}/${dtDT.month.toString().padLeft(2, '0')}/${dtDT.year.toString().padLeft(2, '0')}';

    String datetime = '$date ${DateFormat('jm').format(dtDT)}';

    return Food(
      fid: snapshot.data()['fid'] ?? '',
      name: snapshot.data()['name'] ?? '',
      description: snapshot.data()['description'] ?? '',
      oriPrice: snapshot.data()['oriPrice'] ?? 0.0,
      salePrice: snapshot.data()['salePrice'] ?? 0.0,
      datetime: datetime ?? '00/00/0000 00.00',
      pax: snapshot.data()['pax'] ?? 0,
      imageURL: snapshot.data()['imageURL'] ?? 0,
    );
  }

  Stream<Food> get foodData {
    return restaurantCollection
        .doc(uid)
        .collection('food')
        .doc(fid)
        .snapshots()
        .map(_foodDataFromSS);
  }

  //? Restaurant status

  //changing the status
  Future updateStatus(bool status) async {
    return await restaurantCollection.doc(uid).update({
      'status': status,
    });
  }

  //retrieving the status
  RestaurantData _statusFromSS(DocumentSnapshot snapshot) {
    return RestaurantData(
      status: snapshot.data()['status'] ?? false,
    );
  }

  Stream<RestaurantData> get status {
    return restaurantCollection.doc(uid).snapshots().map(_statusFromSS);
  }

  //? FAQ
  //returning the list of faq in a restaurant
  List<FAQ> _faqListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FAQ(
        faqid: doc.data()['faqid'] ?? '',
        question: doc.data()['question'] ?? '',
        answer: doc.data()['answer'] ?? '',
      );
    }).toList();
  }

  Stream<List<FAQ>> get faqList {
    return faqCollection.snapshots().map(_faqListFromSS);
  }

  //returning a single faq
  FAQ _faqDataFromSS(DocumentSnapshot snapshot) {
    return FAQ(
      faqid: snapshot.data()['faqid'] ?? '',
      question: snapshot.data()['question'] ?? '',
      answer: snapshot.data()['answer'] ?? '',
    );
  }

  Stream<FAQ> get faq {
    return faqCollection.doc(uid).snapshots().map(_faqDataFromSS);
  }

  //? Orders
  //returning the list of orders in a restaurant
  List<Order> _orderListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String date =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return Order(
        oid: doc.data()['oid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: date ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Order>> get order {
    return restaurantCollection
        .doc(uid)
        .collection('order')
        .orderBy('pickUpTime', descending: false)
        .snapshots()
        .map(_orderListFromSS);
  }

  //returning a single order
  Order _orderDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String date =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);

    return Order(
      oid: snapshot.data()['oid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: date ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
    );
  }

  Stream<Order> get orderData {
    return restaurantCollection
        .doc(uid)
        .collection('order')
        .doc(fid)
        .snapshots()
        .map(_orderDataFromSS);
  }

  //returning the list of fooditems in the order
  List<FoodItem> _foodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get foodItem {
    return restaurantCollection
        .doc(uid)
        .collection('order')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_foodItemListFromSS);
  }

  //? Accept order
  //creating an history subcollection, duplicated from order
  Future createAccept() async {
    await customerCollection
        .doc(cuid)
        .collection('order')
        .doc(fid)
        .update({'accepted': true, 'ready': false, 'completed': false});

    var order = restaurantCollection.doc(uid).collection('order').doc(fid);
    var orderID = order.id;
    var acceptSub =
        restaurantCollection.doc(uid).collection('accept').doc(orderID);

    //duplicating order into history
    order.get().then((value) {
      acceptSub.set(value.data());
      acceptSub.update({
        'aid': orderID,
        'accepted': true,
        'ready': false,
        'completed': false
      });
    });

    //duplicating the fooditem from order into history
    order.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        restaurantCollection
            .doc(uid)
            .collection('accept')
            .doc(orderID)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });

    deleteOrder();
  }

  //returning the list of history orders in a restaurant
  List<Accept> _acceptListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String date =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return Accept(
        aid: doc.data()['aid'] ?? '',
        oid: doc.data()['oid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: date ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Accept>> get accept {
    return restaurantCollection
        .doc(uid)
        .collection('accept')
        .orderBy('pickUpTime', descending: false)
        .snapshots()
        .map(_acceptListFromSS);
  }

  //returning a single history order
  Accept _acceptDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String date =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);

    return Accept(
      aid: snapshot.data()['hid'] ?? '',
      oid: snapshot.data()['oid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: date ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
    );
  }

  Stream<Accept> get acceptData {
    return restaurantCollection
        .doc(uid)
        .collection('accept')
        .doc(fid)
        .snapshots()
        .map(_acceptDataFromSS);
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _acceptFoodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get acceptFoodItem {
    return restaurantCollection
        .doc(uid)
        .collection('accept')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_acceptFoodItemListFromSS);
  }

  //? Decline order
  //restaurant decline order
  Future<void> declineOrder() async {
    await restaurantCollection.doc(uid).collection('order').doc(fid).update({
      'accepted': false,
    });
    await customerCollection.doc(cuid).collection('order').doc(fid).update({
      'accepted': false,
    });
  }

  //creating an decline subcollection, duplicated from order
  void createDecline() async {
    await customerCollection.doc(cuid).collection('order').doc(fid).update({
      'accepted': false,
    });

    var order = restaurantCollection.doc(uid).collection('order').doc(fid);
    var orderID = order.id;
    var declineSub =
        restaurantCollection.doc(uid).collection('decline').doc(orderID);

    //duplicating order into history
    order.get().then((value) {
      declineSub.set(value.data());
      declineSub.update({
        'did': orderID,
        'accepted': false,
        'ready': false,
        'completed': false
      });
    });

    //duplicating the fooditem from order into history
    order.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        restaurantCollection
            .doc(uid)
            .collection('decline')
            .doc(orderID)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });

      deleteOrder();
    });
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _declineFoodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get declineFoodItem {
    return restaurantCollection
        .doc(uid)
        .collection('decline')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_declineFoodItemListFromSS);
  }

  //returning the list of decline orders in a restaurant
  List<Decline> _declineListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String date =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return Decline(
        did: doc.data()['did'] ?? '',
        oid: doc.data()['oid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: date ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Decline>> get decline {
    return restaurantCollection
        .doc(uid)
        .collection('decline')
        .orderBy('pickUpTime', descending: false)
        .snapshots()
        .map(_declineListFromSS);
  }

  //returning a single decline order
  Decline _declineDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String date =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);

    return Decline(
      did: snapshot.data()['did'] ?? '',
      oid: snapshot.data()['oid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: date ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
    );
  }

  Stream<Decline> get declineData {
    return restaurantCollection
        .doc(uid)
        .collection('decline')
        .doc(fid)
        .snapshots()
        .map(_declineDataFromSS);
  }

//? deleting subs
  //delete order after history was made
  void deleteOrder() {
    var toDelete = restaurantCollection.doc(uid).collection('order').doc(fid);

    //delete the fooditems in order
    Future<QuerySnapshot> foodItemInOrder =
        toDelete.collection('fooditem').get();
    foodItemInOrder.then((value) {
      value.docs.forEach((element) {
        toDelete.collection('fooditem').doc(element.id).delete();
      });
    });

    //delete order
    toDelete.delete();
  }

  //delete order after history was made
  void deleteAccept() {
    var toDelete = restaurantCollection.doc(uid).collection('accept').doc(fid);

    //delete the fooditems in order
    Future<QuerySnapshot> foodItemInOrder =
        toDelete.collection('fooditem').get();
    foodItemInOrder.then((value) {
      value.docs.forEach((element) {
        toDelete.collection('fooditem').doc(element.id).delete();
      });
    });

    //delete order
    toDelete.delete();
  }

  //delete order after history was made
  void deleteDecline() {
    var toDelete = restaurantCollection.doc(uid).collection('decline').doc(fid);

    //delete the fooditems in order
    Future<QuerySnapshot> foodItemInOrder =
        toDelete.collection('fooditem').get();
    foodItemInOrder.then((value) {
      value.docs.forEach((element) {
        toDelete.collection('fooditem').doc(element.id).delete();
      });
    });

    //delete order
    toDelete.delete();
  }

//? History @ Orders that are completed
  //creating an history subcollection, duplicated from accept
  Future createHistoryFromAccept() async {
    // await customerCollection.doc(cuid).collection('order').doc(fid).update({
    //   'ready': true,
    // });

    var order = restaurantCollection.doc(uid).collection('accept').doc(fid);
    var orderID = order.id;
    var historySub =
        restaurantCollection.doc(uid).collection('history').doc(orderID);

    //duplicating order into history
    order.get().then((value) {
      historySub.set(value.data());
      historySub.update({
        'hid': orderID,
        'ready': true,
        'completed': false,
        'aid': FieldValue.delete(),
        'oid': FieldValue.delete(),
        // 'reason': 'null',
      });
    });

    //duplicating the fooditem from order into history
    order.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        restaurantCollection
            .doc(uid)
            .collection('history')
            .doc(orderID)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });
    deleteAccept();
  }

  //creating an history subcollection, duplicated from accept
  Future createHistoryFromDecline(String reason) async {
    var order = restaurantCollection.doc(uid).collection('decline').doc(fid);
    var orderID = order.id;
    var historySub =
        restaurantCollection.doc(uid).collection('history').doc(orderID);

    //duplicating order into history
    order.get().then((value) {
      historySub.set(value.data());
      historySub.update({
        'hid': orderID,
        'did': FieldValue.delete(),
        'oid': FieldValue.delete(),
        'reason': reason,
      });
    });

    //duplicating the fooditem from order into history
    order.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        restaurantCollection
            .doc(uid)
            .collection('history')
            .doc(orderID)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });
    deleteDecline();
  }

  //returning the list of history orders in a restaurant
  List<History> _historyListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String date =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return History(
        hid: doc.data()['hid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: date ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        accepted: doc.data()['accepted'] ?? false,
        reason: doc.data()['reason'] ?? '',
      );
    }).toList();
  }

  Stream<List<History>> get history {
    return restaurantCollection
        .doc(uid)
        .collection('history')
        .orderBy('pickUpTime', descending: true)
        .snapshots()
        .map(_historyListFromSS);
  }

  //returning a single history order
  History _historyDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String date =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);

    return History(
      hid: snapshot.data()['hid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: date ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      accepted: snapshot.data()['accepted'] ?? false,
      reason: snapshot.data()['reason'] ?? '',
    );
  }

  Stream<History> get historyData {
    return restaurantCollection
        .doc(uid)
        .collection('history')
        .doc(fid)
        .snapshots()
        .map(_historyDataFromSS);
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _historyFoodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get historyFoodItem {
    return restaurantCollection
        .doc(uid)
        .collection('history')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_historyFoodItemListFromSS);
  }

  //restaurant accept order
  // Future<void> acceptOrder() async {
  //   await restaurantCollection.doc(uid).collection('order').doc(fid).update({
  //     'accepted': true,
  //   });

  //   await customerCollection
  //       .doc(cuid)
  //       .collection('order')
  //       .doc(fid)
  //       .update({'accepted': true, 'ready': false, 'completed': false});
  // }

  //restaurant ready order
  Future<void> readyOrder() async {
    // restaurant order moved into history.
    // ready: true and completed: false are set there

    await customerCollection.doc(uid).collection('order').doc(fid).update({
      'ready': true,
    });
  }

  //customer pickup order / order completed
  Future<void> completeOrder() async {
    await restaurantCollection.doc(uid).collection('history').doc(fid).update({
      'completed': true,
    });
    await customerCollection.doc(cuid).collection('order').doc(fid).update({
      'completed': true,
    });
  }
}
