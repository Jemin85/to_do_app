// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'dart:typed_data';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class TaskAddController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController timeSelect = TextEditingController();
  TextEditingController date = TextEditingController();
  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  RxList randomSeed = [
    "gym",
    "homework",
    "school",
    "playing",
    "eating",
    "sleping",
    "swimming"
  ].obs;
  RxList selectedList = [].obs;

  var isLoad = false.obs;

  Future<void> showDateTimePicker({context}) async {
    DateTime lastDate = DateTime.now().add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: lastDate,
    );
    dateTime = selectedDate;
    date.text =
        "${selectedDate!.day}-${selectedDate.month}-${selectedDate.year}";
  }

  addDataList({required String data}) {
    if (selectedList.isNotEmpty) {
      selectedList.removeAt(0);
      selectedList.add(data);
    } else {
      selectedList.add(data);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null) {
      timeOfDay = picked_s;
      timeSelect.text = picked_s.format(context);
    }
  }

  Future<ByteData> loadAsset() async {
    return await rootBundle.load('assets/tune/tune.mp3');
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    developer.log('Alarm fired!');
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/tune/tune_2.mp3"),
      autoStart: true,
      volume: 100,
      respectSilentMode: false,
      showNotification: true,
    );
  }

  addTask() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection("data");
    users.add({
      "title": title.text,
      "desc": desc.text,
      "catogory": selectedList[0],
      "add_time": DateTime.now(),
      "date": date.text,
      "time": timeSelect.text,
      "status": "Pending"
    });
    await AndroidAlarmManager.oneShotAt(
        DateTime(dateTime!.year, dateTime!.month, dateTime!.day,
            timeOfDay!.hour, timeOfDay!.minute),
        Random().nextInt(pow(2, 31) as int),
        callback,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        alarmClock: true,
        allowWhileIdle: true);
    title.clear();
    desc.clear();
    selectedList = [].obs;
    date.clear();
    timeSelect.clear();
    Get.back();
  }
}
