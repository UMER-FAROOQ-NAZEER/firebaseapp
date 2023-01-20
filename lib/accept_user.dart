import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/home.dart';
import 'package:flutter/material.dart';

class AcceptUser extends StatelessWidget {
  const AcceptUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accept User"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              textAlign: TextAlign.center,
              "List of Accepted user",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("ans").snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.isEmpty
                          ? const Text("No Data")
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                if (snapshot.data!.docs[index]["status"] ==
                                    "Approved") {
                                  return ListTile(
                                    tileColor: index.isEven
                                        ? Colors.pink.withOpacity(0.5)
                                        : Colors.lime,
                                    title: Text(
                                        snapshot.data!.docs[index]["name"]),
                                    subtitle: Text(
                                        snapshot.data!.docs[index]["phone"]),
                                    trailing: SizedBox(
                                      width: 190,
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: (() {
                                              // var ID =
                                              //     snapshot.data!.docs[index].id;
                                              // FirebaseFirestore.instance
                                              //     .collection("informatiion")
                                              //     .doc(ID)
                                              //     .update({"status": "Aprroved"});
                                            }),
                                            child: const Text(
                                              "Accepted",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          // TextButton(
                                          //   onPressed: (() {
                                          //     var ID =
                                          //         snapshot.data!.docs[index].id;
                                          //     FirebaseFirestore.instance
                                          //         .collection("informatiion")
                                          //         .doc(ID)
                                          //         .update(
                                          //             {"status": "Not approved"});
                                          //   }),
                                          //   child: const Text(
                                          //     "rejected",
                                          //     style: TextStyle(
                                          //         fontSize: 18,
                                          //         color: Colors.red),
                                          //   ),
                                          // ),
                                          // IconButton(
                                          //     onPressed: (() {
                                          //       var id =
                                          //           snapshot.data!.docs[index].id;
                                          //       FirebaseFirestore.instance
                                          //           .collection("Items")
                                          //           .doc(id)
                                          //           .update({
                                          //         "favorite": true,
                                          //       });

                                          //       FirebaseFirestore.instance
                                          //           .collection("favorite")
                                          //           .doc()
                                          //           .set({
                                          //         "item": snapshot
                                          //             .data!.docs[index]["item"],
                                          //         "prize": snapshot
                                          //             .data!.docs[index]["prize"],
                                          //         "uid": snapshot
                                          //             .data!.docs[index]["uid"],
                                          //         "favorite": snapshot.data!
                                          //             .docs[index]["favorite"],

                                          //       });

                                          //     }),
                                          //     icon: Icon(
                                          //       Icons.favorite,
                                          //       color: snapshot.data!.docs[index]
                                          //                   ["favorite"] ==
                                          //               true
                                          //           ? Colors.green
                                          //           : Colors.grey,
                                          //     ))
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text("Something went Wrong");
                    }
                  })),
            ),
            ElevatedButton(
                onPressed: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                }),
                child: const Text("back to home page")),
          ],
        ),
      ),
    );
  }
}
