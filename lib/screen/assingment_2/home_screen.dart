import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/controller/home_con.dart';
import 'package:to_do_app/screen/assingment_2/add_task_bottom_sheet.dart';
import 'package:to_do_app/utils/textstyle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController search = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  List searchList = [];
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  searchData(String value, data) async {
    List search1 = [];
    if (value.isNotEmpty) {
      for (int i = 0; i < data.docs.length; i++) {
        if (data.docs[i]
            .data()["title"]
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase())) {
          search1.add(data.docs[i].data());
        }
      }
      setState(() {
        searchList = search1;
      });
    } else {
      setState(() {
        searchList.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: const Text("To Do App"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[100],
          onPressed: () async {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                context: context,
                builder: (context) => const AddTaskBottomShhet());
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: search,
                style: AppTextStyle.sub14Title,
                cursorHeight: 18,
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    final data = await FirebaseFirestore.instance
                        .collection('data')
                        .get();
                    searchData(value, data);
                  } else {
                    setState(() {
                      searchList = [];
                    });
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
            TabBar(
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.blue[100],
                labelColor: Colors.black,
                overlayColor:
                    MaterialStateProperty.all(Colors.blue.withOpacity(0.1)),
                controller: tabController,
                tabs: const [Tab(text: "Process"), Tab(text: "Complate")]),
            Expanded(
              child: search.text.isNotEmpty || searchList.isNotEmpty
                  ? searchList.isEmpty
                      ? Center(
                          child: Text("No Serch Found",
                              style: AppTextStyle.sub14Title),
                        )
                      : serchListData()
                  : TabBarView(
                      controller: tabController,
                      children: [
                        processData(0),
                        processData(1),
                      ],
                    ),
            )
          ],
        ));
  }

  checkAlrm({required Map data}) async {
    final cureent = DateTime.now();
    if ("${cureent.day}-${cureent.month}-${cureent.year}" == data["date"]) {
      if ("${cureent.hour}:${cureent.minute}" ==
          "${data["time"]}".split(" ")[0]) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/tune/tune_2.mp3"),
          autoStart: true,
          showNotification: true,
        );
      }
    }
  }

  processData(int i) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('data').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List data = [];
            if (i == 0) {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                if (snapshot.data!.docs[i].data()["status"] == "Pending") {
                  data.add(snapshot.data!.docs[i].data());
                }
              }
            } else {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                if (snapshot.data!.docs[i].data()["status"] != "Pending") {
                  data.add(snapshot.data!.docs[i].data());
                }
              }
            }
            if (snapshot.data!.docs.isEmpty || data.isEmpty) {
              return Center(
                child: Text("No Data Found", style: AppTextStyle.sub14Title),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var obbject = data[index];
                checkAlrm(data: obbject);
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        dense: true,
                        isThreeLine: true,
                        leading: Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.only(right: 7, top: 6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: obbject["catogory"] == "homework"
                                  ? Colors.grey[700]
                                  : obbject["catogory"] == "gym"
                                      ? Colors.pink[700]
                                      : obbject["catogory"] == "school"
                                          ? Colors.yellow[700]
                                          : obbject["catogory"] == "sleping"
                                              ? Colors.blue[700]
                                              : Colors.green[900]),
                        ),
                        title: Text("${obbject["title"]}",
                            style: AppTextStyle.mainTitle),
                        subtitle: Text("${obbject["desc"]}",
                            style: AppTextStyle.subTitle),
                        trailing: const Icon(Icons.alarm),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Time : ${obbject["date"]} ${obbject["time"]}",
                              style: AppTextStyle.sub14Title),
                          if(obbject["status"] == "Pending")    
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  homeController.taskDOne(
                                      object: obbject, index: index);
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.green[600]),
                                    child: Text("Done",
                                        style: AppTextStyle.buttonStyle)),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  homeController.taskcanceld(
                                      object: obbject, index: index);
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.red[600]),
                                    child: Text("Cancel",
                                        style: AppTextStyle.buttonStyle)),
                              ),
                            ],
                          )
                          else
                           Text("${obbject["status"]}",
                               style: obbject["status"] != "Complete"
                                   ? AppTextStyle.redStatus
                                   : AppTextStyle.greenStutas)
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  serchListData() {
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        var obbject = searchList[index];
        checkAlrm(data: obbject);
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(7)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                dense: true,
                isThreeLine: true,
                leading: Container(
                  height: 15,
                  width: 15,
                  margin: const EdgeInsets.only(right: 7, top: 6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: obbject["catogory"] == "homework"
                          ? Colors.grey[700]
                          : obbject["catogory"] == "gym"
                              ? Colors.pink[700]
                              : obbject["catogory"] == "school"
                                  ? Colors.yellow[700]
                                  : obbject["catogory"] == "sleping"
                                      ? Colors.blue[700]
                                      : Colors.green[900]),
                ),
                title:
                    Text("${obbject["title"]}", style: AppTextStyle.mainTitle),
                subtitle:
                    Text("${obbject["desc"]}", style: AppTextStyle.subTitle),
                trailing: const Icon(Icons.alarm),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Time : ${obbject["date"]} ${obbject["time"]}",
                      style: AppTextStyle.sub14Title),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeController.taskDOne(
                              object: obbject, index: index);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.green[600]),
                            child:
                                Text("Done", style: AppTextStyle.buttonStyle)),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          homeController.taskcanceld(
                              object: obbject, index: index);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.red[600]),
                            child: Text("Cancel",
                                style: AppTextStyle.buttonStyle)),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
