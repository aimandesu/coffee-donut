import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/food_drink_provider.dart';

class DetailsFoodDrink extends StatelessWidget {
  static const routeName = "/details-food-drink";
  const DetailsFoodDrink({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String name = arguments['name'] as String;
    final String price = arguments['price'] as String;
    final String image = arguments['image'] as String;
    final String details = arguments['details'] as String;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: size.height * 0.5,
            width: size.width * 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image(
                fit: BoxFit.fill,
                width: 100,
                height: 100,
                image: NetworkImage(image),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: size.height * 0.4,
            width: size.width * 1,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                details,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: size.height * 0.1,
            width: size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    "RM$price",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<FoodDrinkProvider>(context, listen: false)
                          .addItem(name, double.parse(price), image);
                      Fluttertoast.showToast(
                        msg: "$name is added to the cart",
                        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                        gravity:
                            ToastGravity.BOTTOM, // positioning of the toast
                        timeInSecForIosWeb:
                            1, // duration of the toast on iOS and web
                        backgroundColor:
                            Colors.black45, // background color of the toast
                        textColor: Colors.white, // text color of the toast
                        fontSize: 16.0, // font size of the toast message
                      );
                    },
                    child: const Text("Add to cart"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
