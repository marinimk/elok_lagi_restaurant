class Restaurant {
  final String name;
  final String email;
  final String password;
  final String category;
  final String location;
  final String phoneNum;
  final bool status;
  final String imageURL;

  Restaurant(
      {this.name,
      this.email,
      this.password,
      this.category,
      this.location,
      this.phoneNum,
      this.status,
      this.imageURL});
}

class RestaurantData {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String category;
  final String location;
  final String phoneNum;
  final bool status;
  final String imageURL;

  RestaurantData(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.category,
      this.location,
      this.phoneNum,
      this.status,
      this.imageURL});
}
