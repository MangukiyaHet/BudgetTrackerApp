import 'package:budget_tracker_app_af_6/Model/category_data_model.dart';
import 'package:budget_tracker_app_af_6/Views/Helpers/category_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class View_Data_Screen extends StatefulWidget {
  const View_Data_Screen({super.key});

  @override
  State<View_Data_Screen> createState() => _View_Data_ScreenState();
}

class _View_Data_ScreenState extends State<View_Data_Screen> {
  TextEditingController updateController = TextEditingController();
  late Future<List<CategoryModel>> getAllData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData = Category_Helper.category_helper.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Tracker App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      getAllData = Category_Helper.category_helper
                          .FetchSearchedData(data: val);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "search category here......",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              )),
          Expanded(
            flex: 10,
            child: FutureBuilder(
              future: getAllData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  List<CategoryModel>? data = snapshot.data;
                  if (data!.isEmpty) {
                    return Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://i.gifer.com/B0eS.gif",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) => ListTile(
                          title: Text("${data[i].category_name}"),
                          subtitle: Text("${data[i].id}"),
                          trailing: IconButton(
                            onPressed: () {
                              Get.dialog(AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          Category_Helper.category_helper
                                              .UpdateAllData(
                                                  data: updateController.text,
                                                  id: data[i].id!);
                                        });
                                        Get.back();
                                      },
                                      child: Text("Done"))
                                ],
                                icon: Icon(Icons.edit),
                                title: Text("Update Data Here"),
                                content: TextFormField(
                                  controller: updateController,
                                ),
                              ));
                            },
                            // onPressed: () {
                            //   setState(() {
                            //     Category_Helper.category_helper
                            //         .DeleteAllData(id: data[i].id!);
                            //   });
                            //   Get.snackbar(
                            //     "Budget Tracker App",
                            //     "Data Deleted SuccessFully",
                            //     snackPosition: SnackPosition.BOTTOM,
                            //   );
                            // },
                            icon: Icon(Icons.delete),
                          ),
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: MemoryImage(
                                      data[i].category_image,
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                    );
                  }
                }
                return Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://gifdb.com/images/thumbnail/happy-cat-peach-cute-patiently-waiting-8p2lelgq0g0ii5kk.gif",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
