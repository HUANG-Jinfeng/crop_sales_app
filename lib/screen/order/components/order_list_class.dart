import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String uid;
  String order_id;
  String order_state;
  bool isPay;
  Timestamp isDate;
  int order_total_quantity;
  int order_total_price;
  //OrderDetail orderDetail;

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
/*class OrderDetail {
  String uid = '';
  String order_id = '';
  String order_state = '';
  bool isPay = false;
  int order_total_quantity = 0;
  int order_total_price = 0;

  OrderDetail(
      this.uid,
      this.order_id,
      this.order_state,
      this.isPay,
      this.order_total_quantity,
      this.order_total_price,
      );
}*/
