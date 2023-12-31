import 'package:flutter/material.dart';
import 'package:thor_coffee_donut/home/coffee.dart';
import 'package:thor_coffee_donut/home/donut.dart';
import 'package:thor_coffee_donut/search/search.dart';

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
        SizedBox(
          width: size.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Thor Coffee & Donut",
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Search.routeName),
                icon: const Icon(
                  Icons.search,
                ),
              )
            ],
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
                    child: const Text(
                      "Coffee",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => changePreference(true),
                    child: const Text(
                      "Donut",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            !isDonut
                ? SizedBox(
                    height: size.height * 0.68,
                    width: size.width * 0.8,
                    child: const Coffee(),
                  )
                : SizedBox(
                    height: size.height * 0.68,
                    width: size.width * 0.8,
                    child: const Donut(),
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
