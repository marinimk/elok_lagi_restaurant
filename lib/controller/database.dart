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

  //? Dashboard

  Future createDashboard(int accept, int decline, double sales) async {
    return await restaurantCollection
        .doc(uid)
        .collection('dashboard')
        .doc(uid)
        .set({'accept': accept, 'decline': decline, 'sales': sales});
  }

  Future updateDashboard() async {
    int accept = await noOfAccepted();
    int decline = await noOfDeclined();
    double sales = await calcSalesTotalPrice();

    return restaurantCollection.doc(uid).collection('dashboard').doc(uid).set({
      'accept': accept,
      'decline': decline,
      'sales': sales,
    });
  }

  // retrieving the number of accepted orders
  Future noOfAccepted() async {
    QuerySnapshot accept =
        await restaurantCollection.doc(uid).collection('acceptHistory').get();
    int noOfAccept = accept.docs.length;
    return noOfAccept;
  }

  Future noOfDeclined() async {
    QuerySnapshot decline =
        await restaurantCollection.doc(uid).collection('declineHistory').get();
    int noOfDecline = decline.docs.length;
    return noOfDecline;
  }

  //calculating the total price in the cart
  Future calcSalesTotalPrice() async {
    QuerySnapshot accept =
        await restaurantCollection.doc(uid).collection('acceptHistory').get();
    double totalSales = 0;

    for (int i = 0; i < accept.docs.length; i++) {
      var a = accept.docs[i];
      var snapshot = await restaurantCollection
          .doc(uid)
          .collection('acceptHistory')
          .doc(a.id)
          .get();
      double price = snapshot.data()['totalPrice'];
      totalSales = totalSales + price;
    }
    print('total sales: $totalSales');
    return totalSales;
  }

  Dashboard _dashboardDataFromSS(DocumentSnapshot snapshot) {
    return Dashboard(
      accept: snapshot.data()['accept'] ?? 0,
      decline: snapshot.data()['decline'] ?? 0,
      sales: snapshot.data()['sales'] ?? 0.00,
    );
  }

  Stream<Dashboard> get dashboard {
    return restaurantCollection
        .doc(uid)
        .collection('dashboard')
        .doc(uid)
        .snapshots()
        .map(_dashboardDataFromSS);
  }

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
    var orderCust = customerCollection.doc(cuid).collection('order').doc(fid);
    await orderCust.update({'accepted': true, 'pending': false});

    var orderRest = restaurantCollection.doc(uid).collection('order').doc(fid);
    var acceptRestSub =
        restaurantCollection.doc(uid).collection('accept').doc(fid);

    await orderRest.get().then((value) {
      acceptRestSub.set({
        'aid': value.data()['oid'],
        'oid': value.data()['oid'],
        'cuid': value.data()['cuid'],
        'ruid': value.data()['ruid'],
        'message': value.data()['message'],
        'date': value.data()['date'],
        'pickUpTime': value.data()['pickUpTime'],
        'orderTime': value.data()['orderTime'],
        'totalPrice': value.data()['totalPrice'],
        'accepted': true,
        'ready': false,
        'completed': false,
        'pending': false
      });
    });

    //duplicating the fooditem from order into history
    orderRest.collection('fooditem').get().then((val) {
      val.docs.forEach((element) {
        acceptRestSub.collection('fooditem').doc().set(element.data());
      });
    });
    deleteOrderRestaurant();
  }

  //returning the list of history orders in a restaurant
  List<Accept> _acceptListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return Accept(
        aid: doc.data()['aid'] ?? '',
        oid: doc.data()['oid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: doc.data()['date'] ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        accepted: doc.data()['accepted'] ?? true,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        pending: doc.data()['pending'] ?? false,
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

    String datee =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);
    return Accept(
      aid: snapshot.data()['hid'] ?? '',
      oid: snapshot.data()['oid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: datee ?? '00/00/0000',
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
  //creating an decline subcollection, duplicated from order
  Future<void> createDecline() async {
    var orderCust = customerCollection.doc(cuid).collection('order').doc(fid);
    await orderCust.update({'accepted': false, 'pending': false});

    var orderRest = restaurantCollection.doc(uid).collection('order').doc(fid);
    var declineRestSub =
        restaurantCollection.doc(uid).collection('decline').doc(fid);

    await orderRest.get().then((value) {
      declineRestSub.set({
        'did': value.data()['oid'],
        'oid': value.data()['oid'],
        'cuid': value.data()['cuid'],
        'ruid': value.data()['ruid'],
        'message': value.data()['message'],
        'date': value.data()['date'],
        'pickUpTime': value.data()['pickUpTime'],
        'orderTime': value.data()['orderTime'],
        'totalPrice': value.data()['totalPrice'],
        'accepted': false,
        'ready': false,
        'completed': false,
        'pending': false
      });
    });

    //duplicating the fooditem from order into history
    orderRest.collection('fooditem').get().then((val) {
      val.docs.forEach((element) {
        declineRestSub.collection('fooditem').doc().set(element.data());
      });
    });
    // deleteOrderCustomer();
    deleteOrderRestaurant();
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

      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return Decline(
        did: doc.data()['did'] ?? '',
        oid: doc.data()['oid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: doc.data()['date'] ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        accepted: doc.data()['accepted'] ?? false,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        pending: doc.data()['pending'] ?? false,
      );
    }).toList();
  }

  Stream<List<Decline>> get decline {
    return restaurantCollection
        .doc(uid)
        .collection('decline')
        // .orderBy('pickUpTime', descending: false)
        .snapshots()
        .map(_declineListFromSS);
  }

  //returning a single decline order
  Decline _declineDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String datee =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);
    return Decline(
      did: snapshot.data()['did'] ?? '',
      oid: snapshot.data()['oid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: datee ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      accepted: snapshot.data()['accepted'] ?? false,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      pending: snapshot.data()['pending'] ?? false,
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
  void deleteOrderRestaurant() {
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

  void deleteOrderCustomer() {
    var toDelete = customerCollection.doc(cuid).collection('order').doc(fid);

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
    var toDeleteRest =
        restaurantCollection.doc(uid).collection('accept').doc(fid);
    var toDeleteCust =
        customerCollection.doc(cuid).collection('accept').doc(fid);

    //delete the fooditems in order
    Future<QuerySnapshot> foodItemInRestAccept =
        toDeleteRest.collection('fooditem').get();
    foodItemInRestAccept.then((value) {
      value.docs.forEach((element) {
        toDeleteRest.collection('fooditem').doc(element.id).delete();
      });
    });
    Future<QuerySnapshot> foodItemInCustAccept =
        toDeleteCust.collection('fooditem').get();
    foodItemInCustAccept.then((value) {
      value.docs.forEach((element) {
        toDeleteCust.collection('fooditem').doc(element.id).delete();
      });
    });

    //delete order
    toDeleteRest.delete();
    toDeleteCust.delete();
  }

  //delete order after history was made
  void deleteDecline() {
    var toDeleteRest =
        restaurantCollection.doc(uid).collection('decline').doc(fid);
    var toDeleteCust =
        customerCollection.doc(cuid).collection('decline').doc(fid);

    //delete the fooditems in order
    Future<QuerySnapshot> foodItemInRestDecline =
        toDeleteRest.collection('fooditem').get();
    foodItemInRestDecline.then((value) {
      value.docs.forEach((element) {
        toDeleteRest.collection('fooditem').doc(element.id).delete();
      });
    });
    Future<QuerySnapshot> foodItemInCustDecline =
        toDeleteCust.collection('fooditem').get();
    foodItemInCustDecline.then((value) {
      value.docs.forEach((element) {
        toDeleteCust.collection('fooditem').doc(element.id).delete();
      });
    });

    //delete order
    toDeleteRest.delete();
    toDeleteCust.delete();
  }

//? History @ Orders that are completed
  //creating an history subcollection, duplicated from accept
  Future createHistoryFromAccept() async {
    var orderRest = restaurantCollection.doc(uid).collection('accept').doc(fid);
    var historyRestSub =
        restaurantCollection.doc(uid).collection('acceptHistory').doc(fid);

    //duplicating order into history
    orderRest.get().then((value) {
      historyRestSub.set({
        'ahid': fid,
        'cuid': value.data()['cuid'],
        'ruid': value.data()['ruid'],
        'message': value.data()['message'],
        'date': value.data()['date'],
        'pickUpTime': value.data()['pickUpTime'],
        'orderTime': value.data()['orderTime'],
        'totalPrice': value.data()['totalPrice'],
        'ready': true,
        'completed': false,
        'accepted': value.data()['accepted'],
        'pending': value.data()['pending']
      });
    });

    //duplicating the fooditem from order into history
    orderRest.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        restaurantCollection
            .doc(uid)
            .collection('acceptHistory')
            .doc(fid)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });

    await customerCollection
        .doc(cuid)
        .collection('order')
        .doc(fid)
        .update({'ready': true});

    deleteAccept();
  }

  //creating an history subcollection, duplicated from accept
  Future createHistoryFromDecline(String reason) async {
    var orderRest =
        restaurantCollection.doc(uid).collection('decline').doc(fid);
    var historyRestSub =
        restaurantCollection.doc(uid).collection('declineHistory').doc(fid);

    var orderCust = customerCollection.doc(cuid).collection('order').doc(fid);
    var historyCustSub =
        customerCollection.doc(cuid).collection('declineHistory').doc(fid);

    //duplicating order into history
    orderRest.get().then((value) {
      // historyRestSub.set(value.data());
      historyRestSub.set({
        'dhid': fid,
        'cuid': value.data()['cuid'],
        'ruid': value.data()['ruid'],
        'message': value.data()['message'],
        'date': value.data()['date'],
        'pickUpTime': value.data()['pickUpTime'],
        'orderTime': value.data()['orderTime'],
        'totalPrice': value.data()['totalPrice'],
        'ready': false,
        'completed': false,
        'accepted': false,
        'pending': false,
        'reason': reason
      });

      historyCustSub.set({
        'dhid': fid,
        'cuid': cuid,
        'ruid': value.data()['ruid'],
        'message': value.data()['message'],
        'date': value.data()['date'],
        'pickUpTime': value.data()['pickUpTime'],
        'orderTime': value.data()['orderTime'],
        'totalPrice': value.data()['totalPrice'],
        'ready': false,
        'completed': false,
        'accepted': false,
        'pending': false,
        'reason': reason
      });
    });

    //duplicating the fooditem from order into history
    orderRest.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        historyRestSub.collection('fooditem').doc().set(element.data());
      });
    });

    //duplicating the fooditem from order into history
    orderCust.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        historyCustSub.collection('fooditem').doc().set(element.data());
      });
    });

    deleteDecline();
    deleteOrderCustomer();
  }

  //returning the list of history orders in a restaurant
  List<AcceptHistory> _acceptHistoryListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return AcceptHistory(
        ahid: doc.data()['ahid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: doc.data()['date'] ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        accepted: doc.data()['accepted'] ?? false,
        reason: doc.data()['reason'] ?? '',
        pending: doc.data()['pending'] ?? true,
      );
    }).toList();
  }

  Stream<List<AcceptHistory>> get acceptHistory {
    return restaurantCollection
        .doc(uid)
        .collection('acceptHistory')
        .orderBy('pickUpTime', descending: true)
        .snapshots()
        .map(_acceptHistoryListFromSS);
  }

  //returning a single history order
  AcceptHistory _acceptHistoryDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String datee =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);
    return AcceptHistory(
      ahid: snapshot.data()['ahid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: snapshot.data()['date'] ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      accepted: snapshot.data()['accepted'] ?? false,
      reason: snapshot.data()['reason'] ?? '',
      pending: snapshot.data()['pending'] ?? true,
      feedback: snapshot.data()['feedback'] ?? 'No feedback',
      rating: snapshot.data()['rating'] ?? 0,
    );
  }

  Stream<AcceptHistory> get acceptHistoryData {
    return restaurantCollection
        .doc(uid)
        .collection('acceptHistory')
        .doc(fid)
        .snapshots()
        .map(_acceptHistoryDataFromSS);
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _acceptHistoryFoodItemListFromSS(QuerySnapshot snapshot) {
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

  Stream<List<FoodItem>> get acceptHistoryFoodItem {
    return restaurantCollection
        .doc(uid)
        .collection('acceptHistory')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_acceptHistoryFoodItemListFromSS);
  }

  //returning the list of history orders in a restaurant
  List<DeclineHistory> _declineHistoryListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String datee =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return DeclineHistory(
        dhid: doc.data()['dhid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: doc.data()['date'] ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        accepted: doc.data()['accepted'] ?? false,
        reason: doc.data()['reason'] ?? '',
        pending: doc.data()['pending'] ?? true,
      );
    }).toList();
  }

  Stream<List<DeclineHistory>> get declineHistory {
    return restaurantCollection
        .doc(uid)
        .collection('declineHistory')
        .orderBy('date', descending: true)
        // .orderBy('pickUpTime', descending: true)
        .snapshots()
        .map(_declineHistoryListFromSS);
  }

  //returning a single history order
  DeclineHistory _declineHistoryDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String datee =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);
    return DeclineHistory(
      dhid: snapshot.data()['dhid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: snapshot.data()['date'] ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      accepted: snapshot.data()['accepted'] ?? false,
      reason: snapshot.data()['reason'] ?? '',
      pending: snapshot.data()['pending'] ?? true,
    );
  }

  Stream<DeclineHistory> get declineHistoryData {
    return restaurantCollection
        .doc(uid)
        .collection('declineHistory')
        .doc(fid)
        .snapshots()
        .map(_declineHistoryDataFromSS);
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _declineHistoryFoodItemListFromSS(QuerySnapshot snapshot) {
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

  Stream<List<FoodItem>> get declineHistoryFoodItem {
    return restaurantCollection
        .doc(uid)
        .collection('declineHistory')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_declineHistoryFoodItemListFromSS);
  }

  //? order status

  //customer pickup order / order completed
  Future completeOrder() async {
    await restaurantCollection
        .doc(uid)
        .collection('acceptHistory')
        .doc(fid)
        .update({'completed': true});
  }
}
