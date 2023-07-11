import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../details_food_drink/details_food_drink.dart';
import '../providers/food_drink_provider.dart';

class Donut extends StatelessWidget {
  const Donut({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          Provider.of<FoodDrinkProvider>(context, listen: false).fetchDonuts(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Text("no");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 220,
              // crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailsFoodDrink.routeName,
                    arguments: {
                      'name': snapshot.data![index]['food_name'],
                      'price': snapshot.data![index]['price'].toString(),
                      'image': snapshot.data![index]['image'],
                      'details': snapshot.data![index]['details']
                    },
                  );
                },
                child: Container(
                  // height: 400,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    // color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      // color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "Donut",
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      Image(
                          width: 100,
                          height: 100,
                          image: NetworkImage(
                              snapshot.data![index]['image'].toString())),
                      Text(
                        snapshot.data![index]['food_name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 70,
                            child: Text(
                              "RM${snapshot.data![index]['price']}",
                              style: const TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<FoodDrinkProvider>(context,
                                      listen: false)
                                  .addItem(
                                      snapshot.data![index]['food_name']
                                          .toString(),
                                      double.parse(snapshot.data![index]
                                              ['price']
                                          .toString()),
                                      snapshot.data![index]['image']
                                          .toString());
                              Fluttertoast.showToast(
                                msg: snapshot.data![index]['food_name'] +
                                    " is added to the cart",
                                toastLength:
                                    Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                                gravity: ToastGravity
                                    .BOTTOM, // positioning of the toast
                                timeInSecForIosWeb:
                                    1, // duration of the toast on iOS and web
                                backgroundColor: Colors
                                    .black, // background color of the toast
                                textColor:
                                    Colors.white, // text color of the toast
                                fontSize:
                                    16.0, // font size of the toast message
                              );
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
