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
                        const SizedBox(
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
                          decoration: const InputDecoration(
                            hintText: 'Crop name*',
                          ),
                          onChanged: (text) {
                            model.crop_name = text;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Category*',
                          ),
                          onChanged: (text) {
                            model.crop_category_id = text;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Price (in PHP/KG)',
                          ),
                          onChanged: (text) {
                            model.price = int.parse(text);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Description*',
                          ),
                          onChanged: (text) {
                            model.description = text;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Volume*',
                          ),
                          onChanged: (text) {
                            model.volume = int.parse(text);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Memo*',
                          ),
                          onChanged: (text) {
                            model.memo = text;
                          },
                        ),
                        const SizedBox(
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
                          child: const Text('Save Crop'),
                        ),
                      ],
                    ),
                  ),
                  if (model.isLoading)
                    Container(
                      color: Colors.black54,
                      child: const Center(
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