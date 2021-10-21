User user = User();
///数据模型，实战中根据自己的项目来创建，不要直接放在一个文件里
class UserInfo {
  String number;
  bool crop;
  String price;
  String date;
  String kg;

  UserInfo(this.number, this.crop, this.price, this.date,
      this.kg);
}

class User {
  List<UserInfo> userInfo = [];

  void initData(int size) {
    for (int i = 0; i < size; i++) {
      userInfo.add(UserInfo(
          "${i + 1}", i % 3 == 0, 'PHP 12', '2021-09-28', 'N/A'));
    }
  }

  void loadMore() {
    int bigIndex = user.userInfo.length;
    for (int i = 0; i < 5; i++) {
      user.userInfo.add(UserInfo(
          "${bigIndex + i + 1}", i % 3 == 0, 'PHP 2980', '2021-09-28', 'N/A'));
    }
  }
}