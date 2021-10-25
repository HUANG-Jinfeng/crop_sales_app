
/// The user's shopping cart information.
class Cart {
  Cart(
      this.uid,
      this.cart_id,
      this.crop_ids,
      this.date,
      this.total_price,
      this.total_quantity,
      );

  String uid;
  String cart_id;
  String crop_ids;
  String date;
  String total_price;
  String total_quantity;
}

// The number and price of items in the shopping cart.
class CartCropDetial {
  CartCropDetial (
      this.crop_id,
      this.crop_name,
      this.crop_desc,
      this.crop_imageURL,
      this.crop_maxBuyCount,
      this.single_quantity,
      this.single_price,
      );

  String crop_id;
  String crop_name;
  String crop_desc;
  String crop_imageURL;
  String crop_maxBuyCount;
  int single_quantity;
  String single_price;
}
