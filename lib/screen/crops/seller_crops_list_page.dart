import 'package:cached_network_image/cached_network_image.dart';
import 'package:crop_sales_app/components/my_loading.dart';
import 'package:crop_sales_app/screen/crops/components/crop_class.dart';
import 'package:crop_sales_app/screen/crops/components/crops_list_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:provider/provider.dart';

class SellerCropListPage extends StatelessWidget {
  const SellerCropListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CropListModel>(
      create: (_) => CropListModel()..fetchCropList(),
      child: RefreshConfiguration(
        hideFooterWhenNotFull: true,
        enableBallisticLoad: true,
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
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
                              Container(
                                height: 80.0,
                                margin: EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 0.0,
                                    bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 10.0,
                                      top: 10,
                                      child: Container(
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
                                      top: 10,
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

                                    /// description
                                    Positioned(
                                      left: 90,
                                      top: 33,
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

                                    /// Inventory
                                    Positioned(
                                      left: 90,
                                      bottom: 10,
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
                                              text: crop.volume.toString(),
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// crop Price
                                    Positioned(
                                      right: 12,
                                      top: 12.0,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'PHP ',
                                          style: TextStyle(
                                            color: AppColors.priceColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: crop.price.toString(),
                                              style: TextStyle(
                                                color: AppColors.priceColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// add button
                                    Positioned(
                                      right: 12,
                                      bottom: -3.0,
                                      child: FlatButton(
                                        minWidth: 5,
                                        height: 20,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        onPressed: () => {},
                                        color: AppColors.primaryColor,
                                        child: Center(
                                          child: Text(
                                            'Edit',
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
      ),
    );
  }
}
