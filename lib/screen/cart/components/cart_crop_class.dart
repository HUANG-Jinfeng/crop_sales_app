/// 每个商品的详情
class Crop {
  Crop({
    //商品品牌id
    //required this.cropssSellerId,
    //商品品牌类型
    //required this.cropsSellerName,
    //商品品牌类型描述
    //required this.cropsSellerCompany,
    //商品id
    required this.cropsId,
    //商品名称
    required this.cropsName,
    //商品描述
    //required this.cropsDescription,
    //图片地址
    required this.imageUrl,
    //最小购买量
    required this.minBuyCount,
    //库存数量
    required this.stockQuantity,
    //价格
    required this.price,
  });

  //final String cropssSellerId;
  //final String cropsSellerName;
  //final String cropsSellerCompany;
  final String cropsId;
  final String cropsName;

  //final String cropsDescription;
  final String imageUrl;
  final String minBuyCount;
  final int stockQuantity;
  final int price;
}
