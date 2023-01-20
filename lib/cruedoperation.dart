import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/toastapp.dart';
import 'package:flutter/material.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController updateitemNameController = TextEditingController();
  TextEditingController updateitemPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        children: [
          TextField(
            controller: itemNameController,
            decoration: const InputDecoration(label: Text("Item Name")),
          ),
          TextField(
            controller: itemPriceController,
            decoration: const InputDecoration(label: Text("Item Price")),
          ),
          ElevatedButton(
              onPressed: () {
                try {
                  FirebaseFirestore.instance.collection('item').doc().set({
                    'item': itemNameController.text,
                    'price': itemPriceController.text,
                  });
                  itemNameController.clear();
                  itemPriceController.clear();
                  AppToast.failToast(masg: "Item Save sucessfull");
                } catch (e) {
                  AppToast.failToast(masg: "Item Fail");
                }
              },
              child: const Text("Add")),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('items').snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? const Text("No record")
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              title: Text(snapshot.data!.docs[index]['item']),
                              subtitle:
                                  Text(snapshot.data!.docs[index]['price']),
                              trailing: SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          var docID =
                                              snapshot.data!.docs[index].id;
                                          print(docID);
                                          FirebaseFirestore.instance
                                              .collection('items')
                                              .doc(docID)
                                              .delete();
                                          AppToast.successToast(
                                              masg: "Item deleted");
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        var docID =
                                            snapshot.data!.docs[index].id;
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return Container(
                                                child: AlertDialog(
                                                  actions: [
                                                    TextField(
                                                      controller:
                                                          updateitemNameController,
                                                      decoration:
                                                          const InputDecoration(
                                                              label: Text(
                                                                  "Item Name")),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          updateitemPriceController,
                                                      decoration:
                                                          const InputDecoration(
                                                              label: Text(
                                                                  "Item price")),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'items')
                                                              .doc(docID)
                                                              .set({
                                                            'item':
                                                                updateitemNameController
                                                                    .text,
                                                            'price':
                                                                updateitemPriceController
                                                                    .text,
                                                          });
                                                          updateitemNameController
                                                              .clear();
                                                          updateitemPriceController
                                                              .clear();
                                                        },
                                                        child: const Text(
                                                            "update")),
                                                  ],
                                                ),
                                              );
                                            }));

                                        //print(docID);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {
                                            var docID =
                                                snapshot.data!.docs[index].id;
                                            print(docID);
                                            FirebaseFirestore.instance
                                                .collection('items')
                                                .doc(docID)
                                                .delete();
                                            AppToast.successToast(
                                                masg: "Item Favorite");
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.pink.withOpacity(0.1),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("Some thing rong");
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
