import 'package:budget_tracker_app_af_6/Model/spending_model.dart';
import 'package:budget_tracker_app_af_6/Views/Helpers/category_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add_Spending_Components extends StatefulWidget {
  const Add_Spending_Components({super.key});

  @override
  State<Add_Spending_Components> createState() =>
      _Add_Spending_ComponentsState();
}

class _Add_Spending_ComponentsState extends State<Add_Spending_Components> {
  DateTime iniaialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController s_name_control = TextEditingController();
  TextEditingController s_amount_control = TextEditingController();
  String? s_name;
  String? s_amount;
  String? s_mode;
  String? s_type;
  DateTime? date;
  TimeOfDay? time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            SpendingModel spendingModel = SpendingModel(
              date: "${date?.day}/${date?.month}/${date?.year}",
              s_amount: s_amount!,
              s_mode: s_mode!,
              s_name: s_name!,
              s_type: s_type!,
              time: "${time?.hour}:${date?.minute}",
            );
            int res = await Category_Helper.category_helper
                .insertSpending(data: spendingModel);
            Get.snackbar(
                "Budget Tracker App", "Data SuccessFully Added at ID:- $res...",
                backgroundColor: Colors.orange.withOpacity(0.5));
            setState(() {
              s_name = null;
              s_amount = null;
              s_mode = null;
              s_type = null;
              date = null;
              time = null;
            });
            s_name_control.clear();
            s_amount_control.clear();
          } else {
            Get.snackbar("Budget Tracker App", "Data Insertion Failed.....",
                backgroundColor: Colors.red.withOpacity(0.5));
          }
        },
        label: Text(
          "Add",
        ),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Add Spending Components...."),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  onSaved: (val) {
                    s_name = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Spending Name First......";
                    }
                  },
                  controller: s_name_control,
                  decoration: InputDecoration(
                    hintText: "Enter Spending Name....",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                TextFormField(
                  onSaved: (val) {
                    s_amount = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Spending AmountFirst......";
                    }
                  },
                  controller: s_amount_control,
                  decoration: InputDecoration(
                    hintText: "Enter Spending Amount....",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: iniaialDate,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2030),
                        );
                        setState(() {
                          date = dateTime;
                        });
                      },
                      icon: Icon(Icons.date_range),
                    ),
                    (date == null)
                        ? Container()
                        : Text(
                            "${date?.day}/${date?.month}/${date?.year}",
                            style: TextStyle(fontSize: 20),
                          )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        TimeOfDay? timeofday = await showTimePicker(
                          context: context,
                          initialTime: initialTime,
                        );
                        setState(() {
                          time = timeofday;
                        });
                        print("===================================");
                        print("$time");
                        print("===================================");
                      },
                      icon: Icon(Icons.watch),
                    ),
                    (time == null)
                        ? Container()
                        : Text(
                            "${time?.hour} : ${time?.minute} ",
                          ),
                  ],
                ),
                DropdownButton(
                  icon: Icon(Icons.wallet),
                  hint: Text("Select  "),
                  value: s_mode,
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text(
                        "Online",
                      ),
                      value: "online",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Cash",
                      ),
                      value: "cash",
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      s_mode = value;
                    });
                  },
                ),
                DropdownButton(
                  icon: Icon(Icons.expand_circle_down),
                  hint: Text("Select"),
                  value: s_type,
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text(
                        "Income",
                      ),
                      value: "income",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Expance",
                      ),
                      value: "expance",
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      s_type = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
