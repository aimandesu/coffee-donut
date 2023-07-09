import 'package:flutter/material.dart';
import 'package:thor_coffee_donut/home/coffee.dart';
import 'package:thor_coffee_donut/home/donut.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDonut = false;

  void changePreference(bool isFalse) {
    setState(() {
      isDonut = isFalse;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "SHOP NAME",
            style: TextStyle(fontSize: 30),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // TextButton(
                  //   onPressed: null,
                  //   child: Text("Iced Coffee"),
                  // ),
                  TextButton(
                    onPressed: () => changePreference(false),
                    child: Text("Coffee"),
                  ),
                  TextButton(
                    onPressed: () => changePreference(true),
                    child: Text("Donut"),
                  ),
                ],
              ),
            ),
            !isDonut
                ? SizedBox(
                    height: size.height * 0.68,
                    width: size.width * 0.8,
                    child: Coffee(),
                  )
                : SizedBox(
                    height: size.height * 0.68,
                    width: size.width * 0.8,
                    child: Donut(),
                  )

            // Container(
            //   height: size.height * 0.3,
            //   child: IcedCoffee(),
            // )
          ],
        )
      ],
    );
  }
}
