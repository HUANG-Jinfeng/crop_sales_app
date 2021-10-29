class Orders {
  String? uid;
  String? order_id;
  String? order_state;
  bool? isPay;
  String? isDate;
  int? order_total_quantity;
  int? order_total_price;
  //OrderDetail? orderDetail;

  Orders(
    this.uid,
    this.order_id,
    this.order_state,
    this.isPay,
    this.isDate,
    this.order_total_quantity,
    this.order_total_price,
    //this.orderDetail,
  );
}
class OrderDetail {
  String id;
  String name;
  String description;
  String url;
  int price;
  int quantity;

  OrderDetail(
    this.id,
    this.name,
    this.description,
    this.url,
    this.price,
    this.quantity,
  );
}
