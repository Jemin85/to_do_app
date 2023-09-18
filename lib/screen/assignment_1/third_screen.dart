import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/textstyle.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
    List firstList = ["subcatogroies", "Location"];
  List secoundList = [
    "Medical Science",
    "Anatomy",
    "Space Science",
    "Microbiology",
    "Batany",
    "Zoology"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.only(left: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
          alignment: Alignment.center,
          child: const Icon(Icons.arrow_back_ios, size: 18),
        ),
        title: Text("Filter", style: AppTextStyle.appbar),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text("Clear All",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromARGB(255, 13, 87, 214),
                    fontWeight: FontWeight.w500,
                  )),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: const Color.fromARGB(255, 13, 87, 214))),
                child: Text("Cancel",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color.fromARGB(255, 13, 87, 214),
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 13, 87, 214)),
                child: Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
              child: Container(
            color: Colors.grey[50],
            child: ListView.builder(
                itemCount: firstList.length,
                itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: index == 0
                                  ? BorderSide.none
                                  : const BorderSide(
                                      color:
                                          Color.fromARGB(255, 221, 220, 220)),
                              top: const BorderSide(
                                  color: Color.fromARGB(255, 221, 220, 220)))),
                      child: Text("${firstList[index]}",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: index == 0
                                ? const Color.fromARGB(255, 13, 87, 214)
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                    )),
          )),
          Expanded(
              child: Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: secoundList.length,
                itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromARGB(255, 221, 220, 220)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text("${secoundList[index]}",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: index == 0 || index == 2
                                      ? const Color.fromARGB(255, 13, 87, 214)
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          if (index == 0 || index == 2)
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: Color.fromARGB(255, 13, 87, 214),
                            )
                        ],
                      ),
                    )),
          ))
        ],
      ),
    );
  }
}