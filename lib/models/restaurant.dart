class Restaurant {
  final String name;
  final String email;
  final String password;
  final String location;
  final String phoneNum;
  final bool status;

  Restaurant(
      {this.name,
      this.email,
      this.password,
      this.location,
      this.phoneNum,
      this.status});
}

class RestaurantData {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String location;
  final String phoneNum;
  final bool status;

  RestaurantData(
      {this.uid,
      this.name,
      this.email,
      this.password,
      this.location,
      this.phoneNum,
      this.status});
}
