import 'package:flutter/material.dart';
import 'package:thor_coffee_donut/main_layout_controller.dart';

import '../home/home.dart';

class ThankYou extends StatelessWidget {
  static const routeName = "/thank-you";
  const ThankYou({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Thank You! Your order is received and is being taken care of... :D",
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.3,
          ),
          Container(
            height: size.height * 0.08,
            width: size.width * 1,
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainLayoutController.routeName, (route) => false);
              },
              child: const Text("Back to Home"),
            ),
          )
        ],
      ),
    );
  }
}
