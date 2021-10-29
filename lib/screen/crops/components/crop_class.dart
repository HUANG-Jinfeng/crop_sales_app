import 'package:cloud_firestore/cloud_firestore.dart';

class Crop {
  Crop(
      this.crop_category_id,
      this.crop_id,
      this.crop_name,
      this.date,
      this.description,
      this.image,
      this.memo,
      this.price,
      this.volume
      );

  String crop_category_id;
  String crop_id;
  String crop_name;
  Timestamp date;
  String description;
  String image;
  String memo;
  int price;
  int volume;
}
