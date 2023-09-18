import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:to_do_app/utils/textstyle.dart';
import 'package:to_do_app/utils/wigets.dart';

import '../../controller/task_add_con.dart';

class AddTaskBottomShhet extends StatefulWidget {
  const AddTaskBottomShhet({super.key});

  @override
  State<AddTaskBottomShhet> createState() => _AddTaskBottomShhetState();
}

class _AddTaskBottomShhetState extends State<AddTaskBottomShhet> {
  TaskAddController taskAddController = Get.put(TaskAddController());
  GlobalKey<FormState> form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return taskAddController.isLoad.value
          ? const CircularProgressIndicator()
          : Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: form,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add Task", style: AppTextStyle.mainTitle),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        const Divider(color: Colors.black38),
                        TextFeildData(
                          controller: taskAddController.title,
                          label: "Title",
                          hintText: "Enter Title",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFeildData(
                          controller: taskAddController.desc,
                          label: "Description",
                          hintText: "Enter Description",
                          validator: (value) {
                            if (taskAddController.title.text.isEmpty) {
                              return null;
                            }
                            if (value!.isEmpty) {
                              return "Enter Description";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFeildData(
                                  controller: taskAddController.date,
                                  label: "Select Date",
                                  readOnly: true,
                                  hintText: "Selecr Date",
                                  validator: (value) {
                                    if (taskAddController.title.text.isEmpty ||
                                        taskAddController.desc.text.isEmpty) {
                                      return null;
                                    }
                                    if (value!.isEmpty) {
                                      return "Select Date";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    taskAddController.showDateTimePicker(
                                        context: context);
                                  },
                                  suffixIcon: const Icon(Icons.date_range)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFeildData(
                                controller: taskAddController.timeSelect,
                                label: "Select Time",
                                readOnly: true,
                                hintText: "Selecr Time",
                                validator: (value) {
                                  if (taskAddController.title.text.isEmpty ||
                                      taskAddController.desc.text.isEmpty ||
                                      taskAddController.date.text.isEmpty) {
                                    return null;
                                  }
                                  if (value!.isEmpty) {
                                    return "Select Time";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  taskAddController.selectTime(context);
                                },
                                suffixIcon: const Icon(Icons.timer),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("Category", style: AppTextStyle.sub14Title),
                        const SizedBox(height: 5),
                        Column(
                          children: [
                            Wrap(
                                spacing: 0.0, // Spacing between items
                                runSpacing: 7.0, // Spacing between rows
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 45.w, right: 45.w),
                                    child: _buildRow([0, 1]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: _buildRow([2, 3, 4]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 46.w, right: 45.w),
                                    child: _buildRow([5, 6]),
                                  ),
                                ]),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                if (taskAddController.selectedList.isNotEmpty) {
                                  taskAddController.addTask();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Plaese select catagory",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue[100]),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2)))),
                            child: Text("Add",
                                style: AppTextStyle.mainbuttonStyle))
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }

  Row _buildRow(List<int> indices) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: indices.map((index) {
        return GestureDetector(
          onTap: () {
            taskAddController.addDataList(
                data: taskAddController.randomSeed[index]);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              height: 35.h,
              width: 95.w,
              decoration: BoxDecoration(
                color: taskAddController.selectedList
                        .contains(taskAddController.randomSeed[index])
                    ? Colors.blue[100]
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                child: Text(
                  "${taskAddController.randomSeed[index]}".toUpperCase(),
                  style: AppTextStyle.subTitle,
                ),
              )),
            ),
          ),
        );
      }).toList(),
    );
  }
}
