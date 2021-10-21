import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_sales_app/components/my_loading.dart';
import 'package:crop_sales_app/components/my_toast.dart';
import 'package:crop_sales_app/screen/crops/components/add_crop_page.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:provider/provider.dart';

class CropListPage extends StatelessWidget {
  const CropListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CropListModel>(
        create: (_) => CropListModel()..fetchCropList(),
        child: RefreshConfiguration(
          hideFooterWhenNotFull: true, // Viewport不满一屏时,禁用上拉加载更多功能
          enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Consumer<CropListModel>(builder: (context, model, child) {
                final List<Crop>? crops = model.crops;
                int _counter = 1;
                if (crops == null) {
                  return MyLoadingWidget();
                }
                final List<Widget> widgets = crops
                    .map((crop) => Column(
                              children: <Widget>[
                            /*Container(
                              color: Colors.white,
                              child: Text(crop.crop_id,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: Color(0xFF1C2026))),
                              width: 55,
                              height: 38,
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                            ),*/
                                Container(
                                  height: 70.0,
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 15,
                                      bottom: 0.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF7F7F7),
//color: AppColors.primaryBackground,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 10.0,
                                        top: 5.0,
                                        child: Container(
//color: Colors.red,
                                          child: CachedNetworkImage(
                                            placeholder: (_, __) => Image.asset(
                                                'assets/images/order/jiazaizhong.png'),
                                            imageUrl: crop.image,
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                      ),

                                      /// crop Name
                                      Positioned(
                                        left: 90,
                                        top: 5,
                                        child: Text(
                                          crop.crop_name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryText),
                                        ),
                                      ),

                                      /// crop ID
                                      Positioned(
                                        left: 90,
                                        top: 28,
                                        child: Text(
                                          crop.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryGreyText),
                                        ),
                                      ),

                                      /// crop Price
                                      Positioned(
                                          right: 10,
                                          top: 8.0,
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'PHP ',
                                                style: TextStyle(
                                                  color: AppColors.priceColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: crop.price,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.priceColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ]),
                                          )),
                                      Positioned(
// Inventory crop_volume
                                        left: 90,
                                        top: 50.0,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Inventory: ",
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: crop.volume,
                                                style: TextStyle(
                                                  color: Color(0xFF121212),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: " Kg",
                                                    style: TextStyle(
                                                      color: Color(0xFF121212),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 32.0,
                                        child: FlatButton(
                                          minWidth: 5,
                                          height: 10,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          onPressed: () => {
                                            model.addCropToCart(
                                                crop.crop_id,
                                                crop.crop_name,
                                                crop.image,
                                                crop.price,
                                                _counter,
                                                crop.volume),
                                            model.addTotalPrice(crop.price,_counter),
                                          },
                                          color: AppColors.primaryColor,
                                          child: Center(
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ) //Text(book.title),
                        )
                    .toList();
                return ListView(
                  children: widgets,
                );
              }),
            ),
          ),
        ));
  }
}
