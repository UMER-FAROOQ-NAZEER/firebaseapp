import 'package:firebaseapp/authentication_services.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Signup Page"),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(), hintText: "name"),
                  controller: namecontroller,
                ),
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Type Your Email"),
                  controller: emailcontroller,
                ),
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(), hintText: "phone"),
                  controller: phonecontroller,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText: "Type Your Password"),
                  controller: passwordcontroller,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    await AuthenticationServices.SignUpPage(
                        context: context,
                        name: namecontroller.text,
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                        phone: phonecontroller.text);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green),
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
