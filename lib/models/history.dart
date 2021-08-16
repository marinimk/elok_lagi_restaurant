class AcceptHistory {
  final String ahid;
  final String cuid;
  final String ruid;
  final String message;
  final String date;
  final String pickUpTime;
  final String orderTime;
  final double totalPrice;
  final bool ready;
  final bool completed;
  final bool accepted;
  final String reason;
  final bool pending;
  final String feedback;
  final int rating;

  AcceptHistory(
      {this.ahid,
      this.cuid,
      this.ruid,
      this.message,
      this.date,
      this.pickUpTime,
      this.orderTime,
      this.totalPrice,
      this.ready,
      this.completed,
      this.accepted,
      this.reason,
      this.pending,
      this.feedback,
      this.rating});
}

class DeclineHistory {
  final String dhid;
  final String cuid;
  final String ruid;
  final String message;
  final String date;
  final String pickUpTime;
  final String orderTime;
  final double totalPrice;
  final bool ready;
  final bool completed;
  final bool accepted;
  final String reason;
  final bool pending;

  DeclineHistory({
    this.dhid,
    this.cuid,
    this.ruid,
    this.message,
    this.date,
    this.pickUpTime,
    this.orderTime,
    this.totalPrice,
    this.ready,
    this.completed,
    this.accepted,
    this.reason,
    this.pending,
  });
}

class Dashboard {
  final int accept;
  final int decline;
  final double sales;

  Dashboard({this.accept, this.decline, this.sales});
}
