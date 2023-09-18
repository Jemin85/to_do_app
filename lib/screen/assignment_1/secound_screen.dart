import 'package:flutter/material.dart';

class SecoundScreen extends StatefulWidget {
  const SecoundScreen({super.key});

  @override
  State<SecoundScreen> createState() => _SecoundScreenState();
}

class _SecoundScreenState extends State<SecoundScreen> {
  int _currantIndex = 0;
  List bottomSheet = [
    {"icon": Icons.home, "label": "Home"},
    {"icon": Icons.people, "label": "Comminity"},
    {"icon": Icons.people, "label": "Comminity"},
    {"icon": Icons.chat_bubble, "label": "Message"},
    {"icon": Icons.person, "label": "Profile"},
  ];

  List data = [
    {
      "main": "",
      "profile": "AD",
      "title": "ABC",
      "subtitle": "2 days to go",
      "heading": "Jonas. E Salk developed the which vaccine!",
      "sun-heading":
          "Loenm ipusm dolor sit then noq tro comw ticudilly of the cleaning dataa...",
      "image": "assets/images/image_1.jpg",
      "like": "1233",
      "comment": "80"
    },
    {
      "main": "Medical",
      "profile": "AD",
      "title": "ABC",
      "subtitle": "2 days to go",
      "heading": "Jonas. E Salk developed the which vaccine!",
      "sun-heading":
          "Loenm ipusm dolor sit then noq tro comw ticudilly of the cleaning dataa...",
      "image": "",
      "like": "1233",
      "comment": "80"
    },
    {
      "main": "",
      "profile": "AD",
      "title": "ABC",
      "subtitle": "2 days to go",
      "heading": "Jonas. E Salk developed the which vaccine!",
      "sun-heading":
          "Loenm ipusm dolor sit then noq tro comw ticudilly of the cleaning dataa...",
      "image": "assets/images/image_1.jpg",
      "like": "1233",
      "comment": "80"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/leading.png", height: 15),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Container(
          height: 60,
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
                bottomSheet.length,
                (index) => Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currantIndex = index;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Icon(bottomSheet[index]["icon"],
                                color: _currantIndex == index
                                    ? const Color.fromARGB(255, 13, 87, 214)
                                    : index == 2
                                        ? Colors.white
                                        : Colors.grey),
                            Text(index == 2
                                ? ""
                                : "${bottomSheet[index]["label"]}")
                          ],
                        ),
                      ),
                    ))),
          )),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: Color.fromARGB(255, 221, 220, 220)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data[index]["main"] != "")
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[100]),
                  child: Text(
                    "${data[index]["main"]}",
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 5,
                dense: true,
                isThreeLine: true,
                leading: CircleAvatar(
                  radius: 30,
                  child: Text(
                    "${data[index]["profile"]}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  "${data[index]["title"]}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  "${data[index]["subtitle"]}",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${data[index]["heading"]}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  text: "${data[index]["sun-heading"]}",
                  children: const [
                    TextSpan(
                      text: "more",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              if (data[index]["image"] != "")
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 13),
                  child:
                      Image.asset("${data[index]["image"]}", fit: BoxFit.cover),
                ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.grey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${data[index]["like"]}",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline,
                          color: Colors.grey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${data[index]["comment"]} Comments",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
