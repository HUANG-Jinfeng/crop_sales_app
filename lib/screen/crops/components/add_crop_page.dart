import 'package:crop_sales_app/components/base_scaffold.dart';
import 'package:crop_sales_app/screen/crops/components/crop_add_model.dart';
import 'package:crop_sales_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCropPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCropModel>(
      create: (_) => AddCropModel(),

      child: BaseScaffold(
        //resizeToAvoidBottomInset: false,
        //backgroundColor: AppColors.primaryBackground,
        title: 'SELL CROPS',
        body: Center(
          child: SingleChildScrollView(
            reverse: true,

            child: Consumer<AddCropModel>(builder: (context, model, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: model.imageFile != null
                                ? Image.file(model.imageFile!)
                                : Container(
                              color: AppColors.primaryGreyText1,
                            ),
                          ),
                          onTap: () async {
                            print("Successful");
                            await model.pickImage();
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Crop name*',
                          ),
                          onChanged: (text) {
                            model.crop_name = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Category*',
                          ),
                          onChanged: (text) {
                            model.crop_category_id = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Price (in PHP/KG)',
                          ),
                          onChanged: (text) {
                            model.price = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Description*',
                          ),
                          onChanged: (text) {
                            model.description = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Volume*',
                          ),
                          onChanged: (text) {
                            model.volume = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Memo*',
                          ),
                          onChanged: (text) {
                            model.memo = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // 追加の処理
                            try {
                              model.startLoading();
                              await model.addCrop();
                              Navigator.of(context).pop(true);
                            } catch (e) {
                              print(e);
                              final snackBar = SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } finally {
                              model.endLoading();
                            }
                          },
                          child: Text('Save Crop'),
                        ),
                      ],
                    ),
                  ),
                  if (model.isLoading)
                    Container(
                      color: Colors.black54,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}


//child: SingleChildScrollView()