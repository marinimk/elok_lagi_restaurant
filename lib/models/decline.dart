class Decline {
  final String did;
  final String oid;
  final String cuid;
  final String ruid;
  final String message;
  final String date;
  final String pickUpTime;
  final String orderTime;
  final double totalPrice;
  final bool accepted;
  final bool ready;
  final bool completed;
  final bool pending;

  Decline({
    this.did,
    this.oid,
    this.cuid,
    this.ruid,
    this.message,
    this.date,
    this.pickUpTime,
    this.orderTime,
    this.totalPrice,
    this.accepted,
    this.ready,
    this.completed,
    this.pending,
  });
}
