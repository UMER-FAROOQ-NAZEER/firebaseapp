import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/accept_user.dart';
import 'package:firebaseapp/reject_user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const AcceptUser())));
              }),
              child: const Text("View accepted user")),
          ElevatedButton(
              onPressed: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const RejectUser())));
              }),
              child: const Text("View rejected user"))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "My Home Page",
                          ),
                        ],
                      ),
                      StreamBuilder<QuerySnapshot<Object?>>(
                        stream: FirebaseFirestore.instance
                            .collection("ans")
                            .snapshots(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (snapshot.data!.docs[index]["status"] ==
                                      "pending") {
                                    var id = snapshot.data!.docs[index].id
                                        .toString();
                                    return ListTile(
                                        tileColor: index.isEven
                                            ? Colors.green
                                            : Colors.blue,
                                        title: Text(
                                            snapshot.data!.docs[index]["name"]),
                                        subtitle: Text(snapshot
                                            .data!.docs[index]["phone"]),
                                        trailing: SizedBox(
                                            width: 210,
                                            child: Row(children: [
                                              TextButton(
                                                onPressed: () {
                                                  var ID = snapshot
                                                      .data!.docs[index].id;
                                                  FirebaseFirestore.instance
                                                      .collection("ans")
                                                      .doc(ID)
                                                      .update({
                                                    "status": "Approved"
                                                  });
                                                },
                                                child: const Text(
                                                  "Accepted",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 19),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  var ID = snapshot
                                                      .data!.docs[index].id;
                                                  FirebaseFirestore.instance
                                                      .collection("ans")
                                                      .doc(ID)
                                                      .update({
                                                    "status": "Not Approved"
                                                  });
                                                },
                                                child: const Text(
                                                  "rejected",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 19),
                                                ),
                                              ),
                                            ])));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return const Text("Something went wrong");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
