import 'package:budget_tracker_app_af_6/Model/category_data_model.dart';
import 'package:budget_tracker_app_af_6/Views/Helpers/category_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Globals/Global.dart';

class Add_Data_Screen extends StatefulWidget {
  const Add_Data_Screen({super.key});

  @override
  State<Add_Data_Screen> createState() => _Add_Data_ScreenState();
}

class _Add_Data_ScreenState extends State<Add_Data_Screen> {
  int? SelectedImage;
  TextEditingController category = TextEditingController();
  String? categoryName;
  ByteData? imgByte;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            Uint8List categoryImage =
                Uint8List.fromList(imgByte!.buffer.asUint8List());

            CategoryModel categoryModel = CategoryModel(
              category_name: categoryName!,
              category_image: categoryImage,
            );

            int res = await Category_Helper.category_helper.insertData(
              data: categoryModel,
            );
            Get.snackbar(
              "Budget Tracker App",
              "Data is Added SuccessFully $res.....",
              snackPosition: SnackPosition.BOTTOM,
            );

            category.clear();
          } else {
            Get.snackbar(
              "Budget Tracker App",
              "Data Insertion Failed...",
              backgroundColor: Colors.orange,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Add Data Here.."),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: category,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Catewgory Name First....";
                      }
                    },
                    onSaved: (val) {
                      categoryName = val;
                    },
                    decoration: InputDecoration(
                        labelText: "Category Name",
                        hintText: "Enter Category Name.......",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                ),
                itemCount: Globals.allCategories.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () async {
                    imgByte = await rootBundle.load(Globals.allCategories[i]);
                    setState(() {
                      SelectedImage = i;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular((SelectedImage == i) ? 70 : 30),
                      border: Border.all(
                        width: (SelectedImage == i) ? 5 : 4,
                        color:
                            (SelectedImage == i) ? Colors.black : Colors.grey,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          "${Globals.allCategories[i]}",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
