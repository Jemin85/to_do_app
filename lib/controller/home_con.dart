import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  taskDOne({required Map object, required int index}) async {
    var collection = FirebaseFirestore.instance.collection('data');
    var snapshot =
        await collection.where("title", isEqualTo: object["title"]).get();
    for (var doc in snapshot.docs) {
      await doc.reference.update({"status": "Complete"});
    }
  }

  taskcanceld({required Map object, required int index}) async {
    var collection = FirebaseFirestore.instance.collection('data');
    var snapshot =
        await collection.where("title", isEqualTo: object["title"]).get();
    for (var doc in snapshot.docs) {
      await doc.reference.update({"status": "Cancelled"});
    }
  }

}
