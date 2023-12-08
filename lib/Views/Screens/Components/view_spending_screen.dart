import 'package:budget_tracker_app_af_6/Model/spending_model.dart';
import 'package:budget_tracker_app_af_6/Views/Helpers/category_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class View_Spending_Screen extends StatefulWidget {
  const View_Spending_Screen({super.key});

  @override
  State<View_Spending_Screen> createState() => _View_Spending_ScreenState();
}

class _View_Spending_ScreenState extends State<View_Spending_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Spending Components....."),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Category_Helper.category_helper.fetchSpendingData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<SpendingModel>? data = snapshot.data;
            if (data!.isEmpty) {
              return Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://greatervalleychamber.com/wp-content/themes/Divi/includes/builder/images/premade.gif",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.purple.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID:- ${data[i].id}"),
                          Text("SPENDING NAME:- ${data[i].s_name}"),
                          Text("SPENDING AMOUNT:- ${data[i].s_amount} ₹"),
                          Text("SPENDING MODE:- ${data[i].s_mode}"),
                          Text("SPENDING TYPE:- ${data[i].s_type}"),
                          Text("SPENDING DATE:- ${data[i].date}"),
                          Text("SPENDING TIME:- ${data[i].time}"),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  Category_Helper.category_helper
                                      .DeleteSpendingData(id: data[i].id!);
                                  Get.snackbar("Budget Tracker App",
                                      "Data Deleted SuccessFully.....",
                                      backgroundColor:
                                          Colors.red.withOpacity(0.5));
                                });
                              },
                              child: Text("Delete Record"))
                        ],
                      ),
                    );
                  });
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
                    "https://i.pinimg.com/originals/8d/d3/ed/8dd3ed839851364b5653440ee4a6a5a9.gif",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
